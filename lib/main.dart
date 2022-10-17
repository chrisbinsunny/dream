import 'package:color_finder/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Finder',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
