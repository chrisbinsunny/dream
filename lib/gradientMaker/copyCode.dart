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
                    child: Text(
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
                      decoration: BoxDecoration(
                        color: Color(0xff252526).withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10)
                        ),
                      ),
                      padding: EdgeInsets.only(top: 15, right: 5),
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
                        padding: EdgeInsets.only(top: 15, left: 5),
                      decoration: BoxDecoration(
                        color: Color(0xff1e1e1e).withOpacity(0.8),

                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10)
                        ),
                      ),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "background: rgb(0,0,102);\n"
                            "background: -moz-linear-gradient(42deg, rgba(0,0,102,1) 0%, rgba(255,234,0,1) 100%);\n"
                          "background: -webkit-linear-gradient(42deg, rgba(0,0,102,1) 0%, rgba(255,234,0,1) 100%);\n"
                        "background: linear-gradient(42deg, rgba(0,0,102,1) 0%, rgba(255,234,0,1) 100%);\n"
                  'filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#000066",endColorstr="#ffea00",GradientType=1);\n',
                          style: TextStyle(
                              fontFamily: "techFont",
                              height: 1.5,
                              fontSize: 15,
                              color: Colors.white.withOpacity(0.9)
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
}
