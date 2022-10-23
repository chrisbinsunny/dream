import 'dart:developer';

import 'package:color_finder/palette/paletteViewer.dart';
import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import '../gradientFinder/aa.dart';
import '../colorDetails.dart';
import 'dart:ui' as ui;
import '../upload/dropFile.dart';

class GradientViewer extends StatefulWidget {
  const GradientViewer({Key? key,}) : super(key: key);
  @override
  State<GradientViewer> createState() => _GradientViewerState();
}

class _GradientViewerState extends State<GradientViewer> {
  DroppedFile? file;
  final imageKey = GlobalKey();

  List<int> imageDataList = List<int>.empty(growable: false);
  late ui.Image image;
  String _lastUrl= "", b="";
  Size _lastWindowSize = Size.zero;
  late Future<List<PaletteColor>> a;

@override
  void initState() {
  //file= Provider.of<ColorDetails>(context, listen: true).getFile;

  super.initState();
  }


  @override
  void didChangeDependencies() {
    //file= Provider.of<ColorDetails>(context, listen: true).getFile;

    //a= generatePalette("imagePath");

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    file= Provider.of<ColorDetails>(context, listen: true).getFile;
    return Container(
      width: screenWidth(context, mulBy: 0.28),
      height: screenHeight(context, mulBy: 0.64),
      constraints: const BoxConstraints(
          minWidth: 500
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
            color: Colors.white,
          width: 5
        ),
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Color(0xff000000),
            Color(0xff394CB6),
          ]
        )
      ),
    );

  }




  Color? getPixelColor(Offset position) {
    /// no process if we in a race condition while image is being captured
    /// and mouse/touch dragged around the screen.
    if (imageDataList.isEmpty) return null;
    final w = image.width;
    final h = image.height;
    final x = position.dx.round().clamp(0, w - 1);

    /// -1: index is 0 based.
    final y = position.dy.round().clamp(0, h - 1);

    final list = imageDataList;
    var i = y * (w * 4) + x * 4;

    /// pixels are encoded in `RGBA` in the List.
    return Color.fromARGB(
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
