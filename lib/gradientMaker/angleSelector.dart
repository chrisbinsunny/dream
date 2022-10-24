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
  double radius= 70;
  double angle = 0;

  @override
  Widget build(BuildContext context) {
    angle= Provider.of<GradientMakerDetails>(context, listen: true).getAngle;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),

      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
        child: Container(
          width: screenWidth(context, mulBy: 0.135
          ),
          height: screenHeight(context, mulBy: 0.28
          ),
          constraints: const BoxConstraints(
             minWidth: 240,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10)
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0, tileMode: TileMode.decal),
                  child: Container(
                    width: screenWidth(context, mulBy: 0.135),
                    height: screenHeight(context, mulBy: 0.06),
                    alignment: Alignment.centerLeft,
                    constraints: const BoxConstraints(
                        minWidth: 240,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Angle",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Text(
                          "${-(angle-360)}°",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
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
                        height: radius*2,
                        width: radius*2,
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
                        child: Transform(
                          ///Whole container is rotated here to the correct visual angle.
                          ///Angle can be accessed by [(-(angle-360)]

                          transform: Matrix4.translationValues(0, 0, 0.0)
                            ..rotateZ(-angle * math.pi /180),
                          alignment: FractionalOffset.centerLeft,
                          origin: Offset(15,0),
                          child: Stack(
                            alignment: FractionalOffset.centerLeft,
                            children: [
                              ///Conatiner for dial
                              Container(
                                height: 3,
                                width: radius+15,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                              ),

                              ///Conatiner for round centre
                              ///Margin is passed insted of offset to move the round to centre of rotation
                              Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2
                                  )
                                ),
                                margin: EdgeInsets.all(10),
                              ),
                            ],
                          ),
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

    var center = radius;
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

    Provider.of<GradientMakerDetails>(context, listen: false).setAngle(angle);
  }


}
