import 'dart:developer';

import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'colorDetails.dart';
import 'dropFile/dropFile.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({Key? key,}) : super(key: key);
  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  DroppedFile? file;
  @override
  Widget build(BuildContext context) {
    file= Provider.of<ColorDetails>(context, listen: true).getFile;
    return Container(
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
      GestureDetector(
        onTapDown: (tap){
          Provider.of<ColorDetails>(context, listen: false).setCoordinates(tap.localPosition);
        },
        onPanUpdate: (tap){
          Provider.of<ColorDetails>(context, listen: false).setCoordinates(tap.localPosition);
        },
        child: Image.network(
        file!.url,
        fit: BoxFit.contain,
    ),
      ),
    );
  }
}
