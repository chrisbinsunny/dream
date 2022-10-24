import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../sizes.dart';

class GradientType extends StatefulWidget {
  GradientType({Key? key}) : super(key: key);

  @override
  State<GradientType> createState() => _GradientTypeState();
}

class _GradientTypeState extends State<GradientType> {
  final hovered=ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {
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
            children: [
              InkWell(
                onTap: (){},
                onHover: (hover1){
                  if(hover1){
                    hovered.value=0;
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
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: Colors.white.withOpacity(
                                hover==0?1:
                                0.5
                            ),
                            width: 2.5
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
