import 'dart:ui';

import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'gradientMakerDetails.dart';

class GradientCode extends StatelessWidget {
  GradientCode({Key? key}) : super(key: key);

  late double angle;
  List<Color> grads=[];
  late int gradType;

  @override
  Widget build(BuildContext context) {
    grads= Provider.of<GradientMakerDetails>(context, listen: true).getGrads;
    angle= Provider.of<GradientMakerDetails>(context, listen: true).getAngle;
    gradType= Provider.of<GradientMakerDetails>(context, listen: true).getGradType;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
        child: Container(
          width: screenWidth(context, mulBy: 0.6),
          height: screenHeight(context, mulBy: 0.35),
          constraints: const BoxConstraints(
              minWidth: 400,
              minHeight: 370
          ),
          clipBehavior: Clip.antiAlias,
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
                    width: screenWidth(context, mulBy: 0.6),
                    constraints: const BoxConstraints(
                        minWidth: 400,
                        minHeight: 70
                    ),
                    height: screenHeight(context, mulBy: 0.07),
                    alignment: Alignment.centerLeft,
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
                      "Your Gradient Code",
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
                child: Row(
                  children: [
                    Container(
                      width: 35,
                      decoration: const BoxDecoration(
                        color: Color(0xff252526),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10)
                        ),
                      ),
                      padding: const EdgeInsets.only(top: 15, right: 5),
                      child: Text(
                        "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14\n15\n16\n17\n18\n19",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontFamily: "techFont",
                          height: 1.5,
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.5)
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 15, left: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xff1d1e22).withOpacity(1),

                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10)
                        ),
                      ),
                        alignment: Alignment.topLeft,
                        child: SelectableText.rich(
                          TextSpan(
                            text: "",
                            children: [
                              const TextSpan(
                                text: "background",
                                style: TextStyle(
                                    color: Color(0xff9a8297)
                                ),),
                              const TextSpan(
                                text: ":",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              const TextSpan(
                                text: " rgb",
                              ),
                              ///Do here
                              const TextSpan(
                                text: "(",
                                children: [
                                  TextSpan(
                                    text: "0",
                                    style: TextStyle(
                                        color: Color(0xffd0782a)
                                    ),
                                  ),
                                  TextSpan(
                                    text: ",",
                                  ),
                                  TextSpan(
                                    text: "0",
                                    style: TextStyle(
                                        color: Color(0xffd0782a)
                                    ),
                                  ),
                                  TextSpan(
                                    text: ",",
                                  ),
                                  TextSpan(
                                    text: "102",
                                    style: TextStyle(
                                        color: Color(0xffd0782a)
                                    ),
                                  ),
                                  TextSpan(
                                    text: ");\n",
                                  ),
                                ],
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ), ///Do here
                              ///
                              ///New Line
                              ///
                              ///
                              const TextSpan(
                                text: "background",
                                style: TextStyle(
                                    color: Color(0xff9a8297)
                                ),),
                              const TextSpan(
                                text: ":",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              const TextSpan(
                                text: " -moz-",
                                style: TextStyle(
                                    color: Color(0xff9a8297)
                                ),),
                              ...getValueSpan(),
                              ///
                              ///New Line
                              ///
                              ///
                              const TextSpan(
                                text: "background",
                                style: TextStyle(
                                    color: Color(0xff9a8297)
                                ),),
                              const TextSpan(
                                text: ":",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              const TextSpan(
                                text: " -webkit-",
                                style: TextStyle(
                                    color: Color(0xff9a8297)
                                ),),
                              ...getValueSpan(),
                              ///
                              ///New Line
                              ///
                              ///
                              const TextSpan(
                                text: "background",
                                style: TextStyle(
                                    color: Color(0xff9a8297)
                                ),),
                              const TextSpan(
                                text: ": ",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              ...getValueSpan(),
                              ///
                              ///New Line
                              ///
                              ///
                              const TextSpan(
                                text: "filter",
                                style: TextStyle(
                                    color: Color(0xff9a8297)
                                ),),
                              const TextSpan(
                                text: ": ",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              const TextSpan(
                                text: "progid:DXImageTransform.Microsoft.gradient",
                              ),
                              ///Do here
                              const TextSpan(
                                text: "(",
                                children: [
                                  TextSpan(
                                      text: "startColorstr",
                                      style: TextStyle(
                                          color: Color(0xffddca7e)
                                      )
                                  ),
                                  TextSpan(
                                    text: "=",
                                  ),
                                  ///Do here Start color
                                  TextSpan(
                                      text: '"#000066"',
                                      style: TextStyle(
                                          color: Color(0xff96b38a)
                                      )
                                  ),
                                  TextSpan(
                                    text: ",",
                                  ),
                                  TextSpan(
                                      text: "endColorstr",
                                      style: TextStyle(
                                          color: Color(0xffddca7e)
                                      )
                                  ),
                                  TextSpan(
                                    text: "=",
                                  ),
                                  ///Do here End color
                                  TextSpan(
                                      text: '"#ffea00"',
                                      style: TextStyle(
                                          color: Color(0xff96b38a)
                                      )
                                  ),
                                  TextSpan(
                                    text: ",",
                                  ),
                                  TextSpan(
                                      text: "GradientType",
                                      style: TextStyle(
                                          color: Color(0xffddca7e)
                                      )
                                  ),
                                  TextSpan(
                                    text: "=",
                                  ),
                                  TextSpan(
                                    text: "1",
                                    style: TextStyle(
                                        color: Color(0xffd0782a)
                                    ),
                                  ),
                                  TextSpan(
                                    text: ");",
                                  ),
                                ],
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ]
                          ),
                            style: const TextStyle(
                              fontFamily: "techFont",
                              height: 1.5,
                              fontSize: 15,
                              color: Color(0xffddca7e)
                          ),
                        ),
                    ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  List<TextSpan> getValueSpan(){

    String gradient="", degree="";

    switch(gradType){
      case 0: gradient= "linear-gradient";
      break;
      case 1: gradient= "radial-gradient";
      break;
      case 2: gradient= "NOT-SUPPORTED";
      break;
    }

    if(gradType==1){
      degree= "circle";
    }else{
      degree= "${-(angle-360)}deg";
    }
    return [
      ///Do here Grad type
      TextSpan(
        text: gradient,
      ),
      ///Do here
      TextSpan(
        text: "(",
        children: [
          TextSpan(
            text: degree,
            style: const TextStyle(
                color: Color(0xffd0782a)
            ),
          ),
          ...getColorData(),
          const TextSpan(
            text: ");\n",
          ),

        ],
        style: const TextStyle(
            color: Colors.white
        ),
      ),
    ];
  }


  List<TextSpan> getColorData(){

    List<TextSpan> colorData=[];

    for(Color localColor in grads){
      colorData.add(
        TextSpan(
          text: ", ",
          children: [
            const TextSpan(
                text: "rgba",
                style: TextStyle(
                    color: Color(0xffddca7e)
                )
            ),
            ///Do here
            TextSpan(
              text: "(",
              children: [
                TextSpan(
                  text: "${localColor.red}",
                  style: TextStyle(
                      color: Color(0xffd0782a)
                  ),
                ),
                TextSpan(
                  text: ",",
                ),
                TextSpan(
                  text: "${localColor.green}",
                  style: TextStyle(
                      color: Color(0xffd0782a)
                  ),
                ),
                TextSpan(
                  text: ",",
                ),
                TextSpan(
                  text: "${localColor.blue}",
                  style: TextStyle(
                      color: Color(0xffd0782a)
                  ),
                ),
                TextSpan(
                  text: ",",
                ),
                TextSpan(
                  text: "${localColor.alpha}",
                  style: TextStyle(
                      color: Color(0xffd0782a)
                  ),
                ),
                TextSpan(
                  text: ") ",
                ),
              ],
              style: TextStyle(
                  color: Colors.white
              ),
            ), ///Do here
            const TextSpan(
              text: "0%",
              style: TextStyle(
                  color: Color(0xffd0782a)
              ),
            ),
          ],
          style: const TextStyle(
              color: Colors.white
          ),
        )
      );
    }

    return colorData;
  }

}






///grey
// style: TextStyle(
// color: Color(0xff9a8297)
// ),

///White
// style: TextStyle(
// color: Colors.white
// ),

///Yellow
// style: TextStyle(
// color: Color(0xffddca7e)
// ),

///Green
// style: TextStyle(
// color: Color(0xff96b38a)
// )

///Orange
// style: TextStyle(
// color: Color(0xffd0782a)
// ),
