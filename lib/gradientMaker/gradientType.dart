import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../sizes.dart';
import '../widgets.dart';
import 'gradientMakerDetails.dart';

class GradientType extends StatelessWidget {
  GradientType({Key? key}) : super(key: key);
  final hovered=ValueNotifier<int>(-1);
  int selected=0;

  @override
  Widget build(BuildContext context) {
    selected= Provider.of<GradientMakerDetails>(context, listen: true).getGradType;
    return Container(
      width: screenWidth(context, mulBy: 0.115
      ),
      height: screenHeight(context, mulBy: 0.25
      ),
      constraints: const BoxConstraints(
          minWidth: 210,
          minHeight: 230
      ),
      alignment: Alignment.center,
      child: ValueListenableBuilder<int>(
        valueListenable: hovered,
        builder: (context, hover, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GradientTypeButton(
                hovered: hovered,
                selected: selected,
                itemNo: 0,
                name: "Linear Gradient",
              ),
              GradientTypeButton(
                hovered: hovered,
                selected: selected,
                itemNo: 1,
                name: "Radial Gradient",
              ),
              GradientTypeButton(
                hovered: hovered,
                selected: selected,
                itemNo: 2,
                name: "Sweep Gradient",
              ),
            ],
          );
        },
      ),
    );
}
}


