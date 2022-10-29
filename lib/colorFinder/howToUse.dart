import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HowToUse extends StatelessWidget {
  const HowToUse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 20
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
          child: Container(
            width: screenWidth(context, mulBy: 0.5),
            height: screenHeight(context, mulBy: 0.35),
            constraints: const BoxConstraints(
                minWidth: 400,
                minHeight: 370
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
                      child: AutoSizeText.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                            text: "How to use  ",
                            children: [
                              TextSpan(
                                text: "\'DREAM\'",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.blueGrey[300],
                                    fontSize: 23,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 5,
                                  ),
                              ),
                            ]
                        ),
                        minFontSize: 19,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20
                      ),
                      child: AutoSizeText.rich(
                        textAlign: TextAlign.start,
                        TextSpan(
                            text: "Use your cursor on the image to find the color. \n\nUse",
                            children: [
                              TextSpan(
                                text: " \'DREAM\' ",
                                style: GoogleFonts.montserrat(
                                  color: Colors.blueGrey[300],
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 5,
                                ),
                              ),
                              const TextSpan(
                                text: "by Chrisbin to find the color from your image and get the HTML Color Code of the point. "
                                    "Also you get the HEX color code value, and the RGB value. "
                                    "Under 'Choose Your Image' you can upload your own image (for example, a screenshot from figma), paste an image from clipboard, or put an image's local address in the textbox. "
                                    "Also, you could always use the old and easier drag and drop to choose image.\n\n"
                              ),
                              const TextSpan(
                                  text: "We strongly support data privacy. ",
                                  children: [
                                    TextSpan(
                                        text: "No data is being sent to our servers. ",
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            decoration: TextDecoration.underline,
                                          color: Colors.red
                                        )
                                    ),
                                    TextSpan(
                                      text: "Your browser handles everything.",
                                    )
                                  ]
                              ),
                            ]
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        minFontSize: 12,
                        maxLines: 15,
                      ),
                    ),
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
