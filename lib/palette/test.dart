import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';


class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Palette Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage1(),
    );
  }
}

class HomePage1 extends StatefulWidget {
  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  final String images = 'https://storage.googleapis.com/cms-storage-bucket/ed2e069ee37807f5975a.jpg';
  late List<PaletteColor> bgColors;
  String a="Nepal, The 8th Wonder";
  late PaletteGenerator palette;

  @override
  void initState() {
    super.initState();
    _updatePalette();
  }

  Future _updatePalette() async {
    try {
      palette = await PaletteGenerator.fromImageProvider(
          const AssetImage("assets/img (1).jpg"));
    } catch (e) {
      a=e.toString();
      log(e.toString());
    }
    setState(() {

    });
    return palette.paletteColors;
  }
  // _updatePalette() async {
  //   try{
  //   bgColors = [];
  //   PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
  //     NetworkImage(images),
  //     //size: const Size(200, 100),
  //   );
  //
  //   bgColors= palette.paletteColors;
  //   a=      bgColors.length.toString();
  //   // palette.darkMutedColor != null ? bgColors.add(
  //   //     palette.darkMutedColor!
  //   //
  //   // ) : bgColors.add(PaletteColor(Colors.red,3));
  //
  //   setState(() {});
  //   }catch(e){
  //     log(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beautiful Nepal'),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 400,
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(
                    image: NetworkImage(
                      images
                    ),
                    fit: BoxFit.cover
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: FutureBuilder(
              future: _updatePalette(),
              builder: (context, snapshot) {
                try{
                  if(snapshot.hasData){
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: snapshot.data[index],
                          width: 40,
                          height: 40,
                        );
                      },
                    );
                  }
                }catch(e){
                  a=e.toString();
                  setState(() {

                  });
                }
                return CircularProgressIndicator();
              },
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(32.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color:  Colors.white
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(a,style: TextStyle(
                      color:  Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0
                  ),),
                  const SizedBox(height: 10.0),
                  Text("Lorem ipsum dolor sit amet consectetur adipisicing elit. Id obcaecati tenetur enim et dolore aut dolorum! Fugiat omnis amet atque quos sapiente similique, tempore, vitae eos perferendis cupiditate libero odit.",textAlign: TextAlign.justify,style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}