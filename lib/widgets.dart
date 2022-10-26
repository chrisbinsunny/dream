

import 'dart:ui';

import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'gradientMaker/gradientMakerDetails.dart';

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
              style: const TextStyle(
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

class DreamButton extends StatelessWidget {
  DreamButton({
    Key? key,
    required this.name,
    required this.onTap,
    this.icon
  }) : super(key: key);

  final hovered= ValueNotifier<bool>(false);
  final String name;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: hovered,
      builder: (context, hover, child) {
        return InkWell(
          onTap: onTap,
          onHover: (hover1){
            if(hover1){
              hovered.value=true;
            }else{
              hovered.value=false;
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
                  color: hover?Colors.white.withOpacity(0.1):Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: Colors.white.withOpacity(
                          0.8
                      ),
                      width: 2.5
                  ),
                ),
                child: icon==null?Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    overflow: TextOverflow.clip,
                  ),
                ):Row(
                  children: [
                    Icon(
                        icon
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}