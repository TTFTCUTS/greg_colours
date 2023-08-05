// ignore_for_file: constant_identifier_names

import "dart:html";

import "package:LoaderLib/Loader.dart";

import "utils.dart";

enum IconSet with EnumName {
  dull(),
  metallic(dull),
  magnetic(metallic),
  shiny(metallic),
  bright(shiny),
  diamond(shiny),
  emerald(diamond),
  gem_horizontal(emerald),
  gem_vertical(emerald),
  ruby(emerald),
  opal(ruby),
  glass(ruby),
  netherstar(glass),
  fine(dull),
  sand(fine),
  wood(fine),
  rough(fine),
  flint(rough),
  lignite(rough),
  quartz(rough),
  certus(quartz),
  lapis(quartz),
  fluid(dull),
  gas(dull),
  radioactive(shiny); //metallic once icons are fixed

  final IconSet? parent;

  const IconSet([IconSet? this.parent]);

  Future<ImageElement?> getIcon(String name) async {
    try {
      return await Loader.getResource<ImageElement>("material_sets/${this.name}/$name.png");
    }
    on Exception {
      if (this.parent != null) {
        return parent!.getIcon(name);
      }
      return null;
    }
  }

}