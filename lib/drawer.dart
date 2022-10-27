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
              )
            ],
          ),
        );
      }
      if(
      Scaffold.of(context).isDrawerOpen
      ){
        Scaffold.of(context).closeDrawer();
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
