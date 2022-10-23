import 'dart:ui';

import 'package:color_finder/gradientMaker/gradientView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../colorDetails.dart';
import '../footer.dart';
import '../sizes.dart';
import '../upload/dropzoneWidget.dart';
import '../upload/uploadImage.dart';
import '../colorfinder/colorCodeViewer.dart';
import '../colorfinder/howToUse.dart';
import '../colorfinder/imageView.dart';

class GradientMakerHome extends StatelessWidget {
  const GradientMakerHome({Key? key, required this.scrollController}) : super(key: key);

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
                    "Gradient Maker",
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
                    const GradientViewer(),
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
        ],
      ),
    );
  }
}
