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
          textTheme: TextTheme(
            headline1: GoogleFonts.poppins(color: Colors.white),
            headline2: GoogleFonts.poppins(color: Colors.white),
            headline3: GoogleFonts.poppins(color: Colors.white),
            headline4: GoogleFonts.poppins(color: Colors.white),
            headline5: GoogleFonts.poppins(color: Colors.white),
            headline6: GoogleFonts.poppins(color: Colors.white),
            subtitle1: GoogleFonts.poppins(color: Colors.white),
            subtitle2: GoogleFonts.poppins(color: Colors.white),
            bodyText1: GoogleFonts.poppins(color: Colors.white),
            bodyText2: GoogleFonts.poppins(color: Colors.white),
            button: GoogleFonts.poppins(color: Colors.white),
            caption: GoogleFonts.poppins(color: Colors.white),
            overline: GoogleFonts.poppins(color: Colors.white),
          )


      ),
      home: const HomePage(),
    );
  }
}
