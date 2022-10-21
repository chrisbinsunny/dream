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
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 50
          ),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              border: const Border(
                top: BorderSide(
                  color: Colors.white,
                  width: 0.25
                )
              )
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: 350,
                        child:
                        Text(
                          "“Dream is not that which you see while sleeping it is something that does not let you sleep.”",
                          style: TextStyle(
                            color: Colors.blueGrey[100],
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: (){
                          html.window.open('https://github.com/chrisbinsunny/color-finder', 'new tab');
                        },
                        style: const ButtonStyle(
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
                        style: const ButtonStyle(
                            alignment: Alignment.centerLeft
                        ),

                        child:  const Text(
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
                        style: const ButtonStyle(
                            alignment: Alignment.centerLeft
                        ),

                        child:  const Text(
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
                        style: const ButtonStyle(
                            alignment: Alignment.centerLeft
                        ),

                        child:  const Text(
                          "Twitter",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              decoration: TextDecoration.underline
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10,),
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
