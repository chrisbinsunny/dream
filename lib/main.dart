import 'dart:developer';

import 'package:dream/appBar.dart';
import 'package:dream/gradientMaker/gradientMakerDetails.dart';
import 'package:dream/gradientMaker/gradientMakerHome.dart';
import 'package:dream/home.dart';
import 'package:dream/palette/test.dart';
import 'package:dream/upload/dropFile.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'analytics.dart';
import 'colorDetails.dart';
import 'firebase_options.dart';

///flutter run -d chrome --web-renderer canvaskit --release --dart-define=BROWSER_IMAGE_DECODING_ENABLED=false

///gradient-maker?c=FFEE000E&c=00B506&a=215&gt=2


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

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
    ChangeNotifierProvider<AnalyticsService>(
      create: (context) => AnalyticsService(),
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
    grads=[Color(0xFF9600EE), Color(0xFFFFC80F)];
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
        navigatorObservers: [
          Provider.of<AnalyticsService>(context, listen: false)
              .getAnalyticsObserver()
        ],
        initialRoute: "/",
        routes: {
          "/": (context) => const ColorFinderHomePage(),
          "/color-finder": (context) => const ColorFinderHomePage(),
          "/color-finder/": (context) => const ColorFinderHomePage(),
          "/gradient-maker": (context)=> const GradientMakerHome(),
          "/gradient-maker/": (context)=> const GradientMakerHome(),
        },
        onGenerateRoute: (settings) {
          late Route route=MaterialPageRoute(builder: (context) => const ColorFinderHomePage());
          switch(Uri.base.path){
            case "/gradient-maker":
            case "/gradient-maker/":
              route=MaterialPageRoute(builder: (context) => const GradientMakerHome(),
                  settings: const RouteSettings(name: "Gradient Maker"),
              );
              break;
            case "/color-finder":
            case "/color-finder/":
              route=MaterialPageRoute(builder: (context) => const ColorFinderHomePage(),
                settings: const RouteSettings(name: "Color Finder"),
              );
              break;
          }
          return route;
        }
    );
  }
  }

