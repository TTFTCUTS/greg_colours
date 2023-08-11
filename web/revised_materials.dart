// ignore_for_file: constant_identifier_names

import "iconset.dart";
import "utils.dart";

enum RevisedMaterials with Material {
  // ELEMENTS
  actinium.metallic(),
  aluminium(),
  americium.radioactive(),
  antimony.shiny(),
  argon.gas(),
  arsenic(),
  astatine(),
  barium.metallic(),
  berkelium.radioactive(),
  beryllium.metallic(),
  bismuth.metallic(),
  bohrium.radioactive(),
  boron(),
  bromine.shiny(),
  caesium.shiny(),
  calcium.metallic(),
  californium.radioactive(),
  carbon(),
  cadmium.shiny(),
  cerium.metallic(),
  chlorine.gas(),
  chromium.shiny(),
  cobalt.metallic(),
  copernicum(),
  copper.bright(),
  curium.radioactive(),
  darmstadtium(),
  deuterium.gas(),
  dubnium.radioactive(),
  dysprosium.metallic(),
  einsteinium.radioactive(),
  erbium.metallic(),
  europium.metallic(),
  fermium.metallic(),
  flerovium.radioactive(),
  fluorine.gas(),
  francium.radioactive(),
  gadolinium.metallic(),
  gallium.shiny(),
  germanium.shiny(),
  gold.shiny(),
  hafnium.shiny(),
  hassium(),
  holmium.metallic(),
  hydrogen.gas(),
  helium.gas(),
  helium3.gas(),
  indium.shiny(),
  iodine.shiny(),
  iridium.metallic(),
  iron.metallic(),
  krypton.gas(),
  lanthanum.metallic(),
  lawrencium.radioactive(),
  lead(),
  lithium(),
  livermorium.radioactive(),
  lutetium.metallic(),
  magnesium.fine(),
  mendelevium.radioactive(),
  manganese(),
  meitnerium.radioactive(),
  mercury.fluid(),
  molybdenum.shiny(),
  moscovium.radioactive(),
  neodymium.metallic(),
  neon.gas(),
  neptunium.radioactive(),
  nickel.metallic(),
  nihonium.radioactive(),
  niobium.metallic(),
  nitrogen.gas(),
  nobelium.radioactive(),
  oganesson.radioactive(),
  osmium.metallic(),
  oxygen.gas(),
  palladium.shiny(),
  phosphorus(),
  polonium(),
  platinum.shiny(),
  plutonium239.radioactive(),
  plutonium241.radioactive(),
  potassium.metallic(),
  praseodymium.metallic(),
  promethium.radioactive(),
  protactinium.radioactive(),
  radon.gas(),
  radium.radioactive(),
  rhenium.shiny(),
  rhodium.bright(),
  roentgenium.radioactive(),
  rubidium.shiny(),
  ruthenium.shiny(),
  rutherfordium.radioactive(),
  samarium.metallic(),
  scandium.metallic(),
  seaborgium.radioactive(),
  selenium.shiny(),
  silicon.metallic(),
  silver.shiny(),
  sodium.metallic(),
  strontium.metallic(),
  sulfur(),
  tantalum.metallic(),
  technetium.radioactive(),
  tellurium.radioactive(),
  tennessine.radioactive(),
  terbium.metallic(),
  thorium.shiny(),
  thallium.shiny(),
  thulium.metallic(),
  tin(),
  titanium.metallic(),
  tritium.metallic(),
  tungsten.metallic(),
  uranium238.radioactive(),
  uranium235.radioactive(),
  vanadium.metallic(),
  xenon.gas(),
  yttrium.metallic(),
  zinc.metallic(),
  zirconium.metallic(),
  naquadah.metallic(),
  enriched_naquadah.metallic(),
  naquadria.radioactive(),
  neutronium(),
  tritanium.metallic(),
  duranium.bright(),
  trinium.shiny(),

