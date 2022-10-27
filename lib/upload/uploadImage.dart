import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:provider/provider.dart';

import '../colorDetails.dart';
import '../sizes.dart';
import 'dropFile.dart';

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
              minHeight: 250
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
              )
          ),

          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10)
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0, tileMode: TileMode.decal),
                  child: Container(
                    width: screenWidth(context, mulBy: 0.25),
                    constraints: const BoxConstraints(
                        minWidth: 400,
                        minHeight: 55
                    ),
                    height: screenHeight(context, mulBy: 0.06),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        border: const Border(
                            bottom: BorderSide(
                                color: Colors.white,
                                width: 0.5
                            )
                        )
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.upload_file,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Choose your Image",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Drag & drop image or",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w400
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final events= await controller.pickFiles(
                      multiple: false,
                      mime: [
                        "image/apng",
                        "image/avif",
                        "image/jpeg",
                        "image/png",
                        "image/webp",
                      ]
                    );

                    if(events.isEmpty) return;
                    acceptFile(events.first);
                  },

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
                  side: MaterialStateProperty.all(const BorderSide(color: Colors.white)),
                ),
                  child: const Text(
                      "Upload Image",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                    ),
                  ),
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15
                ),
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      text: "We strongly support data privacy. ",
                      children: [
                        TextSpan(
                            text: "No data is being sent to our servers. ",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline
                            )
                        ),
                        TextSpan(
                          text: "Your browser handles everything.",
                        )
                      ]
                  ),
                  style: TextStyle(
                      fontSize: 14,
                    color: Colors.white60
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future acceptFile(dynamic event) async {

    final name = event.name;
    final mime = await controller.getFileMIME(event);
    final bytes = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);

    final droppedFile = DroppedFile(
      url: url,
      name: name,
      mime: mime,
      bytes: bytes,
    );
    Provider.of<ColorDetails>(context, listen: false).setFile(droppedFile);
  }
}
