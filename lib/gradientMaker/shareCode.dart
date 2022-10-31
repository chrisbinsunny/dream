import 'dart:developer';

import 'package:dream/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../analytics.dart';
import '../sizes.dart';
import 'gradientMakerDetails.dart';

class ShareCodeButtons extends StatelessWidget {
  ShareCodeButtons({Key? key}) : super(key: key);

  late double angle;
  List<Color> grads=[];
  late int gradType;


  @override
  Widget build(BuildContext context) {
    grads= Provider.of<GradientMakerDetails>(context, listen: true).getGrads;
    angle= Provider.of<GradientMakerDetails>(context, listen: true).getAngle;
    gradType= Provider.of<GradientMakerDetails>(context, listen: true).getGradType;
    return FittedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // DreamButton(
          //     name: "Share design",
          //     onTap: ()async{
          //       String a= Uri.base.origin;
          //       a+="/gradient-maker?a=${360-angle}&gt=$gradType";
          //       grads.forEach((element) {
          //         a+="&c=${element.value.toRadixString(16)}";
          //       });
          //       log(a);
          //       await Clipboard.setData(ClipboardData(text: a))
          //           .then((value) {
          //             ScaffoldMessenger.of(context).clearSnackBars();
          //         ScaffoldMessenger.of(context).showSnackBar(
          //             DreamSnackBar(content: Row(
          //               mainAxisSize: MainAxisSize.min,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: const [
          //
          //                 Icon(
          //                   FontAwesomeIcons.solidPaperPlane,
          //                   size: 22,
          //                 ),
          //                 SizedBox(
          //                   width: 20,
          //                 ),
          //                 Text(
          //                   "Share URL copied to clipboard",
          //                   style: TextStyle(
          //                       color: Colors.white
          //                   ),
          //                 ),
          //               ],
          //             ), context: context)
          //         );
          //       });
          //
          //       Provider.of<AnalyticsService>(context, listen: false)
          //           .logShareCode(gradCount: grads.length, type: gradType);
          //     },
          //   icon: FontAwesomeIcons.solidPaperPlane,
          // ),
          // const SizedBox(
          //   width: 20,
          // ),
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
                ScaffoldMessenger.of(context).clearSnackBars();

                ScaffoldMessenger.of(context).showSnackBar(
                    DreamSnackBar(
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
                              "Code copied to clipboard",
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ), context: context
                    )
                );
              });
              Provider.of<AnalyticsService>(context, listen: false)
                  .logShareCode(gradCount: grads.length, type: gradType, copyCSS: true);
            },
            icon: FontAwesomeIcons.code,
          )
        ],
      ),
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