  // FIRST DEGREE MATERIALS
  almandine(),
  andradite.rubySet(),
  annealed_copper.bright(),
  asbestos(),
  ash(),
  hematite(),
  battery_alloy(),
  blue_topaz.gem_horizontal(),
  bone(),
  brass.shiny(),
  bronze.metallic(),
  goethite.metallic(),
  calcite(),
  cassiterite.rough(),
  cassiterite_sand.sand(),
  chalcopyrite(),
  charcoal.fine(),
  chromite.metallic(),
  cinnabar.emeraldSet(),
  water.fluid(),
  liquid_oxygen.fluid(),
  coal.ligniteSet(),
  cobaltite.metallic(),
  cooperite.metallic(),
  cupronickel.metallic(),
  dark_ash(),
  diamond.diamondSet(),
  electrum.shiny(),
  emerald.emeraldSet(),
  galena(),
  garnierite.metallic(),
  green_sapphire.gem_horizontal(),
  grossular.rubySet(),
  ice.shiny(),
  ilmenite.metallic(),
  rutile.gem_horizontal(),
  bauxite(),
  invar.metallic(),
  kanthal.metallic(),
  lazurite.lapisSet(),
  magnalium(),
  magnesite.rough(),
  magnetite.metallic(),
  molybdenite.metallic(),
  nichrome.metallic(),
  niobium_nitride(),
  niobium_titanium(),
  obsidian.shiny(),
  phosphate(),
  platinum_raw.metallic(),
  sterling_silver.shiny(),
  rose_gold.shiny(),
  black_bronze.metallic(),
  bismuth_bronze.metallic(),
  biotite.metallic(),
  powellite(),
  pyrite.rough(),
  pyrolusite(),
  pyrope.rubySet(),
  rock_salt.fine(),
  ruridit.bright(),
  ruby.rubySet(),
  salt.fine(),
  saltpeter.fine(),
  sapphire.gem_vertical(),
  scheelite(),
  sodalite.lapisSet(),
  aluminium_sulfite(),
  tantalite.metallic(),
  coke.ligniteSet(),
  soldering_alloy(),
  spessartine.rubySet(),
  sphalerite(),
  stainless_steel.shiny(),
  steel.metallic(),
  stibnite.metallic(),
  tetrahedrite(),
  tin_alloy.metallic(),
  topaz.gem_horizontal(),
  tungstate(),
  ultimet.shiny(),
  uraninite.metallic(),
  uvarovite.rubySet(),
  vanadium_gallium.shiny(),
  wrought_iron.metallic(),
  wulfenite(),
  yellow_limonite.metallic(),
  yttrium_barium_cuprate.metallic(),
  nether_quartz.quartz(),
  certus_quartz.certus(),
  quartzite.quartz(),
  graphite(),
  graphene.shiny(),
  tungstic_acid.shiny(),
  osmiridium.metallic(),
  lithium_chloride.fine(),
  calcium_chloride.fine(),
  bornite.rough(),
  chalcocite.gem_vertical(),
  gallium_arsenide(),
  potash(),
  soda_ash(),
  indium_gallium_phosphide(),
  nickel_zinc_ferrite(),
  silicon_dioxide.quartz(),
  magnesium_chloride(),
  sodium_sulfide(),
  phosphorus_pentoxide(),
  quicklime(),
  sodium_bisulfate(),
  ferrite_mixture.metallic(),
  magnesia(),
  platinum_group_sludge.fine(),
  realgar.emeraldSet(),
  sodium_bicarbonate.rough(),
  potassium_dichromate(),
  calcium_trioxide(),
  antimony_trioxide(),
  zincite(),
  cupric_oxide(),
  cobalt_oxide(),
  arsenic_trioxide.rough(),
  massicot(),
  ferrosilite(),
  metal_mixture.metallic(),
  sodium_hydroxide(),
  sodium_persulfate.fluid(),
  bastnasite.fine(),
  pentlandite(),
  spodumene(),
  lepidolite.fine(),
  glauconite_sand.sand(),
  malachite.lapisSet(),
  mica.fine(),
  barite(),
  alunite.metallic(),
  talc.fine(),
  soapstone(),
  kyanite.flintSet(),
  magnetic_iron.magnetic(),
  tungsten_carbide.metallic(),
  carbon_dioxide.gas(),
  titanium_tetrachloride.fluid(),
  nitrogen_dioxide.gas(),
  hydrogen_sulfide.gas(),
  nitric_acid.fluid(),
  sulfuric_acid.fluid(),
  sulfur_dioxide.gas(),
  carbon_monoxide.gas(),
  hypochlorous_acid.fluid(),
  ammonia.gas(),
  hydrofluoric_acid.fluid(),
  nitric_oxide.gas(),
  iron_iii_chloride.fluid(),
  uranium_hexafluoride.gas(),
  enriched_uranium_hexafluoride.gas(),
  depleted_uranium_hexafluoride.gas(),
  nitrous_oxide.gas(),
  ender_pearl(),
  potassium_feldspar.fine(),
  magnetic_neodymium.magnetic(),
  hydrochloric_acid.fluid(),
  steam.gas(),
  distilled_water.fluid(),
  sodium_potassium.fluid(),
  magnetic_samarium.magnetic(),
  manganese_phosphide.metallic(),
  magnesium_diboride.metallic(),
  mercury_barium_calcium_cuprate.shiny(),
  uranium_triplatinum.radioactive(),
  samarium_iron_arsenic_oxide.shiny(),
  indium_tin_barium_titanium_cuprate.metallic(),
  uranium_rhodium_dinaquadide(),
  enriched_naquadah_trinium_europium_duranide.metallic(),
  ruthenium_trinium_americium_neutronate.bright(),
  inert_metal_mixture.metallic(),
  rhodium_sulfate.fluid(),
  ruthenium_tetroxide(),
  osmium_tetroxide.metallic(),
  iridium_chloride.fine(),
  fluoroantimonic_acid.fluid(),
  titanium_trifluoride.shiny(),
  calcium_phosphide.metallic(),
  indium_phosphide.shiny(),
  barium_sulfide.metallic(),
  trinium_sulfide.shiny(),
  zinc_sulfide(),
  gallium_sulfide.shiny(),
  antimony_trifluoride.metallic(),
  enriched_naquadah_sulfate.metallic(),
  naquadria_sulfate.shiny(),
  pyrochlore.metallic(),
  liquid_helium.fluid(),

