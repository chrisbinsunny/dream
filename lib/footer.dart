import 'dart:developer';
import 'dart:ui';

import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: screenWidth(context,),
              height: (constraints.biggest.width<850)?((constraints.biggest.width<580)?((constraints.biggest.width<400)? 480:420) :330):225,
              constraints: const BoxConstraints(
                  minWidth: 400,
                  minHeight: 220
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 30
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
              child: ListView(
                shrinkWrap: false,
                physics: const ClampingScrollPhysics(),
                children: [
                  Center(
                    child: Text(
                      'DREAM by Chrisbin',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Colors.blueGrey[300],
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Center(
                    child: Text(
                      "Curated with 💙",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                          fontSize: 15
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceEvenly,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.spaceEvenly,
                    runSpacing: 30,
                    spacing: 20,
                    children: [
                      SizedBox(
                        width: 250,
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "“Dream is not that which you see while sleeping it is something that does not let you sleep.”",
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Text(
                              "- APJ Abdul Kalam",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          TextButton(
                            onPressed: (){
                              html.window.open('https://github.com/chrisbinsunny/color-finder', 'new tab');
                            },
                            style: const ButtonStyle(
                                alignment: Alignment.center,
                              textStyle: MaterialStatePropertyAll(TextStyle())
                            ),

                            child:  RichText(
                                text: const TextSpan(
                                    text: "Yay! This project is ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white
                                    ),
                                    children: [
                                      TextSpan(
                                          text:"Open Source",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              decoration: TextDecoration.underline
                                          )
                                      ),
                                      TextSpan(
                                          text:" ✨",
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

                            child:  RichText(
                                text: const TextSpan(
                                    text: "Report an issue or bug ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white
                                    ),
                                    children: [
                                      TextSpan(
                                          text:"here",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              decoration: TextDecoration.underline
                                          )
                                      ),
                                    ]
                                )),
                          ),
                        ],
                      ),
                      Container(
                        width: 250,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            Text(
                              "Let's Chat !",
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w400,
                                color: Colors.white
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    icon: const FaIcon(FontAwesomeIcons.twitter,),
                                    onPressed: () {
                                      html.window.open('https://twitter.com/chrisbinsunny', 'new tab');
                                    }
                                ),
                                IconButton(
                                    icon: const FaIcon(FontAwesomeIcons.github,),
                                    onPressed: () {
                                      html.window.open('https://github.com/chrisbinsunny', 'new tab');
                                    }
                                ),
                                IconButton(
                                    icon: const FaIcon(FontAwesomeIcons.instagram,),
                                    onPressed: () {
                                      html.window.open('https://www.instagram.com/binary.ghost/', 'new tab');
                                    }
                                ),
                                IconButton(
                                    icon: const FaIcon(FontAwesomeIcons.linkedin,),
                                    onPressed: () {
                                      html.window.open('https://www.linkedin.com/in/chrisbin-sunny-279776171/', 'new tab');
                                    }
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
