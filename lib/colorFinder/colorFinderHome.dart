import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../colorDetails.dart';
import '../footer.dart';
import '../sizes.dart';
import '../upload/dropzoneWidget.dart';
import '../upload/uploadImage.dart';
import 'colorCodeViewer.dart';
import 'howToUse.dart';
import 'imageView.dart';

class ColorFinderHome extends StatelessWidget {
  ColorFinderHome({Key? key, required this.scrollController}) : super(key: key);

  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      thickness: 11,
      interactive: true,
      radius: const Radius.circular(0),
      trackVisibility: false,
      thumbVisibility: true,
      child: Stack(
        children: [
          const DropHere( ),

          ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView(
              shrinkWrap: false,
              cacheExtent: 10000,
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  alignment: Alignment.center,
                  height: screenHeight(context, mulBy: 0.25),
                  //color: Colors.black,
                  child: const Text(
                    "Color Finder | Palette Finder",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceEvenly,
                  runSpacing: 20,
                  spacing: 20,
                  children:  [
                    const ImageViewer(),
                    Column(
                      children: const [
                        ColorCodeViewer(),
                        SizedBox(
                          height: 20,
                        ),
                        UploadImage(),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: HowToUse(),
                ),
                const SizedBox(
                  height: 60,
                ),
                const Footer()
              ],
            ),
          ),

          Visibility(
            visible: Provider.of<ColorDetails>(context, listen: true).getHover,
            child: Container(
              color: Colors.black.withOpacity(0.9),
              height: screenHeight(context),
              width: screenWidth(context),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.cloud_upload,
                    size: 140,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                        text: "We strongly support data privacy. ",
                        children: [
                          TextSpan(
                              text: "No data is being sent to our servers. ",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  decoration: TextDecoration.underline
                              )
                          ),
                          TextSpan(
                            text: "Your browser handles everything.",
                          )
                        ]
                    ),
                    style: TextStyle(
                        fontSize: 17
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