  // HIGHER DEGREE MATERIALS
  electrotine.shiny(),
  ender_eye(),
  diatomite(),
  red_steel.metallic(),
  blue_steel.metallic(),
  basalt.rough(),
  granitic_mineral_sand.sand(),
  redrock.rough(),
  garnet_sand.sand(),
  hssg.metallic(),
  red_alloy.metallic(),
  basaltic_mineral_sand.sand(),
  hsse.metallic(),
  hsss.metallic(),
  iridium_metal_residue.metallic(),
  granite.rough(),
  brick.rough(),
  fireclay.rough(),
  diorite.rough(),
  blue_alloy.metallic(),

  // ORGANIC CHEMISTRY MATERIALS
  silicone_rubber(),
  nitrobenzene.gas(),
  raw_rubber(),
  raw_styrene_butadiene_rubber(),
  styrene_butadiene_rubber(),
  polyvinyl_acetate.fluid(),
  reinforced_epoxy_resin(),
  polyvinyl_chloride(),
  polyphenylene_sulfide(),
  glyceryl_trinitrate.fluid(),
  polybenzimidazole(),
  polydimethylsiloxane(),
  polyethylene(),
  epoxy(),
  polycaprolactam(),
  polytetrafluoroethylene(),
  sugar.fine(),
  methane.gas(),
  epichlorohydrin.fluid(),
  monochloramine.gas(),
  chloroform.fluid(),
  cumene.gas(),
  tetrafluoroethylene(),
  chloromethane.gas(),
  allyl_chloride.fluid(),
  isoprene.fluid(),
  propane.gas(),
  propene.gas(),
  ethane.gas(),
  butene.gas(),
  butane.gas(),
  dissolved_calcium_acetate.fluid(),
  vinyl_acetate.fluid(),
  methyl_acetate.fluid(),
  ethenone.fluid(),
  tetranitromethane.fluid(),
  dimethylamine.gas(),
  dimethylhydrazine.fluid(),
  dinitrogen_tetroxide.gas(),
  dimethyldichlorosilane.gas(),
  styrene.fluid(),
  butadiene.gas(),
  dichlorobenzene.fluid(),
  acetic_acid.fluid(),
  phenol.fluid(),
  bisphenol_a.fluid(),
  vinyl_chloride.gas(),
  ethylene.gas(),
  benzene.fluid(),
  acetone.fluid(),
  glycerol.fluid(),
  methanol.fluid(),
  ethanol.fluid(),
  toluene.fluid(),
  diphenyl_isophthalate.fluid(),
  phthalic_acid.fluid(),
  dimethylbenzene.fluid(),
  diaminobenzidine.fluid(),
  dichlorobenzidine.fluid(),
  nitrochlorobenzene.fluid(),
  chlorobenzene.fluid(),
  octane.fluid(),
  ethyl_tertbutyl_ether.fluid(),
  ethylbenzene.fluid(),
  naphthalene.fluid(),
  rubber(),
  cyclohexane(),
  nitrosyl_chloride.gas(),
  cyclohexanone_oxime.rough(),
  caprolactam(),
  butyraldehyde.fluid(),
  polyvinyl_butyral(),

