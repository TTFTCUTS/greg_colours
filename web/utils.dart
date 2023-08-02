
mixin EnumName on Enum {
  String get name {
    return this.toString().split(".").last;
  }
}