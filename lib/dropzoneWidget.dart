import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class DropHere extends StatefulWidget {
  const DropHere({Key? key}) : super(key: key);

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
        cursor: CursorType.grab,
        onCreated: (DropzoneViewController ctrl) => controller = ctrl,
        onLoaded: () => print('Zone loaded'),
        onError: (String? ev) => print('Error: $ev'),
        onHover: () => print('Zone hovered'),
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
  }

}
