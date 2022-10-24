import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../sizes.dart';
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
                itemNo: 2,
                name: "Radial Gradient",
              ),
              GradientTypeButton(
                hovered: hovered,
                selected: selected,
                itemNo: 3,
                name: "Sweep Gradient",
              ),
            ],
          );
        },
      ),
    );
}
}

class GradientTypeButton extends StatelessWidget {
  const GradientTypeButton({
    Key? key,
    required this.hovered,
    required this.selected,
    required this.itemNo,
    required this.name
  }) : super(key: key);

  final ValueNotifier<int> hovered;
  final int selected;
  final int itemNo;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Provider.of<GradientMakerDetails>(context, listen: false).setGradType(itemNo);
      },
      onHover: (hover1){
        if(hover1){
          hovered.value=itemNo;
        }else{
          hovered.value=-1;
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
          child: Container(
            width: screenWidth(context, mulBy: 0.115
            ),
            height: screenHeight(context, mulBy: 0.06
            ),
            constraints: const BoxConstraints(
                minWidth: 210,
                minHeight: 50
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: hovered.value==itemNo?Colors.white.withOpacity(0.1):Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: Colors.white.withOpacity(
                      selected==itemNo?1:
                      0.3
                  ),
                  width: 2.5
              ),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
