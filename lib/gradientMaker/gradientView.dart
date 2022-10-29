import 'dart:developer';

import 'package:color_finder/gradientMaker/gradientMakerDetails.dart';
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
import 'dart:math' as math;

class GradientViewer extends StatefulWidget {
  const GradientViewer({Key? key,}) : super(key: key);
  @override
  State<GradientViewer> createState() => _GradientViewerState();
}

class _GradientViewerState extends State<GradientViewer> {
  List<Color> grads=[];
  final imageKey = GlobalKey();
  late double angle;

  List<int> imageDataList = List<int>.empty(growable: false);
  late ui.Image image;
  late int gradType;
  late Future<List<PaletteColor>> a;

@override
  void initState() {
  //file= Provider.of<ColorDetails>(context, listen: true).getFile;

  super.initState();
  }



  @override
  Widget build(BuildContext context) {
    grads= Provider.of<GradientMakerDetails>(context, listen: true).getGrads;
    angle= Provider.of<GradientMakerDetails>(context, listen: true).getAngle;
    gradType= Provider.of<GradientMakerDetails>(context, listen: true).getGradType;
    return Stack(
      children: [
        Container(
          width: screenWidth(context, mulBy: 0.28),
          height: screenHeight(context, mulBy: 0.64),
          constraints: const BoxConstraints(
              minWidth: 500
          ),
          margin: EdgeInsets.symmetric(
              horizontal: 20
          ),
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.white,
                width: 5
            ),
            borderRadius: BorderRadius.circular(10),
          ),

          child: Image.asset(
            "assets/gradientBGImage.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: screenWidth(context, mulBy: 0.28),
          height: screenHeight(context, mulBy: 0.64),
          constraints: const BoxConstraints(
              minWidth: 500
          ),
          margin: EdgeInsets.symmetric(
              horizontal: 20
          ),
          //alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.white,
              width: 5
            ),
            borderRadius: BorderRadius.circular(10),
            gradient: getGradient(),

          ),

        ),
      ],
    );

  }


  Gradient getGradient(){
  late Gradient gradient;
  switch(gradType){
    case 0: gradient= LinearGradient(
      end: Alignment.topCenter,
      begin: Alignment.bottomCenter,
      colors: grads.toList(),
      transform: GradientRotation((-(angle-360))*math.pi/180),
        );
    break;
    case 1: gradient= RadialGradient(
      colors: grads.toList(),
      );
    break;
    case 2: gradient= SweepGradient(
      colors: grads.toList(),
      transform: GradientRotation((-(angle-360))*math.pi/180),
    );
    break;
  }
  return gradient;
  }


}
