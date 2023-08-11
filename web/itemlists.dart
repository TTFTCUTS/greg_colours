import "utils.dart";

enum ItemSet with EnumName {
  // icons to process for each icon set
  bright(<String>["ingot"]),
  certus(<String>["gem"]),
  diamond(<String>["gem", "raw_ore"]),
  dull(allItems),
  emerald(<String>["gem"]),
  fine(<String>["dust","dust_small","dust_tiny","gem","gem_chipped","gem_flawed","raw_ore"]),
  flint(<String>["gem"]),
  gem_horizontal(<String>["gem"]),
  gem_vertical(<String>["gem"]),
  glass(<String>[]),
  lapis(<String>["gem"]),
  lignite(<String>["gem"]),
  magnetic(<String>[]),
  metallic(<String>["bolt","dust","dust_small","dust_tiny","ingot","ingot_double","nugget","plate","plate_dense","plate_double","raw_ore","rod",
    "rod_long","round","screw"]),
  netherstar(<String>["gem"]),
  opal(<String>[]),
  quartz(<String>["dust","dust_small","dust_tiny","gem"]),
  rough(<String>["dust","dust_small","dust_tiny","gear","gear_small","ingot","plate","plate_dense","plate_double"]),
  ruby(<String>["gem"]),
  sand(<String>["crushed","crushed_refined","dust","dust_impure","dust_pure","dust_small","dust_tiny"]),
  shiny(<String>["bolt","dust","dust_small","dust_tiny","foil","gear","gear_small","ingot","ingot_double","nugget","plate","plate_dense","plate_double","raw_ore",
    "ring","rod","rod_long","round","screw"]),
  wood(<String>["gear","plate","plate_double","rod","rod_long","screw"]),
  radioactive(allItems);

  static const List<String> allItems = <String>["bolt", "crushed", "crushed_purified", "crushed_refined", "dust", "dust_impure", "dust_pure", "dust_small", "dust_tiny", "foil",
    "gear", "gear_small", "gem", "gem_chipped", "gem_exquisite", "gem_flawed", "gem_flawless", "ingot", "ingot_double", "ingot_hot", "lens", "nugget", "plate", "plate_dense",
    "plate_double", "raw_ore", "ring", "rod", "rod_long", "rotor", "round", "screw", "spring", "spring_small", "tool_head_buzz_saw", "tool_head_chainsaw", "tool_head_drill",
    "tool_head_screwdriver", "tool_head_wrench", "turbine_blade", "wire_fine"];
  
  final List<String> items;
  
  const ItemSet(List<String> this.items);
}