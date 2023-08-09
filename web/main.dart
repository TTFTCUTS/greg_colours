import 'dart:html';

import "package:CommonLib/Utility.dart";
import "package:LoaderLib/Loader.dart";

import "icongenerator.dart";
import "iconset.dart";
import "itemlists.dart";
import "original_materials.dart";
import "revised_materials.dart";
import "utils.dart";

Future<void> main() async {
  print("Processing Icons");

  final Map<ItemSet,IconGenerator> iconsToGenerate = <ItemSet,IconGenerator>{
    ItemSet.bright: IconGenerator.linear,
    ItemSet.certus: IconGenerator.linear,
    ItemSet.diamond: IconGenerator.linear,
    ItemSet.dull: IconGenerator.linear,
    ItemSet.emerald: IconGenerator.linear,
    ItemSet.fine: IconGenerator.linear,
    ItemSet.flint: IconGenerator.linear,
    ItemSet.gem_horizontal: IconGenerator.linear,
    ItemSet.gem_vertical: IconGenerator.linear,
    ItemSet.lapis: IconGenerator.linear,
    ItemSet.lignite: IconGenerator.linear,
    ItemSet.metallic: IconGenerator.raiseMidtones,
    ItemSet.netherstar: IconGenerator.linear,
    ItemSet.quartz: IconGenerator.linear,
    ItemSet.rough: IconGenerator.linear,
    ItemSet.ruby: IconGenerator.linear,
    ItemSet.sand: IconGenerator.linear,
    ItemSet.shiny: IconGenerator.raiseMidtones,
    ItemSet.wood: IconGenerator.linear,
    ItemSet.radioactive: IconGenerator.radioactive,
  };

  for (final ItemSet itemSet in iconsToGenerate.keys) {
    if (itemSet.items.isEmpty) { continue; }
    final GeneratedIconSet iconSet = new GeneratedIconSet(iconsToGenerate[itemSet]!);

    for (final String icon in itemSet.items) {
      IconSet candidateSet = IconSet.values.where((IconSet i) => i.name == itemSet.name).first;
      while(true) {
        try {
          await Loader.getResource("revised/material_sets/${candidateSet.name}/$icon.png", format: Formats.png);
          break;
        }
        on Exception {
          if (candidateSet.parent != null) {
            candidateSet = candidateSet.parent!;
          } else {
            throw Exception("No valid icon found for ItemSet ${itemSet.name} -> $icon");
          }
        }
      }
      final String path = "revised/material_sets/${candidateSet.name}/$icon.png";
      final String outPath = "revised/material_sets/${itemSet.name}/${icon}_secondary.png";
      print("Processing icon for set ${itemSet.name}: $path -> $outPath");
      await iconSet.processIcon(path, outPath);
    }

    print("Generated secondary textures for ${itemSet.name}");
    Loader.mountDataPack(iconSet.archive);
  }

  print("Start Page Generation");

  final Element topBarElement = querySelector("#topbar")!;
  final Element mainElement = querySelector("#main")!;

  // material sets
  final Map<String, List<Material>> materialSets = <String, List<Material>>{
    "revised": RevisedMaterials.values,
    "original": OriginalMaterials.values,
  };

  // process material names
  final Set<String> allMaterialNames = <String>{};

  for (final List<Material> materials in materialSets.values) {
    for (final Material material in materials) {
      allMaterialNames.add(material.name);
    }
  }

  final List<String> sortedMaterialNames = new List<String>.from(allMaterialNames)..sort();
  final Map<String,Map<String,Material>> materialsByName = getMaterialsByName(materialSets);

  final Map<String,Element> materialElements = <String,Element>{};

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

  // search box
  String getSearchTermForMaterialName(String name) {
    final String? currentSet = setSelector.value;

    String setTag = "";
    if (currentSet != null && materialsByName.containsKey(name) && materialsByName[name]!.containsKey(currentSet)) {
      setTag = "#${materialsByName[name]![currentSet]!.iconSet.name}";
    }

    return "$name $setTag";
  }

  void updateSearchResults(Set<String>? searchResults) {
    if (searchResults == null) { return; }
    for (final String matName in materialElements.keys) {
      if (!searchResults.any((String s) => s.split(" ").first == matName)) {
        materialElements[matName]!.classes.add("hidden");
      }
      else {
        materialElements[matName]!.classes.remove("hidden");
      }
    }
  }

  final Element searchBox = Search.createListSearchBox(() => sortedMaterialNames.map(getSearchTermForMaterialName), updateSearchResults, mapping: (String s) => s);

  topBarElement.append(searchBox);
  topBarElement.append(setSelector);
  topBarElement.append(new ButtonElement()..text="Update CSS"..onClick.listen((_) { reloadCSS(); }));

  // process materials
  await Future.wait(sortedMaterialNames.map((String matName) async {

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
      final String noAlpha = await getNoAlphaUrl(icon);
      //print("$materialSet ${mat.name} $item w: ${icon.width}, h: ${icon.height}");
      final int frames = icon.height! ~/ icon.width!;

      final DivElement iconElement = new DivElement()
        ..className = "img ${entry.key}"
        ..style.backgroundImage = "url($noAlpha)"
        ..style.maskImage = "url(${icon.src})";

      if (frames > 1) {
        final String animationName = "frames_$frames";

        iconElement
          ..style.height = "${100 * frames}%"
          ..style.backgroundPosition = "0% 0%"
          ..style.maskPosition = "0% 0%"
          ..style.animation = "1s steps($frames, end) infinite animateFrames"
        ;
        print("finished animation $animationName");
      }

      return iconElement;
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

final Map<String,Future<String>> noAlphaBlobs = <String,Future<String>>{};
Future<String> getNoAlphaUrl(ImageElement source) async {
  if (source.src == null) { throw Exception("No src in input image for getNoAlphaUrl"); }

  final String key = source.src!;
  if (!noAlphaBlobs.containsKey(key)) {
    //print("Generating no alpha for $key");
    noAlphaBlobs[key] = imgToNoAlphaUrl(source);
  }
  return noAlphaBlobs[key]!;
}

Future<String> imgToNoAlphaUrl(CanvasImageSource source) async {
  final int width = source.width!;
  final int height = source.height!;
  final CanvasElement canvas = new CanvasElement(width: width, height: height);
  final CanvasRenderingContext2D ctx = canvas.context2D;

  ctx.drawImage(source, 0, 0);

  final ImageData imgData = ctx.getImageData(0, 0, width, height);

  for (int i=3; i<imgData.data.length; i+=4) {
    imgData.data[i] = 255;
  }

  ctx.putImageData(imgData, 0, 0);

  return Loader.createBlobUrl(await canvas.toBlob());
}