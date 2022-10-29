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
      create: (context) => GradientMakerDetails(
        angle: fixAngle(),
        gradientType: fixGradientType(),
        grads: fixGrads()
      ),
    ),
  ],
      child: const MyApp()));
}


fixGradientType(){
  int? gt= int.tryParse(Uri.base.queryParameters["gt"].toString());
  if(gt==null|| gt>2){
    gt=0;
  }
  return gt;
}

fixAngle(){
  double? a= double.tryParse(Uri.base.queryParameters["a"].toString());
  if(a==null|| a>360 || a<0){
    a=45;
  }
  return 360-a;
}

fixGrads(){
  List<Color> grads;
  if(Uri.base.queryParametersAll["c"]==null || Uri.base.queryParametersAll["c"]!.length<2){
    grads=[Color(0xFFEE950F), Color(0xFF3F51B5)];
  }
  else{
    grads= Uri.base.queryParametersAll["c"]!.map((e) => Color((int.tryParse(e, radix: 16)??int.parse("FF3F51B5", radix: 16))+ 0xFF000000)).toList();
  }

  return grads;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Color Finder',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            textTheme: TextTheme(
              headline1: GoogleFonts.poppins(color: Colors.white, ),
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
            ),

        ),
        initialRoute: "/",
        routes: {
          "/": (context) => const HomePage(),
          "/color-finder": (context) => const HomePage(),
          "/color-finder/": (context) => const HomePage(),
          "/gradient-maker": (context)=> const GradientMakerHome(),
          "/gradient-maker/": (context)=> const GradientMakerHome(),
        },
        onGenerateRoute: (settings) {
          late Route route=MaterialPageRoute(builder: (context) => const HomePage());
          List<String> para2 = Uri.base.queryParametersAll["c"]??[];
          para2.forEach((element) {
            log(element);
          });
          switch(Uri.base.path){
            case "/gradient-maker":
            case "/gradient-maker/":
              route=MaterialPageRoute(builder: (context) => const GradientMakerHome());
              break;
            case "/color-finder":
            case "/color-finder/":
              route=MaterialPageRoute(builder: (context) => const HomePage());
              break;
          }
          log(Uri.base.path.toString());
          return route;
        }
    );
  }
  }

