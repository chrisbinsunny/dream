import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class DreamDrawer extends StatelessWidget {
  const DreamDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
      if(constraints.biggest.width<550){
        return Drawer(
          backgroundColor: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DrawerHeader(
                child: Center(
                  child: Text(
                  'DREAM',
                  style: GoogleFonts.montserrat(
                    color: Colors.blueGrey[300],
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 5,
                  ),
              ),
                ),

              ),
              ListTile(
                title: const Text(
                    "Color Finder",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),
                ),
                onTap: cfOnTap(context),
                hoverColor:Colors.deepPurpleAccent.withOpacity(0.1),
                focusColor: Colors.deepPurpleAccent.withOpacity(0.3),
                enabled: true,
                selectedTileColor: Colors.deepPurpleAccent.withOpacity(0.3),
                selected: ((ModalRoute.of(context)!.settings.name=="/color-finder/")||
                    (ModalRoute.of(context)!.settings.name=="/color-finder")||
                    (ModalRoute.of(context)!.settings.name=="/")
                ),
                trailing: const Icon(
                  Icons.navigate_next,
                  color: Colors.white,
                ),
              ),
              ListTile(
                title: const Text(
                  "Gradient Maker",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                  ),
                ),
                onTap: gmOnTap(context),
                hoverColor: Colors.deepPurpleAccent.withOpacity(0.1),
                focusColor: Colors.deepPurpleAccent.withOpacity(0.3),
                enabled: true,
                selectedTileColor: Colors.deepPurpleAccent.withOpacity(0.3),
                selected: ((ModalRoute.of(context)!.settings.name=="/gradient-maker/")||
        (ModalRoute.of(context)!.settings.name=="/gradient-maker")
        ),
                trailing: const Icon(
                  Icons.navigate_next,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Container(
                height: 50,
                width: 50,
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20
                ),
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(
                    CupertinoIcons.xmark,
                    color: Colors.white,
                  ), onPressed: () {
                    Scaffold.of(context).closeDrawer();
                },
                ),
              ),
            ],
          ),
        );
      }
      if(
      Scaffold.of(context).isDrawerOpen
      ){
        Timer(Duration.zero, () {
          Scaffold.of(context).closeDrawer();
        },);
      }
      return const SizedBox();
    },
    );
  }



  VoidCallback? gmOnTap(BuildContext context){
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

  VoidCallback? cfOnTap(BuildContext context){
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
