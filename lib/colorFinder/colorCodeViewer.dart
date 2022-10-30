import 'dart:developer';
import 'dart:ui';

import 'package:dream/colorDetails.dart';
import 'package:dream/upload/dropFile.dart';
import 'package:dream/sizes.dart';
import 'package:dream/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../analytics.dart';


class ColorCodeViewer extends StatefulWidget {
  const ColorCodeViewer({Key? key, }) : super(key: key);


  @override
  State<ColorCodeViewer> createState() => _ColorCodeViewerState();
}

class _ColorCodeViewerState extends State<ColorCodeViewer> {

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
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 20
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
          child: Container(
            width: screenWidth(context, mulBy: 0.25),
            height: screenHeight(context, mulBy: 0.26),
            constraints: const BoxConstraints(
                minWidth: 400,
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
                      width: screenWidth(context, mulBy: 0.25),
                      constraints: const BoxConstraints(
                          minWidth: 400,
                        minHeight: 70
                      ),
                      height: screenHeight(context, mulBy: 0.07),
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
                        vertical: 10,
                        horizontal: 15
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/imgIcon.png",
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: RichText(
                              maxLines: 2,
                                text: TextSpan(
                                  text: "${file!.name}\n",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    overflow: TextOverflow.clip,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: file!.mime,
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13
                                      ),
                                    )
                                  ]
                                ),

                            ),
                          ),
                          //Spacer(),
                          Text(
                            "${file!.size}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                Expanded(
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
                            constraints: const BoxConstraints(
                                minWidth: 220
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
                                SelectableText(
                                  'Hex: #${color.value.toRadixString(16)}',
                                  scrollPhysics: NeverScrollableScrollPhysics(),
                                  maxLines: 1,
                                  showCursor: false,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      ),
                                ),
                                IconButton(
                                    onPressed:  () async {
                                      await Clipboard.setData(ClipboardData(text: "#${color.value.toRadixString(16)}"))
                                          .then((value) {
                                        Provider.of<AnalyticsService>(context, listen: false)
                                            .logColorCopy(hex: true);
                                        ScaffoldMessenger.of(context).clearSnackBars();

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          DreamSnackBar(content:  const Text(
                                            "Text Copied to clipboard",
                                            style: TextStyle(
                                                color: Colors.white
                                            ),
                                          ), context: context)
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
                                minWidth: 220
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
                                SelectableText(
                                  'RGB: rgba(${color.red},${color.green},${color.blue},${color.alpha})',
                                  showCursor: false,
                                  scrollPhysics: NeverScrollableScrollPhysics(),
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                IconButton(

                                    onPressed:  () async {
                                      await Clipboard.setData(ClipboardData(text: "rgba(${color.red},${color.green},${color.blue},${color.alpha})"))
                                          .then((value) {
                                        Provider.of<AnalyticsService>(context, listen: false)
                                            .logColorCopy(hex: false);
                                        ScaffoldMessenger.of(context).clearSnackBars();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          DreamSnackBar(content: const Text(
                                            "Text Copied to clipboard",
                                            overflow: TextOverflow.clip,
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Colors.white
                                            ),
                                          ), context: context)
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

              ],
            ),
          ),
        ),
      ),
    );
  }

}
