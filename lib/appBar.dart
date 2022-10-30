
import 'dart:developer';
import 'dart:ui';

import 'package:dream/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AppBarCustom extends StatefulWidget {

  const AppBarCustom({super.key});

  @override
  AppBarCustomState createState() => AppBarCustomState();
}

class AppBarCustomState extends State<AppBarCustom> {

  double opacity=0.1;

  final hovered=ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {
    opacity = (Provider.of<ScrollDetail>(context, listen: true).getPos < screenHeight(context, mulBy: 0.1))
        ? ((Provider.of<ScrollDetail>(context, listen: true).getPos > 0)?
    Provider.of<ScrollDetail>(context, listen: true).getPos / screenHeight(context, mulBy: 0.1):0
    )
        : 1;
    return Container(
      color: Colors.black.withOpacity(opacity), ///303030
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            ///Had to add a lesser width due to the padding of 40
            if(constraints.biggest.width<510){
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: (){
                        Scaffold.of(context).openDrawer();
                      },
                      icon: Icon(Icons.menu, size: 22,),
                    padding: EdgeInsets.zero,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'DREAM',
                    style: GoogleFonts.montserrat(
                      color: Colors.blueGrey[300],
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 5,
                    ),
                  ),
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'DREAM',
                  style: GoogleFonts.montserrat(
                    color: Colors.blueGrey[300],
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 5,
                  ),
                ),
                ValueListenableBuilder<int>(
                  valueListenable: hovered,
                  builder: (context, hover, child) {
                    return Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: screenWidth(context, mulBy: 0.125)),
                          InkWell(
                            onHover: (value) {
                              if(value){
                                hovered.value=0;
                              }else{
                                hovered.value=-1;
                              }
                            },
                            onTap: cfOnTap(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Color Finder',
                                  style: TextStyle(
                                    color: ((hover==0)||
                                        ((ModalRoute.of(context)!.settings.name=="/color-finder/")||
                                            (ModalRoute.of(context)!.settings.name=="/color-finder")||
                                            (ModalRoute.of(context)!.settings.name=="/")
                                        ))
                                        ? Colors.blue[200]
                                        : Colors.white,
                                    fontSize: 16
                                  ),
                                ),
                                SizedBox(height: 5),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 100),
                                  height: 2,
                                  curve: Curves.bounceIn,
                                  width: hover==0?80:0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                                Visibility(
                                  maintainAnimation: true,
                                  maintainState: true,
                                  maintainSize: true,
                                  visible:
                                  ((ModalRoute.of(context)!.settings.name=="/color-finder/")||
                                      (ModalRoute.of(context)!.settings.name=="/color-finder")||
                                      (ModalRoute.of(context)!.settings.name=="/")
                                  ),
                                  child: Container(
                                    height: 2,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: screenWidth(context, mulBy: 0.05)),
                          InkWell(
                            onHover: (value) {
                              if(value){
                                hovered.value=1;
                              }else{
                                hovered.value=-1;
                              }
                            },
                            onTap: gmOnTap(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Gradient Maker',
                                  style: TextStyle(
                                    color: ((hover==1)||
                                        ((ModalRoute.of(context)!.settings.name=="/gradient-maker/")||
                                            (ModalRoute.of(context)!.settings.name=="/gradient-maker")
                                        ))
                                        ? Colors.blue[200]
                                        : Colors.white,
                                      fontSize: 16

                                  ),
                                ),
                                SizedBox(height: 5),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 100),
                                  height: 2,
                                  curve: Curves.bounceIn,
                                  width: hover==1?100:0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                                Visibility(
                                  maintainAnimation: true,
                                  maintainState: true,
                                  maintainSize: true,
                                  visible:
                                  ((ModalRoute.of(context)!.settings.name=="/gradient-maker/")||
                                      (ModalRoute.of(context)!.settings.name=="/gradient-maker")
                                  ),
                                  child: Container(
                                    height: 2,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },)

              ],
            );
          },
          
        )
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