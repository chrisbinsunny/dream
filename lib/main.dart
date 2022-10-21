import 'package:color_finder/appBar.dart';
import 'package:color_finder/home.dart';
import 'package:color_finder/palette/test.dart';
import 'package:color_finder/upload/dropFile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'colorDetails.dart';

///flutter run -d chrome --web-renderer canvaskit --release --dart-define=BROWSER_IMAGE_DECODING_ENABLED=false

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ColorDetails>(
      create: (context) => ColorDetails(),
    ),
    ChangeNotifierProvider<ScrollDetail>(
      create: (context) => ScrollDetail(),
    ),
  ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme()

      ),
      home: const HomePage(),
    );
  }
}
