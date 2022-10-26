import 'dart:developer';

import 'package:color_finder/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'gradientMakerDetails.dart';

class ShareCode extends StatelessWidget {
  ShareCode({Key? key}) : super(key: key);

  late double angle;
  List<Color> grads=[];
  late int gradType;


  @override
  Widget build(BuildContext context) {
    grads= Provider.of<GradientMakerDetails>(context, listen: true).getGrads;
    angle= Provider.of<GradientMakerDetails>(context, listen: true).getAngle;
    gradType= Provider.of<GradientMakerDetails>(context, listen: true).getGradType;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DreamButton(
            name: "Share design",
            onTap: (){
              String a= Uri.base.origin;
              a+="/gradient-maker?a=${360-angle}&gt=$gradType";
              grads.forEach((element) {
                a+="&c=${element.value.toRadixString(16)}";
              });
              log(a);
            },
          icon: FontAwesomeIcons.solidPaperPlane,
        ),
        SizedBox(
          width: 20,
        ),
        DreamButton(
          name: "Copy Code",
          onTap: (){},
          icon: FontAwesomeIcons.code,
        )
      ],
    );
  }
}
