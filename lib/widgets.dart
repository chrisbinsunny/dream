

import 'dart:ui';

import 'package:color_finder/sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'gradientMaker/gradientMakerDetails.dart';

class GradientTypeButton extends StatelessWidget {
  const GradientTypeButton({
    Key? key,
    required this.hovered,
    required this.selected,
    required this.itemNo,
    required this.name
  }) : super(key: key);

  final ValueNotifier<int> hovered;
  final int selected;
  final int itemNo;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Provider.of<GradientMakerDetails>(context, listen: false).setGradType(itemNo);
      },
      onHover: (hover1){
        if(hover1){
          hovered.value=itemNo;
        }else{
          hovered.value=-1;
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
          child: Container(
            width: screenWidth(context, mulBy: 0.115
            ),
            height: screenHeight(context, mulBy: 0.06
            ),
            constraints: const BoxConstraints(
                minWidth: 210,
                minHeight: 50
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: hovered.value==itemNo?Colors.white.withOpacity(0.1):Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: Colors.white.withOpacity(
                      selected==itemNo?1:
                      0.3
                  ),
                  width: 2.5
              ),
            ),
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DreamButton extends StatelessWidget {
  DreamButton({
    Key? key,
    required this.name,
    required this.onTap,
    this.icon
  }) : super(key: key);

  final hovered= ValueNotifier<bool>(false);
  final String name;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: hovered,
      builder: (context, hover, child) {
        return InkWell(
          onTap: onTap,
          onHover: (hover1){
            if(hover1){
              hovered.value=true;
            }else{
              hovered.value=false;
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
              child: Container(
                // width: screenWidth(context, mulBy: 0.115
                // ),
                // height: screenHeight(context, mulBy: 0.06
                // ),
                // constraints: const BoxConstraints(
                //     minWidth: 210,
                //     minHeight: 50
                // ),
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: hover?Colors.white.withOpacity(0.1):Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: Colors.white.withOpacity(
                          0.8
                      ),
                      width: 2.5
                  ),
                ),
                child: icon==null?Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    overflow: TextOverflow.clip,
                  ),
                ):Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                        icon,
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


SnackBar DreamSnackBar({required Widget content, required BuildContext context}){
  return SnackBar(
    content: content,
    backgroundColor: Colors.blueAccent,
    width: screenWidth(context, mulBy: 0.2),
    behavior: SnackBarBehavior.floating,


  );
}


class AdaptableText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final double minimumFontScale;
  final TextOverflow textOverflow;
  const AdaptableText(this.text,
      {this.style,
        this.textAlign = TextAlign.left,
        this.textDirection = TextDirection.ltr,
        this.minimumFontScale = 0.5,
        this.textOverflow = TextOverflow.ellipsis,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextPainter _painter = TextPainter(
        text: TextSpan(text: this.text, style: this.style),
        textAlign: this.textAlign,
        textScaleFactor: 1,
        maxLines: 100,
        textDirection: this.textDirection);

    return LayoutBuilder(
      builder: (context, constraints) {
        _painter.layout(maxWidth: constraints.maxWidth);
        double textScaleFactor = 1;

        if (_painter.height > constraints.maxHeight) { //
          print('${_painter.size}');
          _painter.textScaleFactor  = minimumFontScale;
          _painter.layout(maxWidth: constraints.maxWidth);
          print('${_painter.size}');

          if (_painter.height > constraints.maxHeight) { //
            //even minimum does not fit render it with minimum size
            print("Using minimum set font");
            textScaleFactor = minimumFontScale;
          } else if (minimumFontScale < 1) {
            //binary search for valid Scale factor
            int h = 100;
            int l =   (minimumFontScale * 100).toInt();
            while (h > l) {
              int mid = (l + (h - l) / 2).toInt();
              double newScale = mid.toDouble()/100.0;
              _painter.textScaleFactor  = newScale;
              _painter.layout(maxWidth: constraints.maxWidth);

              if (_painter.height > constraints.maxHeight) { //
                h = mid - 1;
              } else {
                l = mid + 1;
              }
              if  (h <= l) {
                print('${_painter.size}');
                textScaleFactor = newScale - 0.01;
                _painter.textScaleFactor  = newScale;
                _painter.layout(maxWidth: constraints.maxWidth);
                break;
              }


            }
          }
        }

        return Text(
          this.text,
          style: this.style,
          textAlign: this.textAlign,
          textDirection: this.textDirection,
          textScaleFactor: textScaleFactor,
          maxLines: 100,
          overflow: textOverflow,
        );
      },
    );
  }
}