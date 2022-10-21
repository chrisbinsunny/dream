import 'dart:ui';

import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
        child: Container(
          width: screenWidth(context,),
          height: screenHeight(context, mulBy: 0.2),
          constraints: const BoxConstraints(
              minWidth: 400,
              minHeight: 220
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20
          ),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              border: Border(
                top: BorderSide(
                  color: Colors.white,
                  width: 0.5
                )
              )
          ),
          child: Column(
            children: [
              Text(
                'DREAM by Chrisbin',
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 5,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                "Made using Flutter with 💙",
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontFamily: 'Montserrat',
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
