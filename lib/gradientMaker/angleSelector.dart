import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../sizes.dart';
import 'gradientMakerDetails.dart';

class AngleSelector extends StatefulWidget {
  const AngleSelector({Key? key}) : super(key: key);

  @override
  State<AngleSelector> createState() => _AngleSelectorState();
}

class _AngleSelectorState extends State<AngleSelector> {
  double radius= 110;
  double angle = 0;

  @override
  Widget build(BuildContext context) {
    angle= Provider.of<GradientMakerDetails>(context, listen: true).getAngle;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),

      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
        child: Container(
          width: screenWidth(context, mulBy: 0.15),
          height: screenHeight(context, mulBy: 0.32),
          constraints: const BoxConstraints(
              // minWidth: 400,
              // minHeight: 220
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10)
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0, tileMode: TileMode.decal),
                  child: Container(
                    width: screenWidth(context, mulBy: 0.3),
                    height: screenHeight(context, mulBy: 0.06),

                    alignment: Alignment.centerLeft,
                    constraints: const BoxConstraints(
                        minWidth: 400,
                        minHeight: 50
                    ),
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
                        horizontal: 15
                    ),
                    child: const Text(
                      "Colors",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: GestureDetector(
                      onPanUpdate: onPanUpdate,
                      child: Container(
                        height: 220,
                        width: 220,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.5),
                            width: 3,
                            strokeAlign: StrokeAlign.outside
                          )
                        ),
                        alignment: const Alignment(1,0),
                        child: Container(
                          height: 2,
                          width: 110,
                          color: Colors.white,
                          transform: Matrix4.translationValues(0, 0, 0.0)
                            ..rotateZ(-angle * math.pi /180),
                        ),
                      ),
                    ),
                  ),
                ),
                ),

            ],
          ),
        ),
      ),
    );
  }


  void onPanUpdate(DragUpdateDetails details) {
    Offset coordinates = details.localPosition;

    var center = (radius * 2) / 2;
    Offset pureCoordinates = Offset(((coordinates.dx - center) / center),
        ((coordinates.dy - center) / center) * -1);
    var angleTan = (pureCoordinates.dy.abs()) / (pureCoordinates.dx.abs());

    double minValue =
    math.sqrt((math.pow(pureCoordinates.dx, 2) + math.pow(pureCoordinates.dy, 2)));

    if ((minValue > 0.6)) {
      angle = math.atan(angleTan) * 180 / math.pi;
      angle = angle.roundToDouble();
      if (pureCoordinates.dx.isNegative && !pureCoordinates.dy.isNegative) {
        angle = 90 - angle;
        angle += 90;
      }
      if (pureCoordinates.dx.isNegative && pureCoordinates.dy.isNegative) {
        angle += 180;
      }
      if (!pureCoordinates.dx.isNegative && pureCoordinates.dy.isNegative) {
        angle = 90 - angle;
        angle += 270;
      }
    }

    log((-(angle-360)).toString());
    Provider.of<GradientMakerDetails>(context, listen: false).setAngle(angle);
  }


}
