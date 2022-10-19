import 'dart:ui';

import 'package:flutter/material.dart';

import '../sizes.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),

      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
        child: Container(
          width: screenWidth(context, mulBy: 0.25),
          height: screenHeight(context, mulBy: 0.26),
          constraints: const BoxConstraints(
              minWidth: 400,
              minHeight: 220
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
              )
          ),
          padding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20
          ),
          child: Column(
            children: [
              const Text(
                "Choose your Image",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  fontWeight: FontWeight.w600
                ),
              ),
              const Text(
                "Drag & drop image or",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w400
                ),
              ),
              ElevatedButton(
                  onPressed: (){},

                style: ButtonStyle(
                  shape: MaterialStateProperty.all(const StadiumBorder(side: BorderSide.none)),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 40
                  )),
                  enableFeedback: true,
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  overlayColor: MaterialStateProperty.all(Colors.deepPurpleAccent.withOpacity(0.3)),
                  shadowColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                  elevation: MaterialStateProperty.all(20),
                  side: MaterialStateProperty.all(BorderSide(color: Colors.white)),
                ),
                  child: const Text(
                      "Upload Image",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                    ),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
