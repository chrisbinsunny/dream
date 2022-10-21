import 'dart:developer';

import 'package:color_finder/paletteViewer.dart';
import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import 'aa.dart';
import 'colorDetails.dart';
import 'dart:ui' as ui;
import 'upload/dropFile.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({Key? key,}) : super(key: key);
  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  DroppedFile? file;
  final imageKey = GlobalKey();

  List<int> imageDataList = List<int>.empty(growable: false);
  late ui.Image image;
  String _lastUrl= "", b="";
  Size _lastWindowSize = Size.zero;
  late Future<List<PaletteColor>> a;

@override
  void initState() {
  //file= Provider.of<ColorDetails>(context, listen: true).getFile;

  super.initState();
  }


  @override
  void didChangeDependencies() {
    //file= Provider.of<ColorDetails>(context, listen: true).getFile;

    //a= generatePalette("imagePath");

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    file= Provider.of<ColorDetails>(context, listen: true).getFile;
    return Container(
      width: screenWidth(context, mulBy: 0.35),

      //height: screenHeight(context, mulBy: 0.4),
      constraints: const BoxConstraints(
          minWidth: 500
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
            color: Colors.white
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.precise,
            onHover: (event) async {
              try{
                final windowSize = MediaQuery.of(context).size;
                if ((_lastWindowSize != windowSize) || (_lastUrl != file!.url)) {
                  print('capture image');
                  _lastWindowSize = windowSize;
                  _lastUrl=file!.url;
                  imageDataList = await captureImage();
                }
                Provider.of<ColorDetails>(context, listen: false).setColorTemp(getPixelColor(event.localPosition)!);
              }
              catch(e){
                log("1) ${e}");
              }
            },
            child: GestureDetector(
              onPanDown: (event) async {
                final windowSize = MediaQuery.of(context).size;
                if ((_lastWindowSize != windowSize) || (_lastUrl != file!.url)) {
                  print('capture image');
                  _lastWindowSize = windowSize;
                  _lastUrl=file!.url;
                  imageDataList = await captureImage();
                }
                Provider.of<ColorDetails>(context, listen: false).setColor(getPixelColor(event.localPosition)!);
              },
              onPanUpdate: (event) {
                Provider.of<ColorDetails>(context, listen: false).setColor(getPixelColor(event.localPosition)!);
              },
              child: RepaintBoundary(
                key: imageKey,
                child: Center(
                  child:
                  (file!.url!="#")?
                  Image.network(
                      file!.url,
                    fit: BoxFit.fitWidth,
                  ):
                  Image.asset(
                      "assets/img (1).jpg",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (_) => PaletteViewer(file: file!,),
                );
              },
              child: Text("View Palette")),
          // SizedBox(
          //   height: 30,
          //   child: FutureBuilder(
          //     future: a,
          //       builder: (context, snapshot){
          //       try{
          //         if(snapshot.hasData){
          //           return ListView.builder(
          //             itemCount: snapshot.data!.length,
          //               scrollDirection: Axis.horizontal,
          //               itemBuilder: (context, index){
          //                 return Container(
          //                   height: 30,
          //                   width: 30,
          //                   color: snapshot.data![index].color,
          //                 );
          //               });
          //         }
          //       }catch(e){
          //         setState(() {
          //           b=e.toString();
          //         });
          //       }
          //       return LinearProgressIndicator();
          //       },
          //   ),
          // ),
          Text(
             b
          )
        ],
      ),
    );

  }




  Color? getPixelColor(Offset position) {
    /// no process if we in a race condition while image is being captured
    /// and mouse/touch dragged around the screen.
    if (imageDataList.isEmpty) return null;
    final w = image.width;
    final h = image.height;
    final x = position.dx.round().clamp(0, w - 1);

    /// -1: index is 0 based.
    final y = position.dy.round().clamp(0, h - 1);

    final list = imageDataList;
    var i = y * (w * 4) + x * 4;

    /// pixels are encoded in `RGBA` in the List.
    return Color.fromARGB(
      list[i + 3],
      list[i],
      list[i + 1],
      list[i + 2],
    );
  }

  Future<List<int>> captureImage() async {
    final ro =
    imageKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    image = await ro.toImage();
    final bytes = (await image.toByteData(format: ui.ImageByteFormat.rawRgba))!;
    return bytes.buffer.asUint8List().toList(growable: false);
  }


}
