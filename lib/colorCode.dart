
import 'dart:developer';
import 'dart:typed_data';

import 'package:color_finder/colorDetails.dart';
import 'package:color_finder/dropFile/dropFile.dart';
import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;

import 'imagePixel.dart';

class ColorCode extends StatefulWidget {
  const ColorCode({Key? key, required this.imagUrl}) : super(key: key);

  final String? imagUrl;

  @override
  State<ColorCode> createState() => _ColorCodeState();
}

class _ColorCodeState extends State<ColorCode> {

  DroppedFile? file;
  late Offset coordi;
  late img.Image photo;

  @override
  void initState() {
    super.initState();
  }


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
          ImagePixels(
              imageProvider: NetworkImage(widget.imagUrl!),
              builder: (context, img) =>
                  Text(
                      "Img size is: ${img.width} × ${img.height}.\n"
                          "Pixel color is: ${img.pixelColorAt!(0, 0)}.")
          ),
          // FutureBuilder(
          //     future: _getColor(),
          // builder: (context, AsyncSnapshot<Color?> snapshot) {
          //   if(snapshot.hasData) {
          //     return Container(
          //       width: 300,
          //       height: 300,
          //       color: snapshot.data,
          //     );
          //   }
          //   return CircularProgressIndicator();
          // }),
        ],
      ),
    );
  }

}
