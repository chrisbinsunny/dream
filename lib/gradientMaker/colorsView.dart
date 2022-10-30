import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../sizes.dart';
import 'colorPickerDialog.dart';
import 'gradientMakerDetails.dart';

class ColorsView extends StatefulWidget {
  const ColorsView({Key? key}) : super(key: key);

  @override
  State<ColorsView> createState() => _ColorsViewState();
}

class _ColorsViewState extends State<ColorsView> {

  List<Color> grads=[];
  final hovered=ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {

    grads= Provider.of<GradientMakerDetails>(context, listen: true).getGrads;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
          child: Container(
            width: screenWidth(context, mulBy: 0.3),
            height: screenHeight(context, mulBy: 0.23),
            constraints: const BoxConstraints(
                minWidth: 530,
                minHeight: 220
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white,
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10)
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0, tileMode: TileMode.decal),
                    child: Container(
                      width: screenWidth(context, mulBy: 0.3),
                      height: screenHeight(context, mulBy: 0.06),

                      alignment: Alignment.centerLeft,
                      constraints: const BoxConstraints(
                          minWidth: 530,
                          minHeight: 50
                      ),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          border: const Border(
                              bottom: BorderSide(
                                  color: Colors.white,
                                  width: 0.5
                              )
                          )
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15
                      ),
                      child: const Text(
                        "Colors",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ValueListenableBuilder<int>(
                    valueListenable: hovered,
                    builder: (context, hover, child) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ListView.builder(
                              itemCount:grads.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(
                                left: 10
                              ),
                              itemBuilder: (context, index) {
                                return Align(
                                  child: InkWell(
                                    onTap: (){
                                      showDialog(
                                        barrierColor: Colors.black.withOpacity(0.1),
                                        context: context,
                                        builder: (context) {
                                          return ColorPickerDialog(
                                            index: index,
                                          );
                                        },
                                      );
                                    },
                                    onHover: (hover){
                                      if(hover){
                                        hovered.value=index;
                                      }else{
                                        hovered.value=-1;
                                      }
                                    },
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Container(
                                          height: screenWidth(context, mulBy: 0.05),
                                          width: screenWidth(context, mulBy: 0.05),
                                          constraints: const BoxConstraints(
                                              minHeight: 90,
                                              minWidth: 90
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white.withOpacity(
                                                    hover==index?1:
                                                    0.5
                                                ),
                                                width: 2.5
                                            ),

                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.only(
                                              right: 10
                                          ),
                                          child: Container(
                                            height: screenWidth(context, mulBy: 0.05)-9,
                                            width: screenWidth(context, mulBy: 0.05)-9,
                                            constraints: const BoxConstraints(
                                                minHeight: 81,
                                                minWidth: 81
                                            ),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.transparent,
                                                    width: 2.5
                                                ),
                                                borderRadius: BorderRadius.circular(5),
                                                color: grads[index]
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: (hover==index)&&(grads.length>2),
                                          child: GestureDetector(
                                            onTap: () {
                                              Provider.of<GradientMakerDetails>(context, listen: false).removeGrad(index);
                                            },
                                            child: const CircleAvatar(
                                              key: Key('closeIconKey'),
                                              radius: 13,

                                              backgroundColor: Colors.white,
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            Visibility(
                              visible: grads.length<5,
                              child: Align(
                                child: InkWell(
                                  onTap: (){
                                    Provider.of<GradientMakerDetails>(context, listen: false).addGrad();
                                    showDialog(
                                      barrierColor: Colors.black.withOpacity(0.1),
                                      context: context,
                                      builder: (context) {
                                        return ColorPickerDialog(
                                          index: grads.length-1,
                                        );
                                      },
                                    );
                                  },
                                  onHover: (hover){
                                    if(hover){
                                      hovered.value=grads.length;
                                    }else{
                                      hovered.value=-1;
                                    }
                                  },
                                  child: Container(
                                    height: screenWidth(context, mulBy: 0.05),
                                    width: screenWidth(context, mulBy: 0.05),
                                    constraints: const BoxConstraints(
                                        minHeight: 90,
                                        minWidth: 90
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white.withOpacity( hover==grads.length?1:
                                          0.5),
                                          width: 2.5
                                      ),

                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(
                                        right: 10
                                    ),
                                    child: Container(
                                      height: screenWidth(context, mulBy: 0.05)-9,
                                      width: screenWidth(context, mulBy: 0.05)-9,
                                      constraints: const BoxConstraints(
                                          minHeight: 81,
                                          minWidth: 81
                                      ),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.transparent,
                                              width: 2.5
                                          ),
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white.withOpacity(0.15)
                                      ),
                                      child: const Icon(
                                        CupertinoIcons.plus,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ListView.builder(
                              itemCount:(grads.length==5)?0:4-grads.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Align(
                                  child: Container(
                                    height: screenWidth(context, mulBy: 0.05),
                                    width: screenWidth(context, mulBy: 0.05),
                                    constraints: const BoxConstraints(
                                        minHeight: 90,
                                        minWidth: 90
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white.withOpacity(0.15)
                                    ),
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(
                                        right: 10
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