  // SECOND DEGREE MATERIALS
  glass.glassSet(),
  perlite(),
  borax.fine(),
  salt_water.fluid(),
  olivine.rubySet(),
  opal.opalSet(),
  amethyst.rubySet(),
  lapis.lapisSet(),
  blaze.fine(),
  apatite.diamondSet(),
  black_steel.metallic(),
  damascus_steel.metallic(),
  tungsten_steel.metallic(),
  cobalt_brass.metallic(),
  tricalcium_phosphate.flintSet(),
  red_garnet.rubySet(),
  yellow_garnet.rubySet(),
  marble.rough(),
  deepslate.rough(),
  granite_red.rough(),
  vanadium_magnetite.metallic(),
  quartz_sand.sand(),
  pollucite(),
  bentonite.rough(),
  fullers_earth.fine(),
  pitchblende(),
  monazite.diamondSet(),
  mirabilite(),
  trona.metallic(),
  gypsum(),
  zeolite(),
  concrete.rough(),
  magnetic_steel.magnetic(),
  vanadium_steel.shiny(),
  potin.metallic(),
  borosilicate_glass.shiny(),
  andesite.rough(),
  naquadah_alloy.metallic(),
  sulfuric_nickel_solution.fluid(),
  sulfuric_copper_solution.fluid(),
  lead_zinc_solution.fluid(),
  nitration_mixture.fluid(),
  diluted_sulfuric_acid.fluid(),
  diluted_hydrochloric_acid.fluid(),
  flint.flintSet(),
  air.gas(),
  liquid_air.fluid(),
  nether_air.gas(),
  liquid_nether_air.fluid(),
  ender_air.gas(),
  liquid_ender_air.fluid(),
  aqua_regia.fluid(),
  platinum_sludge_residue(),
  palladium_raw.metallic(),
  rarest_metal_mixture.shiny(),
  ammonium_chloride(),
  acidic_osmium_solution.fluid(),
  rhodium_plated_palladium.shiny(),
  clay.rough(),
  redstone.rough(),

