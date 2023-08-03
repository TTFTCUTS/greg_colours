import "iconset.dart";


mixin Material on Enum {
  IconSet get iconSet;

  String get name {
    return this.toString().split(".").last;
  }
}

mixin EnumName on Enum {
  String get name {
    return this.toString().split(".").last;
  }
}