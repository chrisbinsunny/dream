import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

import 'dropFile.dart';

class DropHere extends StatefulWidget {
  const DropHere({Key? key, required this.onDroppedFile}) : super(key: key);

  final ValueChanged<DroppedFile> onDroppedFile;

  @override
  State<DropHere> createState() => _DropHereState();
}

class _DropHereState extends State<DropHere> {
  late DropzoneViewController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent.withOpacity(0.2),
      child: DropzoneView(
        operation: DragOperation.copy,
        onCreated: (DropzoneViewController ctrl) => controller = ctrl,
        onLoaded: () => print('Zone loaded'),
        onDrop: acceptFile,
        onLeave: () => print('Zone left'),
      ),
    );
  }


  Future acceptFile(dynamic event) async {
    final name = event.name;
    final mime = await controller.getFileMIME(event);
    final bytes = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);
    print('Name: $name');
    print('Mime: $mime');
    print('Bytes: $bytes');
    print('Url: $url');

    final droppedFile = DroppedFile(
      url: url,
      name: name,
      mime: mime,
      bytes: bytes,
    );

    widget.onDroppedFile(droppedFile);
  }

}
