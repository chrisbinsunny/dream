
import 'dart:developer';

import 'package:color_finder/colorDetails.dart';
import 'package:color_finder/dropFile/dropFile.dart';
import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:provider/provider.dart';

class ColorCode extends StatefulWidget {
  const ColorCode({Key? key}) : super(key: key);

  @override
  State<ColorCode> createState() => _ColorCodeState();
}

class _ColorCodeState extends State<ColorCode> {

  DroppedFile? file;
  late Offset coordi;

  @override
  Widget build(BuildContext context) {
    file= Provider.of<ColorDetails>(context, listen: true).getFile;
    coordi= Provider.of<ColorDetails>(context, listen: true).getCoordinates;
    return Container(
      width: screenWidth(context, mulBy: 0.35),
      height: screenHeight(context, mulBy: 0.4),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Colors.grey
      ),
      child: Column(
        children: [
          Text(
            "Coordinates: ${Provider.of<ColorDetails>(context, listen: true).getCoordinates}",
            style: TextStyle(
              color: Colors.black
            ),
          ),

          file!=null?ImagePixels(
              imageProvider: NetworkImage(file!.url),
              builder: (context, img) =>
                  Text(
                      "Img size is: ${img.width} × ${img.height}.\n"
                          "Pixel color is: ${img.pixelColorAt!(coordi.dx.toInt(),coordi.dy.toInt())}."
                          "")
          ):SizedBox()
        ],
      ),
    );
  }

}
