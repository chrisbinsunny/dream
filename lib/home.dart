import 'package:color_finder/colorFinder/colorFinderHome.dart';
import 'package:color_finder/footer.dart';
import 'package:color_finder/colorFinder/howToUse.dart';
import 'package:color_finder/colorFinder/imageView.dart';
import 'package:color_finder/gradientFinder/aa.dart';
import 'package:color_finder/gradientMaker/gradientMakerHome.dart';
import 'package:color_finder/sizes.dart';
import 'package:color_finder/upload/uploadImage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'appBar.dart';
import 'colorFinder/colorCodeViewer.dart';
import 'colorDetails.dart';
import 'upload/dropzoneWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
      body: GradientMakerHome(scrollController: scrollController,),
    );
  }
}