  // UNKNOWN COMPOSITION MATERIALS
  wood_gas.gas(),
  wood_vinegar.fluid(),
  wood_tar.fluid(),
  charcoal_byproducts.fluid(),
  biomass.fluid(),
  bio_diesel.fluid(),
  fermented_biomass.fluid(),
  creosote.fluid(),
  diesel.fluid(),
  rocket_fuel.fluid(),
  glue.fluid(),
  lubricant.fluid(),
  mc_guffium_239.fluid(),
  indium_concentrate.fluid(),
  seed_oil.fluid(),
  drilling_fluid.fluid(),
  construction_foam.fluid(),
  sulfuric_heavy_fuel.fluid(),
  heavy_fuel.fluid(),
  lightly_hydro_cracked_heavy_fuel.fluid(),
  severely_hydro_cracked_heavy_fuel.fluid(),
  lightly_steam_cracked_heavy_fuel.fluid(),
  severely_steam_cracked_heavy_fuel.fluid(),
  sulfuric_light_fuel.fluid(),
  light_fuel.fluid(),
  lightly_hydro_cracked_light_fuel.fluid(),
  severely_hydro_cracked_light_fuel.fluid(),
  lightly_steam_cracked_light_fuel.fluid(),
  severely_steam_cracked_light_fuel.fluid(),
  sulfuric_naphtha.fluid(),
  naphtha.fluid(),
  lightly_hydro_cracked_naphtha.fluid(),
  severely_hydro_cracked_naphtha.fluid(),
  lightly_steam_cracked_naphtha.fluid(),
  severely_steam_cracked_naphtha.fluid(),
  sulfuric_gas.gas(),
  refinery_gas.gas(),
  lightly_hydro_cracked_gas.gas(),
  severely_hydro_cracked_gas.gas(),
  lightly_steam_cracked_gas.gas(),
  severely_steam_cracked_gas.gas(),
  hydro_cracked_ethane.gas(),
  hydro_cracked_ethylene.gas(),
  hydro_cracked_propene.gas(),
  hydro_cracked_propane.gas(),
  hydro_cracked_butane.gas(),
  hydro_cracked_butene.gas(),
  hydro_cracked_butadiene.gas(),
  steam_cracked_ethane.gas(),
  steam_cracked_ethylene.gas(),
  steam_cracked_propene.gas(),
  steam_cracked_propane.gas(),
  steam_cracked_butane.gas(),
  steam_cracked_butene.gas(),
  steam_cracked_butadiene.gas(),
  lpg.gas(),
  raw_growth_medium.fluid(),
  sterilized_growth_medium.fluid(),
  oil.fluid(),
  oil_heavy.fluid(),
  oil_medium.fluid(),
  oil_light.fluid(),
  natural_gas.gas(),
  bacteria.fluid(),
  bacterial_sludge.fluid(),
  enriched_bacterial_sludge.fluid(),
  mutagen.fluid(),
  gelatin_mixture.fluid(),
  raw_gasoline.fluid(),
  gasoline.fluid(),
  high_octane_gasoline.fluid(),
  coal_gas.gas(),
  coal_tar.fluid(),
  gunpowder.rough(),
  oilsands.sand(),
  rare_earth.fine(),
  stone.rough(),
  lava.fluid(),
  glowstone.shiny(),
  nether_star.netherstar(),
  endstone(),
  netherrack(),
  cetane_boosted_diesel.fluid(),
  collagen.rough(),
  gelatin.rough(),
  agar.rough(),
  milk.fine(),
  cocoa.fine(),
  wheat.fine(),
  meat.sand(),
  wood.woodSet(),
  paper.fine(),
  fish_oil.fluid(),
  ruby_slurry.fluid(),
  sapphire_slurry.fluid(),
  green_sapphire_slurry.fluid(),
  black_dye.fluid(),
  red_dye.fluid(),
  green_dye.fluid(),
  brown_dye.fluid(),
  blue_dye.fluid(),
  purple_dye.fluid(),
  cyan_dye.fluid(),
  light_gray_dye.fluid(),
  gray_dye.fluid(),
  pink_dye.fluid(),
  lime_dye.fluid(),
  yellow_dye.fluid(),
  light_blue_dye.fluid(),
  magenta_dye.fluid(),
  orange_dye.fluid(),
  white_dye.fluid(),
  impure_enriched_naquadah_solution.fluid(),
  enriched_naquadah_solution.fluid(),
  acidic_enriched_naquadah_solution.fluid(),
  enriched_naquadah_waste.fluid(),
  impure_naquadria_solution.fluid(),
  naquadria_solution.fluid(),
  acidic_naquadria_solution.fluid(),
  naquadria_waste.fluid(),
  lapotron.diamondSet(),
  treated_wood.woodSet(),
  uu_matter.fluid(),
  ;

  @override
  final IconSet iconSet;

  const RevisedMaterials([IconSet this.iconSet = IconSet.dull]);

  const RevisedMaterials.metallic():this(IconSet.metallic);
  const RevisedMaterials.shiny():this(IconSet.shiny);
  const RevisedMaterials.gas():this(IconSet.gas);
  const RevisedMaterials.bright():this(IconSet.bright);
  const RevisedMaterials.rubySet():this(IconSet.ruby);
  const RevisedMaterials.gem_horizontal():this(IconSet.gem_horizontal);
  const RevisedMaterials.gem_vertical():this(IconSet.gem_vertical);
  const RevisedMaterials.sand():this(IconSet.sand);
  const RevisedMaterials.fine():this(IconSet.fine);
  const RevisedMaterials.emeraldSet():this(IconSet.emerald);
  const RevisedMaterials.diamondSet():this(IconSet.diamond);
  const RevisedMaterials.ligniteSet():this(IconSet.lignite);
  const RevisedMaterials.rough():this(IconSet.rough);
  const RevisedMaterials.lapisSet():this(IconSet.lapis);
  const RevisedMaterials.quartz():this(IconSet.quartz);
  const RevisedMaterials.certus():this(IconSet.certus);
  const RevisedMaterials.flintSet():this(IconSet.flint);
  const RevisedMaterials.magnetic():this(IconSet.magnetic);
  const RevisedMaterials.woodSet():this(IconSet.wood);
  const RevisedMaterials.glassSet():this(IconSet.glass);
  const RevisedMaterials.opalSet():this(IconSet.opal);
  const RevisedMaterials.netherstar():this(IconSet.netherstar);
  const RevisedMaterials.radioactive():this(IconSet.radioactive);
  const RevisedMaterials.fluid():this(IconSet.fluid);
}