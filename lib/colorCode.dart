import 'dart:developer';
import 'dart:ui';

import 'package:color_finder/colorDetails.dart';
import 'package:color_finder/dropFile/dropFile.dart';
import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import 'imagePixel.dart';

class ColorCode extends StatefulWidget {
  const ColorCode({Key? key, }) : super(key: key);


  @override
  State<ColorCode> createState() => _ColorCodeState();
}

class _ColorCodeState extends State<ColorCode> {

  late Color color, colorTemp;
  late DroppedFile? file;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    color=Provider.of<ColorDetails>(context, listen: true).getColor;
    colorTemp=Provider.of<ColorDetails>(context, listen: true).getColorTemp;
    file=Provider.of<ColorDetails>(context, listen: true).getFile;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),

      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
        child: Container(
          width: screenWidth(context, mulBy: 0.3),
          height: screenHeight(context, mulBy: 0.4),
          constraints: const BoxConstraints(
              minWidth: 400
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
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
                  filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0,),
                  blendMode: BlendMode.srcATop,
                  child: Container(
                    width: screenWidth(context, mulBy: 0.3),
                    constraints: const BoxConstraints(
                        minWidth: 400,
                      minHeight: 60
                    ),
                    height: screenHeight(context, mulBy: 0.065),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        border: const Border(
                          bottom: BorderSide(
                              color: Colors.white,
                            width: 0.5
                          )
                        )
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.white,
                                width: 0.2
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 70,
                        height: 40,
                        decoration: BoxDecoration(
                            color: colorTemp,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.white,
                              width: 0.2
                            )
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth(context, mulBy: 0.15),
                        height: 55,
                        constraints: const BoxConstraints(
                            minWidth: 250
                        ),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.white,
                                width: 0.2
                            )
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hex: #${color.value.toRadixString(16)}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  ),
                            ),
                            IconButton(
                                onPressed:  () async {
                                  await Clipboard.setData(ClipboardData(text: "#${color.value.toRadixString(16)}"))
                                      .then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                            "Text Copied to clipboard",
                                            style: TextStyle(
                                                color: Colors.white
                                            ),
                                          ),
                                          backgroundColor: Colors.blueAccent,
                                          width: screenWidth(context, mulBy: 0.2),
                                          behavior: SnackBarBehavior.floating,


                                        )
                                    );
                                  });

                                },
                                icon: const Icon(Icons.copy, size: 22,)
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: screenWidth(context, mulBy: 0.15),
                        height: 55,
                        constraints: const BoxConstraints(
                            minWidth: 250
                        ),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.white,
                                width: 0.2
                            )
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'RGB: rgba(${color.red},${color.green},${color.blue},${color.alpha})',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            IconButton(

                                onPressed:  () async {
                                  await Clipboard.setData(ClipboardData(text: "rgba(${color.red},${color.green},${color.blue},${color.alpha})"))
                                      .then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                            "Text Copied to clipboard",
                                            style: TextStyle(
                                                color: Colors.white
                                            ),
                                          ),
                                          backgroundColor: Colors.blueAccent,
                                          width: screenWidth(context, mulBy: 0.2),
                                          behavior: SnackBarBehavior.floating,


                                        )
                                    );
                                  });

                                },
                                icon: const Icon(Icons.copy, size: 22,)
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

}
