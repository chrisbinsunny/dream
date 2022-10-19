
import 'dart:developer';
import 'dart:ui';

import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';
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
    opacity = Provider.of<ScrollDetail>(context, listen: true).getPos < screenHeight(context, mulBy: 0.1)
        ? Provider.of<ScrollDetail>(context, listen: true).getPos / screenHeight(context, mulBy: 0.1)
        : 1;
log(opacity.toString());
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100, ),
        child: Container(
          color: Colors.black.withOpacity(opacity/3),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'DREAM',
                  style: TextStyle(
                    color: Colors.blueGrey[100],
                    fontSize: 20,
                    fontFamily: 'Montserrat',
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
                        onTap: () {},
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
                        onTap: () {},
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Gradient Finder',
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
        ),
      ),
    );
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