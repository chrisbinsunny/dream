import 'package:flutter/material.dart';

class DreamDrawer extends StatelessWidget {
  const DreamDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
      if(constraints.biggest.width<550){
        return const Drawer();
      }
      return SizedBox();
    },
    );
  }
}
