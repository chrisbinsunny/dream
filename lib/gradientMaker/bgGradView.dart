import 'dart:ui';

import 'package:flutter/material.dart';

class BgGradient extends StatelessWidget {
  const BgGradient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [])
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
        ),
      ),
    ),;
  }
}
