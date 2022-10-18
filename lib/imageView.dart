import 'dart:developer';

import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'aa.dart';
import 'colorDetails.dart';
import 'dart:ui' as ui;
import 'dropFile/dropFile.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({Key? key,}) : super(key: key);
  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  DroppedFile? file;
  final imageKey = GlobalKey();

  final onColorPicked = ValueNotifier<Color>(Colors.black);
  List<int> imageDataList = List<int>.empty(growable: false);
  late ui.Image image;

  Size _lastWindowSize = Size.zero;


  @override
  Widget build(BuildContext context) {
    file= Provider.of<ColorDetails>(context, listen: true).getFile;
    return MouseRegion(
      cursor: SystemMouseCursors.precise,
      child: GestureDetector(
        onPanDown: (event) async {
          final windowSize = MediaQuery.of(context).size;

          /// re-capture the image only when the window size changed.
          /// We might use a LayoutBuilder or similar as well. Is just a way
          /// to optimize the CPU required to draw Image.
          if (_lastWindowSize != windowSize) {
            print('capture image');
            _lastWindowSize = windowSize;
            imageDataList = await captureImage();
          }
          getPixelColor(event.localPosition);
        },
        onPanUpdate: (event) {
          getPixelColor(event.localPosition);
        },
        child: RepaintBoundary(
          key: imageKey,
          child: Center(
            child: Container(
              width: screenWidth(context, mulBy: 0.35),
              height: screenHeight(context, mulBy: 0.4),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Colors.blue
              ),
              child: (file == null)?
              const Center(
                  child: Text(
                    "No Preview",
                    style: TextStyle(color: Colors.white),
                  )):
              Image.network(
                file!.url,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );

  }




  void getPixelColor(Offset position) {
    /// no process if we in a race condition while image is being captured
    /// and mouse/touch dragged around the screen.
    if (imageDataList.isEmpty) return;
    final w = image.width;
    final h = image.height;
    final x = position.dx.round().clamp(0, w - 1);

    /// -1: index is 0 based.
    final y = position.dy.round().clamp(0, h - 1);

    final list = imageDataList;
    var i = y * (w * 4) + x * 4;

    /// pixels are encoded in `RGBA` in the List.
    onColorPicked.value = Color.fromARGB(
      list[i + 3],
      list[i],
      list[i + 1],
      list[i + 2],
    );
  }

  Future<List<int>> captureImage() async {
    final ro =
    imageKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    image = await ro.toImage();
    final bytes = (await image.toByteData(format: ui.ImageByteFormat.rawRgba))!;
    return bytes.buffer.asUint8List().toList(growable: false);
  }
}
