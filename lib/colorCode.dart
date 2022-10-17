
import 'package:color_finder/colorDetails.dart';
import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorCode extends StatefulWidget {
  const ColorCode({Key? key}) : super(key: key);

  @override
  State<ColorCode> createState() => _ColorCodeState();
}

class _ColorCodeState extends State<ColorCode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context, mulBy: 0.35),
      height: screenHeight(context, mulBy: 0.4),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Colors.grey
      ),
      child: Text(
        "Coordinates: ${Provider.of<ColorDetails>(context, listen: true).getCoordinates}",
        style: TextStyle(
          color: Colors.black
        ),
      ),
    );
  }
}
