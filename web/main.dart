import 'dart:html';

import "package:CommonLib/Utility.dart";
import "package:LoaderLib/Loader.dart";

import "iconset.dart";
import "material.dart";

Future<void> main() async {
  final Element topBarElement = querySelector("#topbar")!;
  final Element mainElement = querySelector("#main")!;

  print("begin");
  final List<Material> sortedMaterials = new List<Material>.from(Material.values)..sort((Material a, Material b) => a.name.compareTo(b.name));

  final Map<Material,Element> materialElements = <Material,Element>{};

  final Element searchBox = Search.createListSearchBox(() => sortedMaterials, (Set<Material>? searchResults) {
    if (searchResults == null) { return; }
    for (final Material mat in materialElements.keys) {
      if (!searchResults.contains(mat)) {
        materialElements[mat]!.classes.add("hidden");
      }
      else {
        materialElements[mat]!.classes.remove("hidden");
      }
    }
  }, mapping: (Material mat) => mat.name);

  topBarElement.append(searchBox);

  await Future.wait(sortedMaterials.map((Material mat) async {
    final Element materialElement = await materialPreview(mat);

    materialElements[mat] = materialElement;
  }));

  for (final Element e in materialElements.values) {
    mainElement.append(e);
  }

  print("done");
}

const List<String> itemTypes = <String>["bolt", "crushed", "crushed_purified", "crushed_refined", "dust", "dust_impure", "dust_pure", "dust_small", "dust_tiny", "foil", "gear",
  "gear_small", "gem", "gem_chipped", "gem_exquisite", "gem_flawed", "gem_flawless", "ingot", "ingot_double", "ingot_hot", "lens", "nugget", "plate", "plate_dense", "plate_double",
  "raw_ore", "ring", "rod", "rod_long", "rotor", "round", "screw", "spring", "spring_small", "tool_head_buzz_saw", "tool_head_chainsaw", "tool_head_drill", "tool_head_screwdriver",
  "tool_head_wrench", "turbine_blade", "wire_fine"];

Future<Element> materialPreview(Material mat) async {
  print("Processing material: ${mat.name}");

  final DivElement container = new DivElement()..className = "material";
  container.append(new HeadingElement.h2()..text = mat.name);

  await Future.wait(itemTypes.map((String item) => itemPreview(item, mat))).then((List<Element> previews) {
    for (final Element e in previews) {
      container.append(e);
    }
  } );

  //window.console.log(container);

  return container;
}

Future<Element> itemPreview(String item, Material mat) async {
  //print("Processing item: ${mat.name} $item");

  final DivElement container = new DivElement()..className = "icon ${mat.name} $item";

  final Map<String,String> layers = await getItemLayers(item, mat);

  await Future.wait(layers.entries.map((MapEntry<String,String> entry) async {
    final String url = "material_sets/${entry.value}.png";
    final ImageElement? icon = await Loader.getResource(url);
    if (icon != null) {
      return new DivElement()..className = "img ${entry.key}"..style.backgroundImage = "url($url)"..style.maskImage = "url($url)";
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

Future<Map<String,String>> getItemLayers(String item, Material mat) async {
  final Map<String,String> layers = <String,String>{};

  await _getItemLayers(item, mat.iconSet, layers);

  return layers;
}

Future<void> _getItemLayers(String fileName, IconSet iconSet, Map<String,String> layers) async {
  try {
    final String path = "models/${iconSet.name}/$fileName.json";
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
          
          await _getItemLayers(parts.last, set, layers);
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
      await _getItemLayers(fileName, iconSet.parent!, layers);
    }
  }
}