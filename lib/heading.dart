import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dream/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header({Key? key, required this.head}) : super(key: key);

  final String head;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: screenHeight(context, mulBy: 0.25),
      margin: EdgeInsets.symmetric(
          horizontal: 20
      ),
      child: FittedBox(
        child: AnimatedTextKit(
          repeatForever: true,
          pause: Duration(seconds: 2),
          animatedTexts: [
            TypewriterAnimatedText(
                head,
                textStyle: GoogleFonts.oranienbaum(
                    fontSize: 50.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2
                ),
                speed: const Duration(milliseconds: 100)
            ),
          ],
          displayFullTextOnTap: true,
        ),
      ),
    );
  }
}
