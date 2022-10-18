
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
    setImageBytes();
    super.initState();
  }



  Future<void> setImageBytes() async {
    print("_getColor");
    late Uint8List data;

    try{
      data =
      (await http.get(
          Uri.parse(widget.imagUrl!),
    )).bodyBytes;
    }
    catch(ex){
    print(ex.toString());
    }

    print("setImageBytes....");
    print("setImageBytes");
    List<int> values = data.buffer.asUint8List();
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


//FractionalOffset(1.0, 0.0); //represents the top right of the [Size].
    double px = Provider.of<ColorDetails>(context, listen: true).getCoordinates.dx;
    double py = Provider.of<ColorDetails>(context, listen: true).getCoordinates.dy;

    int pixel32 = photo.getPixelSafe(px.toInt(), py.toInt());
    int hex = abgrToArgb(pixel32);
    print("Value of int: $hex ");

    return Color(hex);
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
          FutureBuilder(
              future: _getColor(),
          builder: (context, AsyncSnapshot<Color?> snapshot) {
            if(snapshot.hasData) {
              return Container(
                width: 300,
                height: 300,
                color: snapshot.data,
              );
            }
            return CircularProgressIndicator();
          }),
        ],
      ),
    );
  }

}
