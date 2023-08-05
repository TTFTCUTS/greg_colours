import "dart:html";

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

void reloadCSS() {
  final String refresh = DateTime.now().millisecondsSinceEpoch.toString();
  for (final LinkElement link in querySelectorAll("link").whereType<LinkElement>().where((LinkElement element) => element.rel == "stylesheet")) {
    link.href = "${link.href.split("?").first}?refresh=$refresh";
  }
}