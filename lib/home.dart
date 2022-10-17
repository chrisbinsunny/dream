import 'package:color_finder/colorCode.dart';
import 'package:color_finder/dropFile/dropFile.dart';
import 'package:color_finder/imageView.dart';
import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';

import 'dropFile/dropzoneWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DroppedFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(

        children: [
          DropHere(
            onDroppedFile: (file)=> setState(() => this.file=file),
          ),
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                alignment: Alignment.center,
                height: screenHeight(context, mulBy: 0.2),
                child: const Text(
                  "Color Finder | Palette Finder",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ImageViewer(file: file),
                  ColorCode()
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
