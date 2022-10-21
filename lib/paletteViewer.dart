

import 'package:color_finder/sizes.dart';
import 'package:color_finder/upload/dropFile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:http/http.dart' as http;

import 'generator.dart';

class PaletteViewer extends StatefulWidget {
  const PaletteViewer({Key? key, required this.file}) : super(key: key);

  final DroppedFile file;
  @override
  State<PaletteViewer> createState() => _PaletteViewerState();
}

class _PaletteViewerState extends State<PaletteViewer> {

  late Future<List<Color>> a;
  List<Color> colors = [];
  List<Color> sortedColors = [];
  List<Color> palette = [];
  Uint8List? imageBytes;

  Color primary = Colors.blueGrey;
  Color primaryText = Colors.black;
  Color background = Colors.white;


  String _lastUrl= "", b="", photo="";

  @override
  void initState() {
    super.initState();
    a=extractColors();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: screenHeight(context, mulBy: 0.5),
        width: screenWidth(context, mulBy: 0.5),
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Wait for it"),

            Expanded(
              child: FutureBuilder(
                future: a,
                  builder: (context, snapshot){
                  try{
                    if(snapshot.connectionState==ConnectionState.waiting)
                      return LinearProgressIndicator();
                    if(snapshot.hasData){
                      return Container(
                        color: Colors.white.withOpacity(0.5),
                        padding: EdgeInsets.only(top: 6, bottom: 16),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text('Palette of 10 colors:'),
                            SizedBox(height: 10),
                            _getPalette()
                          ],
                        ),
                      );
                    }
                  }catch(e){

                    setState(() {
                      b=e.toString();
                    });
                    return Text(
                        b
                    );
                  }
                  return LinearProgressIndicator();
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<List<Color>> extractColors() async {
    colors = [];
    sortedColors = [];
    palette = [];
    imageBytes = null;

    photo = widget.file.url;

    imageBytes = (await http.get(Uri.parse(photo))).bodyBytes;

    colors = await compute(extractPixelsColors, imageBytes);
    sortedColors = await compute(sortColors, colors);
    palette = await compute(
        generatePalette, {keyPalette: colors, keyNoOfItems: 10});
    primary = palette.last;
    primaryText = palette.first;
    background = palette.first.withOpacity(0.5);
    return palette;
  }


  Widget _getPalette() {
    return SizedBox(
      height: 50,
      child: palette.isEmpty
          ? Container(
        child: CircularProgressIndicator(),
        alignment: Alignment.center,
        height: 100,
      )
          : ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: palette.length,
        itemBuilder: (BuildContext context, int index) => Container(
          color: palette[index],
          height: 50,
          width: 50,
        ),
      ),
    );
  }
}


