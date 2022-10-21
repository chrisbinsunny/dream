

import 'package:color_finder/sizes.dart';
import 'package:color_finder/upload/dropFile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class PaletteViewer extends StatefulWidget {
  const PaletteViewer({Key? key, required this.file}) : super(key: key);

  final DroppedFile file;
  @override
  State<PaletteViewer> createState() => _PaletteViewerState();
}

class _PaletteViewerState extends State<PaletteViewer> {

  late Future<List<PaletteColor>> a;

  String _lastUrl= "", b="";
  @override
  void initState() {

    //a= generatePalette("imagePath");
    super.initState();
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
            SizedBox(
                height: 30,
                child: FutureBuilder(
                  future: generatePalette(""),
                    builder: (context, snapshot){
                    try{
                      if(snapshot.connectionState==ConnectionState.waiting)
                        return LinearProgressIndicator();
                      if(snapshot.hasData){
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                              return Container(
                                height: 30,
                                width: 30,
                                color: snapshot.data![index].color,
                              );
                            });
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


  Future<List<PaletteColor>> generatePalette(String imagePath) async {
    late PaletteGenerator paletteGenerator;

    try{
      if(widget.file.url=="#"){
        paletteGenerator = await PaletteGenerator.fromImageProvider(
            AssetImage("assets/img (1).jpg"),
            maximumColorCount: 20);
      }else{
        paletteGenerator = await PaletteGenerator.fromImageProvider(
            NetworkImage(widget.file.url),
            maximumColorCount: 20);
      }

    }catch(e){
      setState(
              (){
            b=e.toString();
          }
      );
    }
    // log(paletteGenerator.paletteColors.length.toString());
    // setState((){
    //   a=paletteGenerator.paletteColors.length.toString();
    //
    // });
    return paletteGenerator.paletteColors;
  }
}


class PaletteViewer1 extends StatelessWidget {
   PaletteViewer1({Key? key, required this.file}) : super(key: key);
  late Future<List<PaletteColor>> a;

  String _lastUrl= "", b="";
   final DroppedFile file;

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
            SizedBox(
              height: 30,
              child: FutureBuilder(
                future: start(),
                builder: (context, snapshot){
                  try{
                    if(snapshot.connectionState==ConnectionState.waiting)
                      return LinearProgressIndicator();
                    if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index){
                            return Container(
                              height: 30,
                              width: 30,
                              color: snapshot.data![index].color,
                            );
                          });
                    }
                  }catch(e){


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


  Future<List<PaletteColor>> generatePalette(String imagePath) async {
    late PaletteGenerator paletteGenerator;

    try{
      if(file.url=="#"){
        paletteGenerator = await PaletteGenerator.fromImageProvider(
            AssetImage("assets/img (1).jpg"),
            maximumColorCount: 20);
      }else{
        paletteGenerator = await PaletteGenerator.fromImageProvider(
            NetworkImage(file.url),
            maximumColorCount: 20);
      }

    }catch(e){

    }
    // log(paletteGenerator.paletteColors.length.toString());
    // setState((){
    //   a=paletteGenerator.paletteColors.length.toString();
    //
    // });
    return paletteGenerator.paletteColors;
  }

   Future<List<PaletteColor>> start() async {
     return await compute(generatePalette, "");
   }

  }
