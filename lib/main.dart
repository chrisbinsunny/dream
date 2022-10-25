import 'dart:developer';

import 'package:color_finder/appBar.dart';
import 'package:color_finder/gradientMaker/gradientMakerDetails.dart';
import 'package:color_finder/gradientMaker/gradientMakerHome.dart';
import 'package:color_finder/home.dart';
import 'package:color_finder/palette/test.dart';
import 'package:color_finder/upload/dropFile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'colorDetails.dart';

///flutter run -d chrome --web-renderer canvaskit --release --dart-define=BROWSER_IMAGE_DECODING_ENABLED=false

///gradient-maker?c=FFEE000E&c=00B506&a=215&gt=2


void main() {
  // String myurl = Uri.base.toString(); //get complete url
  // List<String> para2 = Uri.base.queryParametersAll["c"]??[]; //get parameter with attribute "para2"
  // para2.forEach((element) {
  //   log(element);
  // });
  usePathUrlStrategy();
  Paint.enableDithering = true;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ColorDetails>(
      create: (context) => ColorDetails(),
    ),
    ChangeNotifierProvider<ScrollDetail>(
      create: (context) => ScrollDetail(),
    ),
    ChangeNotifierProvider<GradientMakerDetails>(
      create: (context) => GradientMakerDetails(),
    ),
  ],
      child: MyApp( uri:  Uri.base,)));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.uri});


  final Uri uri;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // @override
  // void initState() {
  //   Provider.of<GradientMakerDetails>(context, listen: false).setAngle(
  //       360-(double.tryParse(widget.uri.queryParameters["a"].toString())??45));
  //   Provider.of<GradientMakerDetails>(context, listen: false).setGradType(
  //       int.tryParse(widget.uri.queryParameters["gt"].toString())??0);
  //   Provider.of<GradientMakerDetails>(context, listen: false).setGrads(
  //       widget.uri.queryParametersAll["c"]??[]);
  //   widget.uri.queryParametersAll["c"]!.forEach((element) {
  //     log(element);
  //   });
  //   super.initState();
  // }

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
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/gradient-maker": (context)=> GradientMakerHome(),
      },
    onGenerateRoute: (settings) {
        log("Helloooooooooo");
        List<String> para2 = Uri.base.queryParametersAll["c"]??[]; //get parameter with attribute "para2"
        para2.forEach((element) {
          log(element);
        });
        switch(Uri.base.path){
          case "/gradient-maker":break;
        }
        log(Uri.base.path.toString());
      // final settingsUri = Uri.parse(settings.name!);
      // final postID = settingsUri.queryParameters['a'];
      // log(postID!);
      // if (settings.name == "/gradient-maker") {
      //   final settingsUri = Uri.parse(settings.name!);
      //   final postID = settingsUri.queryParameters['a'];
      //   log(postID!);
      //   return MaterialPageRoute(builder: (context)=> GradientMakerHome());
      // }
      return MaterialPageRoute(builder: (context) => const HomePage());
    }
    );
  }
}
