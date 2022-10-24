import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'gradientMakerDetails.dart';

class BgGradient extends StatelessWidget {
  BgGradient({Key? key}) : super(key: key);
  late double angle;
  List<Color> grads=[];

  @override
  Widget build(BuildContext context) {
    grads= Provider.of<GradientMakerDetails>(context, listen: true).getGrads;
    angle= Provider.of<GradientMakerDetails>(context, listen: true).getAngle;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: grads.toList(),
              transform: GradientRotation((-(angle-360))*math.pi/180
              )
          ),

      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
        ),
      ),
    );
  }
}
