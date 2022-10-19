import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class ColorPickerSample extends StatefulWidget {
  // static void init() {
  //   runApp(MaterialApp(
  //     home: ColorPickerSample(),
  //     title: 'playground',
  //   ));
  // }

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

  GradientData get gradient => gradientData[_gradientIdx];
  Size _lastWindowSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseRegion(
        cursor: SystemMouseCursors.precise,
        child: Stack(
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
                    gradient: LinearGradient(colors: gradient.colors),
                  ),

                  child: Center(
                    child: Container(
                      height: 1000,
                      width: 1000,
                      child: Image.network(
                          "https://storage.googleapis.com/cms-storage-bucket/65361d7e1dfa118aa63b.png"
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
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Flexible(
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
                          Shadow(
                            color: Colors.black26,
                            blurRadius: 1.5,
                          )
                        ]),
                  ),
                ),
              ],
            ),
          )),
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
  GradientData(
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


class DrawImage extends StatefulWidget {
  const DrawImage({Key? key}) : super(key: key);

  @override
  State<DrawImage> createState() => _DrawImageState();
}

class _DrawImageState extends State<DrawImage> {
  ui.Image? _image;

  void loadImage() async {
    final data = await rootBundle.load('assets/img.png');
    _image= await decodeImageFromList(data.buffer.asUint8List());
  }

  @override
  void initState() {
    loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ImageEditor(_image),
    );
  }
}

class ImageEditor extends CustomPainter {
  ui.Image? image;

  ImageEditor(this.image) : super();

  @override
  Future paint(Canvas canvas, Size size) async {
    if (image != null) {
      canvas.drawImage(image!, Offset(0.0, 0.0), Paint());
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return image != (oldDelegate as ImageEditor).image;
  }
}