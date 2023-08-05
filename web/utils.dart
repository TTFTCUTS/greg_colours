import "dart:html";
import "dart:math" as Math;

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

num cubicPulse(num centre, num width, num val) {
  val = (val-centre).abs();
  if (val > width) { return 0.0; }
  val /= width;
  return 1.0 - val*val*(3.0-2.0*val);
}

extension CanvasImageSourceDimensions on CanvasImageSource {
  int? get width {
    if (this is ImageElement) { return (this as ImageElement).width; }
    if (this is CanvasElement) { return (this as CanvasElement).width; }
    return null;
  }

  int? get height {
    if (this is ImageElement) { return (this as ImageElement).height; }
    if (this is CanvasElement) { return (this as CanvasElement).height; }
    return null;
  }
}