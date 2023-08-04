import 'dart:html';

import "package:CommonLib/Utility.dart";
import "package:LoaderLib/Loader.dart";

import "icongenerator.dart";
import "iconset.dart";
import "itemlists.dart";
import "material.dart";
import "utils.dart";

Future<void> main() async {
  print("Processing Icons");

  final Map<ItemSet,IconGenerator> iconsToGenerate = <ItemSet,IconGenerator>{
    ItemSet.dull: new TestProcessor(),
    ItemSet.shiny: new TestProcessor(),
  };

  for (final ItemSet itemSet in iconsToGenerate.keys) {
    if (itemSet.items.isEmpty) { continue; }
    final GeneratedIconSet iconSet = new GeneratedIconSet(iconsToGenerate[itemSet]!);

    for (final String icon in itemSet.items) {
      final String path = "revised/material_sets/${itemSet.name}/$icon";
      await iconSet.processIcon("$path.png", "${path}_secondary.png");
    }

    print("Generated secondary textures for ${itemSet.name}");
    Loader.mountDataPack(iconSet.archive);
  }

  print("Start Page Generation");

  final Element topBarElement = querySelector("#topbar")!;
  final Element mainElement = querySelector("#main")!;

  // material sets
  final Map<String, List<Material>> materialSets = <String, List<Material>>{
    "original": OriginalMaterials.values,
    "revised": OriginalMaterials.values,
  };

  // process material names
  final Set<String> allMaterialNames = <String>{};

  for (final List<Material> materials in materialSets.values) {
    for (final Material material in materials) {
      allMaterialNames.add(material.name);
    }
  }

  final List<String> sortedMaterialNames = new List<String>.from(allMaterialNames)..sort();

  final Map<String,Element> materialElements = <String,Element>{};

  // search box
  final Element searchBox = Search.createListSearchBox(() => sortedMaterialNames, (Set<String>? searchResults) {
    if (searchResults == null) { return; }
    for (final String matName in materialElements.keys) {
      if (!searchResults.contains(matName)) {
        materialElements[matName]!.classes.add("hidden");
      }
      else {
        materialElements[matName]!.classes.remove("hidden");
      }
    }
  }, mapping: (String s) => s);

  topBarElement.append(searchBox);

  // set selector
  final SelectElement setSelector = new SelectElement();

  for (final String setName in materialSets.keys) {
    final OptionElement option = new OptionElement(data: setName, value: setName);
    setSelector.append(option);
  }

  void displayMaterialSet(String? set) {
    for (final Element element in querySelectorAll(".materialset")) {
      element.classes.add("hidden");
    }
    for (final Element element in querySelectorAll(".materialset.$set")) {
      element.classes.remove("hidden");
    }
  }

  setSelector.onChange.listen((Event e) {
    displayMaterialSet(setSelector.value);
  });

  topBarElement.append(setSelector);

  // process materials
  final Map<String,Map<String,Material>> materialsByName = getMaterialsByName(materialSets);

  await Future.wait(materialsByName.keys.map((String matName) async {

    final Element materialElement = await materialPreview(matName, materialsByName[matName]!);

    materialElements[matName] = materialElement;
  }));

  for (final Element e in materialElements.values) {
    mainElement.append(e);
  }

  displayMaterialSet(setSelector.value);
  print("Done");
}

Future<Element> materialPreview(String matName, Map<String,Material> materials) async {
  print("Processing material: $matName");

  final DivElement container = new DivElement()..className = "material";
  container.append(new HeadingElement.h2()..text = matName);

  for (final String materialSet in materials.keys) {
    final Element setContainer = new DivElement()..className="materialset $materialSet";
    final Material material = materials[materialSet]!;

    await Future.wait(ItemSet.allItems.map((String item) => itemPreview(item, materialSet, material))).then((List<Element> previews) {
      for (final Element e in previews) {
        setContainer.append(e);
      }
    } );

    container.append(setContainer);
  }

  //window.console.log(container);

  return container;
}

Future<Element> itemPreview(String item, String materialSet, Material mat) async {
  //print("Processing item: ${mat.name} $item");

  final DivElement container = new DivElement()..className = "icon ${mat.name} $item";

  final Map<String,String> layers = await getItemLayers(item, materialSet, mat);

  await Future.wait(layers.entries.map((MapEntry<String,String> entry) async {
    final String url = "$materialSet/material_sets/${entry.value}.png";
    final ImageElement? icon = await Loader.getResource(url);
    if (icon != null) {
      return new DivElement()..className = "img ${entry.key}"..style.backgroundImage = "url(${icon.src})"..style.maskImage = "url(${icon.src})";
    }
  })).then((List<Element?> elements) {
    for (final Element? element in elements) {
      if (element != null) {
        container.append(element);
      }
    }
  });

  return container;
}

Future<Map<String,String>> getItemLayers(String item, String materialSet, Material mat) async {
  final Map<String,String> layers = <String,String>{};

  await _getItemLayers(item, materialSet, mat.iconSet, layers);

  return layers;
}

Future<void> _getItemLayers(String fileName, String materialSet, IconSet iconSet, Map<String,String> layers) async {
  try {
    final String path = "$materialSet/models/${iconSet.name}/$fileName.json";
    final Map<String, dynamic> json = await Loader.getResource(path, format: Formats.json);

    if (json.containsKey("parent")) {
      final String parent = json["parent"];
      if ( parent != "item/generated") {
        //_getItemLayers();
        if (parent.startsWith("gtceu:item/material_sets/")) {
          final String path = parent.substring(25);
          final List<String> parts = path.split("/");
          //print(parts);
          final IconSet set = IconSet.values.where((IconSet set) => set.name == parts.first).first;
          //print(set);
          
          await _getItemLayers(parts.last, materialSet, set, layers);
        }
      }
    }

    if (json.containsKey("textures")) {
      final Map<String,dynamic> textures = json["textures"];
      //print(textures);
      for (final String key in textures.keys) {
        final String path = textures[key]!;

        if (path.startsWith("gtceu:item/material_sets/")) {
          layers[key] = path.substring(25);
        }
        else {
          print("Unexpected icon format: $path");  
        }
      }
    }
  }
  on Exception {
    //print("caught error for ${iconSet.name}, file: $fileName, parent: ${iconSet.parent}");
    if (iconSet.parent != null) {
      await _getItemLayers(fileName, materialSet, iconSet.parent!, layers);
    }
  }
}

Map<String, Map<String,Material>> getMaterialsByName(Map<String,List<Material>> materialSets) {
  final Map<String,Map<String,Material>> materialMapping = <String,Map<String,Material>>{};

  for(final String setName in materialSets.keys) {
    final List<Material> materials = materialSets[setName]!;

    for (final Material mat in materials) {
      if (!materialMapping.containsKey(mat.name)) {
        materialMapping[mat.name] = <String,Material>{};
      }
      materialMapping[mat.name]![setName] = mat;
    }
  }

  return materialMapping;
}