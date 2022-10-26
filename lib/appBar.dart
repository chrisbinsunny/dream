
import 'dart:developer';
import 'dart:ui';

import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AppBarCustom extends StatefulWidget {

  const AppBarCustom({super.key});

  @override
  AppBarCustomState createState() => AppBarCustomState();
}

class AppBarCustomState extends State<AppBarCustom> {
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  double opacity=0.1;


  @override
  Widget build(BuildContext context) {
    opacity = (Provider.of<ScrollDetail>(context, listen: true).getPos < screenHeight(context, mulBy: 0.1))
        ? ((Provider.of<ScrollDetail>(context, listen: true).getPos > 0)?
    Provider.of<ScrollDetail>(context, listen: true).getPos / screenHeight(context, mulBy: 0.1):0
    )
        : 1;
    return Container(
      color: Colors.black.withOpacity(opacity), ///303030
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'DREAM',
              style: GoogleFonts.montserrat(
                color: Colors.blueGrey[300],
                fontSize: 25,
                fontWeight: FontWeight.w600,
                letterSpacing: 5,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: screenWidth(context, mulBy: 0.125)),
                  InkWell(
                    onHover: (value) {
                      setState(() {
                        value
                            ? _isHovering[0] = true
                            : _isHovering[0] = false;
                      });
                    },
                    onTap: cfOnTap(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Color Finder',
                          style: TextStyle(
                            color: _isHovering[0]
                                ? Colors.blue[200]
                                : Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          maintainSize: true,
                          visible: _isHovering[0],
                          child: Container(
                            height: 2,
                            width: 20,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: screenWidth(context, mulBy: 0.05)),
                  InkWell(
                    onHover: (value) {
                      setState(() {
                        value
                            ? _isHovering[1] = true
                            : _isHovering[1] = false;
                      });
                    },
                    onTap: gmOnTap(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Gradient Maker',
                          style: TextStyle(
                            color: _isHovering[1]
                                ? Colors.blue[200]
                                : Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          maintainSize: true,
                          visible: _isHovering[1],
                          child: Container(
                            height: 2,
                            width: 20,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  VoidCallback? gmOnTap(){
    switch(ModalRoute.of(context)!.settings.name){
      case "/gradient-maker":
      case "/gradient-maker/":
        return null;
        break;
      case "/color-finder":
      case "/color-finder/":
      case "/":
        return (){
          Navigator.of(context).pushNamed("/gradient-maker");
        };
        break;
    }
    return null;
  }

  VoidCallback? cfOnTap(){
    switch(ModalRoute.of(context)!.settings.name){
      case "/gradient-maker":
      case "/gradient-maker/":
      return (){
        Navigator.of(context).pushNamed("/color-finder");
      };
        break;
      case "/color-finder":
      case "/color-finder/":
      case "/":
      return null;

      break;
    }
    return null;
  }
}


class ScrollDetail extends ChangeNotifier{
  double scrollPosition = 0;


  double get getPos{
    return scrollPosition+0.1;
  }

  void setPos(double pos){
    scrollPosition= pos;
    notifyListeners();
  }
}