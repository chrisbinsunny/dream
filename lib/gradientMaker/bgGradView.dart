import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'gradientMakerDetails.dart';

class BgGradient extends StatelessWidget {
  BgGradient({Key? key}) : super(key: key);

  List<Color> grads=[];

  @override
  Widget build(BuildContext context) {
    grads= Provider.of<GradientMakerDetails>(context, listen: true).getGrads;

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: grads)
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
