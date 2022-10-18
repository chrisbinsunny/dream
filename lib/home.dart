import 'package:color_finder/colorCode.dart';
import 'package:color_finder/dropFile/dropFile.dart';
import 'package:color_finder/imageView.dart';
import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'colorDetails.dart';
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
    file= Provider.of<ColorDetails>(context, listen: true).getFile;
    return Scaffold(
      body: Stack(

        children: [
          DropHere(
            onDroppedFile: (file)=> Provider.of<ColorDetails>(context, listen: false).setFile(file),
          ),
          ListView(
            shrinkWrap: false,
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
              Wrap(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceEvenly,
                children: const [
                  ImageViewer(),
                  ColorCode()
                ],
              )
            ],
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
                    TextSpan(
                      text: "We strongly support data privacy. ",
                      children: [
                        TextSpan(
                          text: "No data is being sent to our servers. ",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline
                          )
                        ),
                        TextSpan(
                          text: "Your browser handles everything.",
                        )
                      ]
                    ),
                    style: TextStyle(
                      fontSize: 17
                    ),
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
