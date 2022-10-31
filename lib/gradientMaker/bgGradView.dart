import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'gradientMakerDetails.dart';

class BgGradient extends StatelessWidget {
  BgGradient({Key? key}) : super(key: key);
  late double angle;
  List<Color> grads=[];
  late int gradType;


  @override
  Widget build(BuildContext context) {
    grads= Provider.of<GradientMakerDetails>(context, listen: true).getGrads;
    angle= Provider.of<GradientMakerDetails>(context, listen: true).getAngle;
    gradType= Provider.of<GradientMakerDetails>(context, listen: true).getGradType;

    return Container(
      decoration: BoxDecoration(
          gradient: getGradient()

      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.8)),
        ),
      ),
    );
  }

  Gradient getGradient(){
    late Gradient gradient;
    switch(gradType){
      case 0: gradient= LinearGradient(
        end: Alignment.topCenter,
        begin: Alignment.bottomCenter,
        colors: grads.toList(),
        transform: GradientRotation((-(angle-360))*math.pi/180
        ),);
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
