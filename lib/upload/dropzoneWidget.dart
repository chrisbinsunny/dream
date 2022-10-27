import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:provider/provider.dart';

import '../colorDetails.dart';
import 'dropFile.dart';

class DropHere extends StatefulWidget {
  const DropHere({Key? key, }) : super(key: key);


  @override
  State<DropHere> createState() => _DropHereState();
}

class _DropHereState extends State<DropHere> {

  DroppedFile? file;
  @override
  Widget build(BuildContext context) {
    file=Provider.of<ColorDetails>(context, listen: true).getFile;
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: (file!.url!="#")?Image.network(file!.url).image:Image.asset("assets/img (1).jpg").image,
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.8)),
          child: DropzoneView(
            operation: DragOperation.copy,
            onCreated: (DropzoneViewController ctrl) =>controller=ctrl,
            onLoaded: () => print('Zone loaded'),
            onDrop: acceptFile,
            onLeave: () {
              Provider.of<ColorDetails>(context, listen: false).setHover(false);
            },
            onHover: (){
              Provider.of<ColorDetails>(context, listen: false).setHover(true);
            },
          ),
        ),
      ),
    );
  }


  Future acceptFile(dynamic event) async {
    Provider.of<ColorDetails>(context, listen: false).setHover(false);

    final name = event.name;
    final mime = await controller.getFileMIME(event);
    final bytes = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);

    final droppedFile = DroppedFile(
      url: url,
      name: name,
      mime: mime,
      bytes: bytes,
    );
    Provider.of<ColorDetails>(context, listen: false).setFile(droppedFile);
  }

}
