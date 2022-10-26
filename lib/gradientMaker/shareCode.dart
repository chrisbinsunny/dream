import 'dart:developer';

import 'package:color_finder/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../sizes.dart';
import 'gradientMakerDetails.dart';

class ShareCode extends StatelessWidget {
  ShareCode({Key? key}) : super(key: key);

  late double angle;
  List<Color> grads=[];
  late int gradType;


  @override
  Widget build(BuildContext context) {
    grads= Provider.of<GradientMakerDetails>(context, listen: true).getGrads;
    angle= Provider.of<GradientMakerDetails>(context, listen: true).getAngle;
    gradType= Provider.of<GradientMakerDetails>(context, listen: true).getGradType;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DreamButton(
            name: "Share design",
            onTap: (){
              String a= Uri.base.origin;
              a+="/gradient-maker?a=${360-angle}&gt=$gradType";
              grads.forEach((element) {
                a+="&c=${element.value.toRadixString(16)}";
              });
              log(a);
            },
          icon: FontAwesomeIcons.solidPaperPlane,
        ),
        const SizedBox(
          width: 20,
        ),
        DreamButton(
          name: "Copy CSS",
          onTap: () async{
            String a="background: rgb(${grads.first.red},${grads.first.green},${grads.first.blue},);\n"
            "background: -moz-${getValueCode()}"
                "background: -webkit-${getValueCode()}"
                "background: ${getValueCode()}"
            'filter: progid:DXImageTransform.Microsoft.gradient(startColorstr="#${grads.first.value.toRadixString(16)}"'
                ',endColorstr="#${grads.last.value.toRadixString(16)}",GradientType=1);';
            await Clipboard.setData(ClipboardData(text: a))
                .then((value) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [

                        Icon(
                          FontAwesomeIcons.code,
                          size: 22,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Code Copied to clipboard",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.blueAccent,
                    width: screenWidth(context, mulBy: 0.2),
                    behavior: SnackBarBehavior.floating,


                  )
              );
            });
          },
          icon: FontAwesomeIcons.code,
        )
      ],
    );
  }

  String getValueCode(){

    String gradient="", degree="", a="";

    switch(gradType){
      case 0: gradient= "linear-gradient";
      break;
      case 1: gradient= "radial-gradient";
      break;
      case 2: gradient= "NOT-SUPPORTED";
      break;
    }

    if(gradType==1){
      degree= "circle";
    }else{
      degree= "${-(angle-360)}deg";
    }
    a+="$gradient($degree${getColorData()});\n";

    return a;
  }


  String getColorData(){

    String a="", sub="";

    for(var i = 0; i < grads.length; i++){

      sub= ", rgba(${grads[i].red},${grads[i].green},${grads[i].blue},"
          "${grads[i].alpha}) ${((i/(grads.length-1))*100).toStringAsFixed(2)}%";
      a+=sub;
    }

    return a;
  }
}
