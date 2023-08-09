import "dart:html";
import "dart:math" as Math; 
import "dart:typed_data";

import "package:LoaderLib/Archive.dart";
import "package:LoaderLib/Loader.dart";
import "package:archive/archive.dart" as raw;

import "utils.dart";


abstract class IconGenerator {
  static final IconGenerator test = new TestProcessor();

  static final IconGenerator linear = new FunctionProcessor((num n) => 1-n, (num n) => n);
  static final IconGenerator raiseMidtones = new FunctionProcessor((num n) => 1-n, (num n) => Math.pow(n, 0.7));

  static final IconGenerator radioactive = new SequenceProcessor()
    ..processors.add(new EdgeTrimmer(120))
    ..processors.add(new FunctionProcessor((num n) => cubicPulse(0.85, 0.6, (1-n)) * 0.2, (num n) => n * 0.5 + 0.5))
    ..processors.add(new NoiseGenerator(0, strength: 0.45, frames: 16))
  ;

  CanvasElement processIcon(CanvasImageSource image);
}

class TestProcessor extends IconGenerator {
  @override
  CanvasElement processIcon(CanvasImageSource image) {
    final int width = image.width!;
    final int height = image.height!;
    final CanvasElement canvas = new CanvasElement(width: width, height: height);
    final CanvasRenderingContext2D ctx = canvas.context2DReadFrequently;

    ctx.fillStyle = "#CC80CC";
    ctx.fillRect(0, 0, width, height);

    return canvas;
  }
}

class SequenceProcessor extends IconGenerator {
  final List<IconGenerator> processors = <IconGenerator>[];

  @override
  CanvasElement processIcon(CanvasImageSource image) {
    CanvasImageSource input = image;

    if (processors.isEmpty) {
      throw Exception("Empty SequenceProcessor");
    }

    for (final IconGenerator gen in processors) {
      input = gen.processIcon(input);
    }

    return input as CanvasElement;
  }
}

class FunctionProcessor extends IconGenerator {
  final num Function(num) alphaFunction;
  final num Function(num) brightnessFunction;

  FunctionProcessor(num Function(num) this.alphaFunction, num Function(num) this.brightnessFunction);

  @override
  CanvasElement processIcon(CanvasImageSource image) {
    final int width = image.width!;
    final int height = image.height!;
    final CanvasElement canvas = new CanvasElement(width: width, height: height);
    final CanvasRenderingContext2D ctx = canvas.context2DReadFrequently;

    ctx.drawImage(image, 0, 0);
    final ImageData imgData = ctx.getImageData(0, 0, width, height);
    final Uint8ClampedList data = imgData.data;

    // start out inverted
    int max = 0;
    int min = 255;

    // pass to get min and max
    for (int i = 0; i < width * height; i++) {
      final int index = i * 4;
      // if alpha is >0
      if (data[index + 3] > 0) {
        // check if it's darker than current min
        if (data[index] < min) {
          min = data[index];
        }
        // check if it's brighter than current max
        if (data[index] > max) {
          max = data[index];
        }
      }
    }

    // process
    for (int i = 0; i < width * height; i++) {
      final int index = i * 4;

      final int bright = data[index]; //red, assuming greyscale
      final int alpha = data[index + 3];

      num fraction = (bright - min) / (max - min);

      //fraction = ((1-fraction) * 2 - 1).clamp(0, 1);

      fraction = alphaFunction(fraction);

      num brightness = data[index] / 255;

      brightness = brightnessFunction(brightness);

      final int val = (brightness * 255).floor();

      data[index] = val;
      data[index+1] = val;
      data[index+2] = val;

      // set alpha based on brightness
      data[index + 3] = (alpha * fraction).floor();
    }

    ctx.putImageData(imgData, 0, 0);

    return canvas;
  }
}

class EdgeTrimmer extends IconGenerator {
  final int minAlpha;

  EdgeTrimmer(int this.minAlpha);

  @override
  CanvasElement processIcon(CanvasImageSource image) {
    final int width = image.width!;
    final int height = image.height!;
    final CanvasElement canvas = new CanvasElement(width: width, height: height);
    final CanvasRenderingContext2D ctx = canvas.context2DReadFrequently;

    ctx.drawImage(image, 0, 0);
    final ImageData imgData = ctx.getImageData(0, 0, width, height);
    final Uint8ClampedList data = imgData.data;

    final ImageData replacementImgData = ctx.getImageData(0, 0, width, height);
    final Uint8ClampedList replacementData = replacementImgData.data;

    for (int y=0; y<height; y++) {
      for (int x=0; x<width; x++) {
        final int id = (width * y + x) * 4;
        final bool up = (y == 0) || data[id - width*4 +3] == 0;
        final bool down = (y == height-1) || data[id + width*4 +3] == 0;
        final bool left = (x == 0) || data[id - 4 +3] == 0;
        final bool right = (x == width-1) || data[id + 4 +3] == 0;

        if (up || down || left || right) {
          replacementData[id+3] = Math.min(minAlpha, replacementData[id+3]);
        }
      }
    }

    ctx.putImageData(replacementImgData, 0, 0);

    return canvas;
  }
}

class NoiseGenerator extends IconGenerator {
  final Math.Random random;
  final int frames;
  final double strength;

  NoiseGenerator(int seed, {int this.frames = 1, double this.strength = 0.5}):random = new Math.Random(seed);

  @override
  CanvasElement processIcon(CanvasImageSource image) {
    final int width = image.width!;
    final int height = image.height!;
    final CanvasElement canvas = new CanvasElement(width: width, height: height * frames);
    final CanvasRenderingContext2D ctx = canvas.context2DReadFrequently;

    for (int i=0; i<frames; i++) {
      ctx.drawImage(image, 0, height * i);
    }

    final ImageData imgData = ctx.getImageData(0, 0, width, height*frames);
    final Uint8ClampedList data = imgData.data;

    // only care about the alpha channel
    // i always hits an alpha value here
    for(int i=3; i<data.length; i+=4) {
      data[i] = ((data[i]/255) * ((1-strength) + (strength * random.nextDouble())).clamp(0, 1) * 255).floor();
    }

    ctx.putImageData(imgData, 0, 0);

    return canvas;
  }
}

// #############################################################################

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