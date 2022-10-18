
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';

import 'package:color_finder/colorDetails.dart';
import 'package:color_finder/dropFile/dropFile.dart';
import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;

import 'imagePixel.dart';

class ColorCode extends StatefulWidget {
  const ColorCode({Key? key, }) : super(key: key);


  @override
  State<ColorCode> createState() => _ColorCodeState();
}

class _ColorCodeState extends State<ColorCode> {

  late Color color, colorTemp;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    color=Provider.of<ColorDetails>(context, listen: true).getColor;
    colorTemp=Provider.of<ColorDetails>(context, listen: true).getColorTemp;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
        child: Container(
          width: screenWidth(context, mulBy: 0.35),
          height: screenHeight(context, mulBy: 0.4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Colors.white,

              )
          ),
          child: Row(
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
                    decoration: BoxDecoration(
                        color: color,
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
                          'Hex: #${color.value.toRadixString(16).substring(2)}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              ),
                        ),
                        IconButton(
                            onPressed:  () async {
                              await Clipboard.setData(ClipboardData(text: "#${color.value.toRadixString(16).substring(2)}"))
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
                    decoration: BoxDecoration(
                        color: color,
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
        ),
      ),
    );
  }

}
