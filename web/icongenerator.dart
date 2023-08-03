import "dart:convert";
import "dart:html";
import "dart:typed_data";

import "package:LoaderLib/Archive.dart";
import "package:LoaderLib/Loader.dart";
import "package:archive/archive.dart" as raw;


abstract class IconGenerator {
  CanvasElement processIcon(ImageElement image);
}

class TestProcessor extends IconGenerator {
  @override
  CanvasElement processIcon(ImageElement image) {
    final int width = image.width!;
    final int height = image.height!;
    final CanvasElement canvas = new CanvasElement(width: width, height: height);
    final CanvasRenderingContext2D ctx = canvas.context2D;

    ctx.drawImage(image, 0, 0);
    final ImageData imgData = ctx.getImageData(0, 0, width, height);
    final Uint8ClampedList data = imgData.data;

    int max = 0;
    int min = 255;

    // pass to get min and max
    for (int i = 0; i<width*height; i++) {
      final int index = i*4;
      if (data[index] < min) { min = data[index]; }
      if (data[index] > max) { max = data[index]; }
    }

    // process
    for (int i = 0; i<width*height; i++) {
      final int index = i*4;

      final int bright = data[index]; //red, assuming greyscale
      final int alpha = data[index+3];

      final double fraction = (bright - min) / (max - min);

      data[index+3] = (alpha * fraction).floor();
    }

    ctx.putImageData(imgData, 0, 0);

    return canvas;
  }
}

class GeneratedIconSet extends DataPack {
  final IconGenerator generator;

  final Archive niceArchive;

  factory GeneratedIconSet(IconGenerator generator) {
    return new GeneratedIconSet._(generator, new Archive());
  }
  GeneratedIconSet._(IconGenerator this.generator, Archive this.niceArchive):super(niceArchive.rawArchive);

  Future<void> processIcon(String inputPath, String outputPath) async {
    final ImageElement inputIcon = await Loader.getResource(inputPath);

    final CanvasElement canvas = generator.processIcon(inputIcon);
    final Blob data = await canvas.toBlob();

    final ByteBuffer outputIcon = await Formats.png.readFromFile(new File(<Object>[data], "test"));

    final raw.ArchiveFile file = new raw.ArchiveFile(outputPath, data.size, new Uint8ClampedList.view(outputIcon));

    archive.addFile(file);
  }

  Future<void> processIcons(List<String> inputPaths, String Function(String string) pathTransformer) async {
    for (final String input in inputPaths) {
      await processIcon(input, pathTransformer(input));
    }
  }
}