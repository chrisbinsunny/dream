import 'dart:ui';

import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';

class HowToUse extends StatelessWidget {
  const HowToUse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),

      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
        child: Container(
          width: screenWidth(context, mulBy: 0.5),
          height: screenHeight(context, mulBy: 0.35),
          constraints: const BoxConstraints(
              minWidth: 400,
              minHeight: 340
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
                    width: screenWidth(context, mulBy: 0.5),
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
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                          text: "How to use  ",
                          children: [
                            TextSpan(
                              text: "\'DREAM\'",
                              style: TextStyle(
                                color: Colors.blueGrey[100],
                                fontSize: 23,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 5,
                              ),
                            ),
                          ]
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                  ),
                ),
              ),

              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20
                  ),
                  child: Text(
                    "Use your cursor on the image to find the color."
                      "Use the online image color picker above to select a color and get the HTML Color Code of this pixel. Also you get the HEX color code value, RGB value and HSV value. Under 'Use Your Image' You can upload your own image (for example an screenshot of your desktop), paste an image from clipboard, put a picture url in the textbox below. Or use an website url, you will see a thumbnail on the left side." ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
