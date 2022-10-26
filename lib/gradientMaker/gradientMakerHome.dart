import 'dart:ui';

import 'package:color_finder/gradientMaker/bgGradView.dart';
import 'package:color_finder/gradientMaker/gradientCode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../appBar.dart';
import '../colorFinder/howToUse.dart';
import '../footer.dart';
import '../sizes.dart';
import 'angleSelector.dart';
import 'colorsView.dart';
import 'gradientType.dart';
import 'gradientView.dart';

class GradientMakerHome extends StatefulWidget {
  const GradientMakerHome({Key? key,}) : super(key: key);

  @override
  State<GradientMakerHome> createState() => _GradientMakerHomeState();
}

class _GradientMakerHomeState extends State<GradientMakerHome> {
  final ScrollController scrollController= ScrollController();

  _scrollListener() {
    Provider.of<ScrollDetail>(context, listen: false).setPos(scrollController.position.pixels);
  }

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenWidth(context), 70),
        child: const AppBarCustom(),
      ),
      body: Scrollbar(
        controller: scrollController,
        thickness: 11,
        interactive: true,
        radius: const Radius.circular(0),
        trackVisibility: false,
        thumbVisibility: true,
        child: Stack(
          children: [
            BgGradient(),
            ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView(
                shrinkWrap: false,
                cacheExtent: 10000,
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: screenHeight(context, mulBy: 0.25),
                    child: const Text(
                      "Gradient Maker",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceEvenly,
                    runSpacing: 20,
                    spacing: 20,
                    children:  [
                      const GradientViewer(),
                      Column(
                        children: [
                          const ColorsView(),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: screenWidth(context, mulBy: 0.3),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                minWidth: 530,
                              ),
                              child: Wrap(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.spaceEvenly,
                                runSpacing: 20,
                                spacing: 20,
                                children: [
                                  const AngleSelector(),
                                  GradientType()
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GradientCode(),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  const Footer()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
