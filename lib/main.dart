import 'package:color_finder/home.dart';
import 'package:color_finder/test.dart';
import 'package:color_finder/upload/dropFile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'colorDetails.dart';

///flutter run -d chrome --web-renderer canvaskit --release --dart-define=BROWSER_IMAGE_DECODING_ENABLED=false

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ColorDetails>(
      create: (context) => ColorDetails(),
    ),
    ChangeNotifierProvider<ColorDetails>(
      create: (context) => ColorDetails(),
    ),
  ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
