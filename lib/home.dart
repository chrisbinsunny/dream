import 'package:color_finder/dropFile/dropFile.dart';
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
          Container(
            child: Column(
              children: [
                
              ],
            ),
          )
        ],
      ),
    );
  }
}
