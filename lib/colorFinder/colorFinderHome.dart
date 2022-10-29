import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
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
          const DropHere(),
          ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView(
              shrinkWrap: false,
              cacheExtent: 10000,
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  alignment: Alignment.center,
                  height: screenHeight(context, mulBy: 0.25),
                  child: FittedBox(
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Color Finder',
                          textStyle: GoogleFonts.oranienbaum(
                              fontSize: 50.0,
                              color: Colors.white,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2
                          ),
                          speed: const Duration(milliseconds: 60)
                        ),
                      ],
                      displayFullTextOnTap: true,
                    ),
                  ),
                ),
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceEvenly,
                  runSpacing: 20,
                  spacing: 20,
                  children: [
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
                                  decoration: TextDecoration.underline)),
                          TextSpan(
                            text: "Your browser handles everything.",
                          )
                        ]),
                    style: TextStyle(fontSize: 17),
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

class ImageShaderWidget extends StatelessWidget {
  const ImageShaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(
          "https://www.google.com/imgres?imgurl=https%3A%2F%2Fmiro.medium.com%2Fmax%2F1400%2F1*HVIwQmVuZdil6WuJxoMyPw.jpeg&imgrefurl=https%3A%2F%2Fwolfenrain.medium.com%2Fflutter-shaders-an-initial-look-d9eb98d3fd7a&tbnid=k9_QyWG8PPgfUM&vet=12ahUKEwjeqYf-qIL7AhX_y3MBHSKKB0UQMygIegUIARDOAQ..i&docid=k_LslFWvagFByM&w=1400&h=933&q=create%20shader%20in%20flutter&ved=2ahUKEwjeqYf-qIL7AhX_y3MBHSKKB0UQMygIegUIARDOAQ"),
    );
  }
}

class CutOutTextPainter extends CustomPainter {
  CutOutTextPainter({required this.text}) {
    _textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    _textPainter.layout();
  }

  final String text;
  late final TextPainter _textPainter;

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the text in the middle of the canvas
    final textOffset =
        size.center(Offset.zero) - _textPainter.size.center(Offset.zero);
    final textRect = textOffset & _textPainter.size;

    // The box surrounding the text should be 10 pixels larger, with 4 pixels corner radius
    final boxRect = RRect.fromRectAndRadius(
        textRect.inflate(10.0), const Radius.circular(4.0));
    final boxPaint = Paint()
      ..color = Colors.white
      ..blendMode = BlendMode.srcOut;

    canvas.saveLayer(boxRect.outerRect, Paint());

    _textPainter.paint(canvas, textOffset);
    canvas.drawRRect(boxRect, boxPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CutOutTextPainter oldDelegate) {
    return text != oldDelegate.text;
  }
}

// Container(
// width: screenWidth(context,
// mulBy: 0.4),
// height: screenHeight(context,
// mulBy: 0.15),
// alignment: Alignment.center,
// decoration: BoxDecoration(
// borderRadius:
// BorderRadius.circular(10),
// border: Border.all(
// color: Colors.white,
// ),
// ),
// child: ColorFiltered(
// colorFilter: ColorFilter.mode(
// Colors.white.withOpacity(0.1), BlendMode.srcOut, ), // This one will create the magic
// child: Stack(
// fit: StackFit.expand,
// children: [
// ClipRRect(
// child: BackdropFilter(
// filter: ImageFilter.blur(
// sigmaX: 60.0, sigmaY: 60.0,
// tileMode: TileMode.decal
// ),
// child: Container(
// decoration: BoxDecoration(
// color: Colors.white
//     .withOpacity(1),
// backgroundBlendMode: BlendMode.srcATop
//
// ),
// ),
// ),
// ),
// Center(
// child: Text(
// 'Hello World',
// style: TextStyle(fontSize: 70, fontWeight: FontWeight.w600,),
// ),
// )
// ],
// ),
// ),
// ),
