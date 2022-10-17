import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';

import 'dropFile/dropFile.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({Key? key, required this.file}) : super(key: key);
  final DroppedFile? file;
  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context, mulBy: 0.35),
      height: screenHeight(context, mulBy: 0.4),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.blue
      ),
      child: (widget.file == null)?
      const Center(
          child: Text(
            "No Preview",
            style: TextStyle(color: Colors.white),
          )):
      GestureDetector(
        onTapDown: (tap){

        },
        child: Image.network(
        widget.file!.url,
        fit: BoxFit.contain,
    ),
      ),
    );
  }
}
