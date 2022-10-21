import 'dart:ui';

import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

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
                  width: 0.25
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
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: (){
                        html.window.open('https://github.com/chrisbinsunny/color-finder', 'new tab');
                      },
                      style: ButtonStyle(
                          alignment: Alignment.centerLeft
                      ),

                      child:  RichText(
                          text: const TextSpan(
                              text: "⭐ Find the code ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white
                              ),
                              children: [
                                TextSpan(
                                    text:"here",
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        decoration: TextDecoration.underline
                                    )
                                ),
                              ]
                          )),
                    ),
                    TextButton(
                      onPressed: (){
                        html.window.open('https://github.com/chrisbinsunny/color-finder', 'new tab');
                      },
                      style: ButtonStyle(
                          alignment: Alignment.centerLeft
                      ),

                      child:  Text(
                        "Twitter",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        html.window.open('https://github.com/chrisbinsunny/color-finder', 'new tab');
                      },
                      style: ButtonStyle(
                          alignment: Alignment.centerLeft
                      ),

                      child:  Text(
                        "Twitter",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        html.window.open('https://github.com/chrisbinsunny/color-finder', 'new tab');
                      },
                      style: ButtonStyle(
                          alignment: Alignment.centerLeft
                      ),

                      child:  Text(
                        "Twitter",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
