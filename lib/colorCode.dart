
import 'dart:developer';

import 'package:color_finder/colorDetails.dart';
import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;

class ColorCode extends StatefulWidget {
  const ColorCode({Key? key}) : super(key: key);

  @override
  State<ColorCode> createState() => _ColorCodeState();
}

class _ColorCodeState extends State<ColorCode> {

  late img.Image photo;

  void setImageBytes(imageBytes) {
    print("setImageBytes");
    List<int> values = imageBytes.buffer.asUint8List();
    photo = img.decodeImage(values)!;
  }

  // image lib uses uses KML color format, convert #AABBGGRR to regular #AARRGGBB
  int abgrToArgb(int argbColor) {
    print("abgrToArgb");
    int r = (argbColor >> 16) & 0xFF;
    int b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
  }

  // FUNCTION

  Future<Color> _getColor() async {
    print("_getColor");
    Uint8List? data;

    try{
      data =
          (await http.get(Uri.parse(Provider.of<ColorDetails>(context, listen: true).getFile!.url)))
              .bodyBytes;
    }
    catch(ex){
      log(ex.toString());
    }

    print("setImageBytes....");
    setImageBytes(data);

//FractionalOffset(1.0, 0.0); //represents the top right of the [Size].
    double px = 1.0;
    double py = 0.0;

    int pixel32 = photo.getPixelSafe(px.toInt(), py.toInt());
    int hex = abgrToArgb(pixel32);
    print("Value of int: $hex ");

    return Color(hex);
  }



  @override
  Widget build(BuildContext context) {
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
          FutureBuilder(
              future: _getColor(),
              builder: (_, AsyncSnapshot<Color> data){
                if (data.connectionState==ConnectionState.done){
                  log(data.data.toString());
                  return Container(
                    height: 100,
                    width: 100,
                    color: data.data,
                  );
                }
                return CircularProgressIndicator();
              }
          ),
        ],
      ),
    );
  }
}
