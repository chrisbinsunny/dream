import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../sizes.dart';
import 'dart:ui' as ui;

import 'gradientMakerDetails.dart';

class ColorPickerDialog extends StatelessWidget {
  ColorPickerDialog({Key? key,   required this.index}) : super(key: key);

  final TextEditingController controller=TextEditingController();
  int index;
  late Color color;



  @override
  Widget build(BuildContext context) {
    color= Provider.of<GradientMakerDetails>(context, listen: true).getGrads[index];
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius:
        BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
              sigmaX: 60.0, sigmaY: 60.0),
          child: Container(
            width: screenWidth(context,
                mulBy: 0.2),
            height: screenHeight(context,
                mulBy: 0.7),
            constraints: const BoxConstraints(
              minWidth: 280,
              minHeight: 500,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white
                    .withOpacity(0.1),
                borderRadius:
                BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white,
                )),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.start,
              crossAxisAlignment:
              CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius:
                  const BorderRadius
                      .vertical(
                      top:
                      Radius.circular(
                          10)),
                  child: BackdropFilter(
                    filter:
                    ui.ImageFilter.blur(
                        sigmaX: 30.0,
                        sigmaY: 30.0,
                        tileMode: TileMode
                            .decal),
                    child: Container(
                      width: screenWidth(
                          context,
                          mulBy: 0.25),
                      alignment: Alignment.centerLeft,
                      constraints:
                      const BoxConstraints(
                          minWidth: 280,
                          minHeight: 65),
                      height: screenHeight(
                          context,
                          mulBy: 0.06),
                      decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(
                              0.1),
                          border: const Border(
                              bottom: BorderSide(
                                  color: Colors
                                      .white,
                                  width:
                                  0.5))),
                      padding:
                      const EdgeInsets
                          .symmetric(
                          vertical: 10,
                          horizontal: 15),
                      child: Text(
                        "Choose your color..",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child:
                  SingleChildScrollView(
                    child: Padding(
                      padding:
                      const EdgeInsets
                          .symmetric(
                          horizontal: 7),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ColorPicker(
                            pickerColor: color,
                            onColorChanged:(c){
                              Provider.of<GradientMakerDetails>(context, listen: false).setGrads(c, index);
                            },
                            enableAlpha:
                            false,
                            hexInputController:
                            controller,
                            paletteType:
                            PaletteType
                                .hueWheel,
                            portraitOnly:
                            true,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceEvenly,
                            children: [
                              const Text(
                                "Hex: ",
                                style: TextStyle(
                                    color: Colors
                                        .white,
                                    fontSize:
                                    17,
                                    fontWeight:
                                    FontWeight
                                        .w500),
                              ),
                              SizedBox(
                                width: screenWidth(
                                    context,
                                    mulBy:
                                    0.08),
                                child:
                                TextField(
                                  controller:
                                  controller,
                                  style:
                                  const TextStyle(
                                    color: Colors
                                        .white,
                                  ),
                                  cursorColor:
                                  Colors
                                      .white,
                                  inputFormatters: [
                                    UpperCaseTextFormatter(),
                                    FilteringTextInputFormatter
                                        .allow(
                                        RegExp(kValidHexPattern))
                                  ],
                                  decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                      hintText: "Hex Value",
                                      prefix: Text(
                                        "#",
                                        style:
                                        TextStyle(
                                          color:
                                          Colors.white,
                                        ),
                                      )),
                                ),
                              ),
                              IconButton(
                                padding:
                                EdgeInsets
                                    .zero,
                                icon: const Icon(
                                    Icons
                                        .copy),
                                onPressed:
                                    () async {
                                  await Clipboard.setData(ClipboardData(
                                      text: controller
                                          .text))
                                      .then(
                                          (value) {
                                        ScaffoldMessenger.of(
                                            context)
                                            .showSnackBar(
                                            SnackBar(
                                              content:
                                              const Text(
                                                "Text Copied to clipboard",
                                                style:
                                                TextStyle(color: Colors.white),
                                              ),
                                              backgroundColor:
                                              Colors.blueAccent,
                                              width: screenWidth(
                                                  context,
                                                  mulBy:
                                                  0.2),
                                              behavior:
                                              SnackBarBehavior.floating,
                                            ));
                                      });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(const StadiumBorder(side: BorderSide.none)),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      vertical: 17,
                                      horizontal: 30
                                  )),
                              enableFeedback: true,
                              backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.2)),
                              overlayColor: MaterialStateProperty.all(Colors.deepPurpleAccent.withOpacity(0.3)),
                              elevation: MaterialStateProperty.all(0),
                              side: MaterialStateProperty.all(const BorderSide(color: Colors.white)),
                            ),
                            child: const Text(
                              "Done",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
