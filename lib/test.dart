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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String images = 'https://storage.googleapis.com/cms-storage-bucket/ed2e069ee37807f5975a.jpg';
  late List<PaletteColor> bgColors;
  late int _currentIndex;
  String a="Nepal, The 8th Wonder";

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _updatePalette();
  }

  _updatePalette() async {
    try{
    bgColors = [];
    PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
      NetworkImage(images),
      //size: const Size(200, 100),
    );

    bgColors= palette.paletteColors;
    a=      bgColors.length.toString();
    // palette.darkMutedColor != null ? bgColors.add(
    //     palette.darkMutedColor!
    //
    // ) : bgColors.add(PaletteColor(Colors.red,3));

    setState(() {});
    }catch(e){
      log(e.toString());
    }
  }

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
          Expanded(
            child: ListView.builder(
              itemCount: bgColors.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
              return Container(
                width: 30,
                height: 30,
                color: bgColors[index].color,
              );
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