import 'package:color_finder/widgets.dart';
import 'package:flutter/material.dart';

class ShareCode extends StatelessWidget {
  const ShareCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DreamButton(name: "Share design", onTap: (){})
      ],
    );
  }
}
