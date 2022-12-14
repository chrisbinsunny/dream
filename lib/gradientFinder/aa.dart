///
/// Live demo at:
///
/// https://roi-gradient-picker.surge.sh/
///
///
import 'dart:developer';
import 'dart:ui' as ui;
import 'package:dream/colorDetails.dart';
import 'package:dream/gradientFinder/colorPickerDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../sizes.dart';

class ColorPickerSample extends StatefulWidget {
  const ColorPickerSample({Key? key}) : super(key: key);

  @override
  _ColorPickerSampleState createState() => _ColorPickerSampleState();
}

class _ColorPickerSampleState extends State<ColorPickerSample> {
  final imageKey = GlobalKey();

  final onColorPicked = ValueNotifier<Color>(Colors.black);
  List<int> imageDataList = List<int>.empty(growable: false);
  late ui.Image image;
  int _gradientIdx = 0;
  late TextEditingController controller2, controller1;
  late Color gradColor1, gradColor2;

  GradientData get gradient => gradientData[_gradientIdx];
  Size _lastWindowSize = Size.zero;

  @override
  void initState() {
    controller1 = TextEditingController(text: "FFEE950F")
      ..addListener(() {
        Provider.of<ColorDetails>(context, listen: false)
            .setGrad1(Color(int.parse(controller1.text, radix: 16)));
      });
    controller2 = TextEditingController(text: "FF3F51B5")
      ..addListener(() {
        Provider.of<ColorDetails>(context, listen: false)
            .setGrad2(Color(int.parse(controller2.text, radix: 16)));
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    gradColor1 = Provider.of<ColorDetails>(context, listen: true).getGrad1;
    gradColor2 = Provider.of<ColorDetails>(context, listen: true).getGrad2;

    return Scaffold(
      extendBody: true,
      body: MouseRegion(
        cursor: SystemMouseCursors.precise,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            GestureDetector(
              onPanDown: (event) async {
                final windowSize = MediaQuery.of(context).size;

                /// re-capture the image only when the window size changed.
                /// We might use a LayoutBuilder or similar as well. Is just a way
                /// to optimize the CPU required to draw Image.
                if (_lastWindowSize != windowSize) {
                  print('capture image');
                  _lastWindowSize = windowSize;
                  imageDataList = await captureImage();
                }
                getPixelColor(event.localPosition);
              },
              onPanUpdate: (event) {
                getPixelColor(event.localPosition);
              },
              child: RepaintBoundary(
                key: imageKey,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [gradColor1, gradColor2]),
                  ),
                  child: Center(
                    child: Text(
                      gradient.name,
                      style: TextStyle(
                        foreground: Paint()
                          ..color = Colors.white
                          ..blendMode = BlendMode.overlay,
                        fontWeight: FontWeight.w200,
                        fontSize: 80,
                        shadows: [
                          const Shadow(color: Colors.black26, blurRadius: 20)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Material(
              type: MaterialType.transparency,
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => nextData(-1),
                    iconSize: 32,
                    color: Colors.white,
                    icon: const Icon(Icons.chevron_left),
                  ),
                  IconButton(
                    onPressed: () => nextData(1),
                    iconSize: 32,
                    color: Colors.white,
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 90),
              child: SizedBox.expand(
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.end,
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    ///Choose Color 1 Box
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
                        child: Container(
                          width: screenWidth(context, mulBy: 0.16),
                          height: (screenWidth(context) > 650)
                              ? screenHeight(context, mulBy: 0.20)
                              : 130,
                          constraints: const BoxConstraints(
                              minWidth: 290, minHeight: 000),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(10)),
                                child: BackdropFilter(
                                  filter: ui.ImageFilter.blur(
                                      sigmaX: 30.0,
                                      sigmaY: 30.0,
                                      tileMode: TileMode.decal),
                                  child: Container(
                                    width: screenWidth(context, mulBy: 0.16),
                                    height: screenHeight(context, mulBy: 0.05),
                                    constraints: const BoxConstraints(
                                        minWidth: 290, minHeight: 40),
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.1),
                                        border: const Border(
                                            bottom: BorderSide(
                                                color: Colors.white,
                                                width: 0.5))),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "Choose color #1",
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
                                child: SizedBox.expand(
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    alignment: WrapAlignment.spaceEvenly,
                                    runAlignment: WrapAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      const Text(
                                        "Hex: ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 170,
                                        child: TextField(
                                          controller: controller1,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          cursorColor: Colors.white,
                                          decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            hintText: "Hex Value",
                                          ),
                                          inputFormatters: [
                                            UpperCaseTextFormatter(),
                                            FilteringTextInputFormatter.allow(
                                                RegExp(kValidHexPattern))
                                          ],
                                        ),
                                      ),
                                      (screenWidth(
                                                context,
                                              ) <
                                              650)
                                          ? IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return ColorPickerDialog(
                                                        controller: controller1,
                                                        onSelect: () {
                                                          log(controller1.text);
                                                          Provider.of<ColorDetails>(
                                                                  context,
                                                                  listen: false)
                                                              .setGrad1(Color(
                                                                  int.parse(
                                                                      "FF${controller1.text}",
                                                                      radix:
                                                                          16)));
                                                        });
                                                  },
                                                );
                                              },
                                              icon: const FaIcon(
                                                FontAwesomeIcons.palette,
                                              ),
                                              style: ButtonStyle(
                                                shape: MaterialStateProperty
                                                    .all(const StadiumBorder(
                                                        side: BorderSide.none)),
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 15,
                                                            horizontal: 25)),
                                                enableFeedback: true,
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.black
                                                            .withOpacity(0.3)),
                                                overlayColor:
                                                    MaterialStateProperty.all(
                                                        Colors.deepPurpleAccent
                                                            .withOpacity(0.3)),
                                                shadowColor:
                                                    MaterialStateProperty.all(
                                                        Colors
                                                            .deepPurpleAccent),
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        0),
                                                side: MaterialStateProperty.all(
                                                    const BorderSide(
                                                        color: Colors.white)),
                                              ),
                                            )
                                          : ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return ColorPickerDialog(
                                                        controller: controller1,
                                                        onSelect: () {
                                                          log(controller1.text);
                                                          Provider.of<ColorDetails>(
                                                                  context,
                                                                  listen: false)
                                                              .setGrad1(Color(
                                                                  int.parse(
                                                                      "FF${controller1.text}",
                                                                      radix:
                                                                          16)));
                                                        });
                                                  },
                                                );
                                              },
                                              style: ButtonStyle(
                                                shape: MaterialStateProperty
                                                    .all(const StadiumBorder(
                                                        side: BorderSide.none)),
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 15,
                                                            horizontal: 25)),
                                                enableFeedback: true,
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.black
                                                            .withOpacity(0.3)),
                                                overlayColor:
                                                    MaterialStateProperty.all(
                                                        Colors.deepPurpleAccent
                                                            .withOpacity(0.3)),
                                                shadowColor:
                                                    MaterialStateProperty.all(
                                                        Colors
                                                            .deepPurpleAccent),
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        0),
                                                side: MaterialStateProperty.all(
                                                    const BorderSide(
                                                        color: Colors.white)),
                                              ),
                                              child: const Text(
                                                "Choose Color",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    ///Choose Color 2 Box
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
                        child: Container(
                          width: screenWidth(context, mulBy: 0.16),
                          height: (screenWidth(context) > 650)
                              ? screenHeight(context, mulBy: 0.20)
                              : 130,
                          constraints: const BoxConstraints(
                              minWidth: 290, minHeight: 000),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(10)),
                                child: BackdropFilter(
                                  filter: ui.ImageFilter.blur(
                                      sigmaX: 30.0,
                                      sigmaY: 30.0,
                                      tileMode: TileMode.decal),
                                  child: Container(
                                    width: screenWidth(context, mulBy: 0.16),
                                    height: screenHeight(context, mulBy: 0.05),
                                    constraints: const BoxConstraints(
                                        minWidth: 290, minHeight: 40),
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.1),
                                        border: const Border(
                                            bottom: BorderSide(
                                                color: Colors.white,
                                                width: 0.5))),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "Choose color #2",
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
                                child: SizedBox.expand(
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    alignment: WrapAlignment.spaceEvenly,
                                    runAlignment: WrapAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      const Text(
                                        "Hex: ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: 170,
                                        child: TextField(
                                          controller: controller2,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          cursorColor: Colors.white,
                                          decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                            hintText: "Hex Value",
                                          ),
                                          inputFormatters: [
                                            UpperCaseTextFormatter(),
                                            FilteringTextInputFormatter.allow(
                                                RegExp(kValidHexPattern))
                                          ],
                                        ),
                                      ),
                                      (screenWidth(
                                                context,
                                              ) <
                                              650)
                                          ? IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return ColorPickerDialog(
                                                        controller: controller2,
                                                        onSelect: () {
                                                          log(controller2.text);
                                                          Provider.of<ColorDetails>(
                                                                  context,
                                                                  listen: false)
                                                              .setGrad2(Color(
                                                                  int.parse(
                                                                      "FF${controller2.text}",
                                                                      radix:
                                                                          16)));
                                                        });
                                                  },
                                                );
                                              },
                                              icon: const FaIcon(
                                                FontAwesomeIcons.palette,
                                              ),
                                              style: ButtonStyle(
                                                shape: MaterialStateProperty
                                                    .all(const StadiumBorder(
                                                        side: BorderSide.none)),
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 15,
                                                            horizontal: 25)),
                                                enableFeedback: true,
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.black
                                                            .withOpacity(0.3)),
                                                overlayColor:
                                                    MaterialStateProperty.all(
                                                        Colors.deepPurpleAccent
                                                            .withOpacity(0.3)),
                                                shadowColor:
                                                    MaterialStateProperty.all(
                                                        Colors
                                                            .deepPurpleAccent),
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        0),
                                                side: MaterialStateProperty.all(
                                                    const BorderSide(
                                                        color: Colors.white)),
                                              ),
                                            )
                                          : ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return ColorPickerDialog(
                                                        controller: controller2,
                                                        onSelect: () {
                                                          Provider.of<ColorDetails>(
                                                                  context,
                                                                  listen: false)
                                                              .setGrad2(Color(
                                                                  int.parse(
                                                                      "FF${controller2.text}",
                                                                      radix:
                                                                          16)));
                                                        });
                                                  },
                                                );
                                              },
                                              style: ButtonStyle(
                                                shape: MaterialStateProperty
                                                    .all(const StadiumBorder(
                                                        side: BorderSide.none)),
                                                padding:
                                                    MaterialStateProperty.all(
                                                        const EdgeInsets
                                                                .symmetric(
                                                            vertical: 15,
                                                            horizontal: 25)),
                                                enableFeedback: true,
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.black
                                                            .withOpacity(0.3)),
                                                overlayColor:
                                                    MaterialStateProperty.all(
                                                        Colors.deepPurpleAccent
                                                            .withOpacity(0.3)),
                                                shadowColor:
                                                    MaterialStateProperty.all(
                                                        Colors
                                                            .deepPurpleAccent),
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        0),
                                                side: MaterialStateProperty.all(
                                                    const BorderSide(
                                                        color: Colors.white)),
                                              ),
                                              child: const Text(
                                                "Choose Color",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return ColorPickerDialog(
                  controller: controller2,
                  onSelect: () {
                    Provider.of<ColorDetails>(
                        context,
                        listen: false)
                        .setGrad2(Color(
                        int.parse(
                            "FF${controller2.text}",
                            radix:
                            16)));
                  });
            },
          );
        },
        style: ButtonStyle(
          shape: MaterialStateProperty
              .all(const StadiumBorder(
              side: BorderSide.none)),
          padding:
          MaterialStateProperty.all(
              const EdgeInsets
                  .symmetric(
                  vertical: 20,
                  horizontal: 25)),
          enableFeedback: true,
          backgroundColor:
          MaterialStateProperty.all(
              Colors.black
                  .withOpacity(0.3)),
          overlayColor:
          MaterialStateProperty.all(
              Colors.deepPurpleAccent
                  .withOpacity(0.3)),
          shadowColor:
          MaterialStateProperty.all(
              Colors
                  .deepPurpleAccent),
          elevation:
          MaterialStateProperty.all(
              0),
          side: MaterialStateProperty.all(
              const BorderSide(
                  color: Colors.white)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.copy,
              color: Colors.white,
            ),
            SizedBox(
              width: 7,
            ),
            const Text(
              "Copy HEX",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const AutomaticNotchedShape(
            RoundedRectangleBorder(), StadiumBorder()),
        elevation: 0,
        notchMargin: 8,
        clipBehavior: Clip.antiAlias,
        color: Colors.white.withOpacity(0.2),

        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 60,
            sigmaY: 60,
            tileMode: TileMode.decal
          ),
          child: Container(
            height: 50,
            decoration: BoxDecoration(

            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Flexible(
                      child: Text(
                    'picked color: ',
                    overflow: TextOverflow.ellipsis,
                  )),
                  ValueListenableBuilder<Color>(
                    valueListenable: onColorPicked,
                    builder: (_, color, child) => Text(
                      '#${color.value.toRadixString(16)}',
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            const Shadow(
                              color: Colors.black26,
                              blurRadius: 1.5,
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getPixelColor(Offset position) {
    /// no process if we in a race condition while image is being captured
    /// and mouse/touch dragged around the screen.
    if (imageDataList.isEmpty) return;
    final w = image.width;
    final h = image.height;
    final x = position.dx.round().clamp(0, w - 1);

    /// -1: index is 0 based.
    final y = position.dy.round().clamp(0, h - 1);

    final list = imageDataList;
    var i = y * (w * 4) + x * 4;

    /// pixels are encoded in `RGBA` in the List.
    onColorPicked.value = Color.fromARGB(
      list[i + 3],
      list[i],
      list[i + 1],
      list[i + 2],
    );
  }

  void nextData(int dir) {
    final maxIndex = gradientData.length - 1;
    _gradientIdx += dir;
    if (_gradientIdx < 0) {
      _gradientIdx = maxIndex;
    } else if (_gradientIdx > maxIndex) {
      _gradientIdx = 0;
    }

    /// we use `_lastWindowSize` make the "Image state" dirty, and re-create
    /// the Image with the new gradient.
    _lastWindowSize = Size.zero;
    setState(() {});
  }

  Future<List<int>> captureImage() async {
    final ro =
        imageKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    image = await ro.toImage();
    final bytes = (await image.toByteData(format: ui.ImageByteFormat.rawRgba))!;
    return bytes.buffer.asUint8List().toList(growable: false);
  }
}

/// --- model

class GradientData {
  final List<Color> colors;
  final String name;

  const GradientData({required this.colors, required this.name});

  GradientData.string(String name, List<String> colors)
      : this.colors = colorsFromStrings(colors),
        this.name = name;

  static List<Color> colorsFromStrings(List<String> list) =>
      list.map((str) => Color(int.parse(str.replaceAll('#', '0xff')))).toList();
}

final gradientData = <GradientData>[
  const GradientData(
    name: 'Dream Now',
    colors: [
      Color(0xff000000),
      Color(0xff394CB6),
    ],
  ),
  const GradientData(
    name: 'Dark Skies',
    colors: [Color(0xff4B79A1), Color(0xff283E51)],
  ),
  GradientData.string('Red Sunset', ['#355C7D', '#6C5B7B', '#C06C84']),
  GradientData.string('Shifter', ['#bc4e9c', '#f80759']),
  GradientData.string('Wedding Day Blues', ['#40E0D0', '#FF8C00', '#FF0080']),
  GradientData.string('Sand to Blue', ['#3E5151', '#DECBA4']),
  GradientData.string('Quepal', ['#11998e', '#38ef7d']),
  GradientData.string('Sublime Light', ['#FC5C7D', '#6A82FB']),
  GradientData.string('Sublime Vivid', ['#FC466B', '#3F5EFB']),
  GradientData.string('Bighead', ['#c94b4b', '#4b134f']),
  GradientData.string('Taran Tado', ['#23074d', '#cc5333']),
  GradientData.string('Relaxing red', ['#fffbd5', '#b20a2c']),
  GradientData.string('Lawrencium', ['#0f0c29', '#302b63', '#24243e']),
  GradientData.string('Ohhappiness', ['#00b09b', '#96c93d']),
  GradientData.string('Delicate', ['#D3CCE3', '#E9E4F0']),
];
