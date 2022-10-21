import 'package:color_finder/footer.dart';
import 'package:color_finder/howToUse.dart';
import 'package:color_finder/imageView.dart';
import 'package:color_finder/sizes.dart';
import 'package:color_finder/upload/uploadImage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appBar.dart';
import 'colorCodeViewer.dart';
import 'colorDetails.dart';
import 'upload/dropzoneWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final ScrollController _scrollController= ScrollController();

  _scrollListener() {
    Provider.of<ScrollDetail>(context, listen: false).setPos(_scrollController.position.pixels);
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
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
        controller: _scrollController,
        thickness: 11,
        interactive: true,
        radius: const Radius.circular(0),
        trackVisibility: false,
        thumbVisibility: true,
        child: Stack(
          children: [
           const DropHere( ),

            ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView(
                shrinkWrap: false,
                cacheExtent: 10000,
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: screenHeight(context, mulBy: 0.25),
                    //color: Colors.black,
                    child: const Text(
                      "Color Finder | Palette Finder",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Wrap(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceEvenly,
                    runSpacing: 20,
                    spacing: 20,
                    children:  [
                      const ImageViewer(),
                      Column(
                        children: const [
                          ColorCodeViewer(),
                          SizedBox(
                            height: 20,
                          ),
                          UploadImage(),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const Align(
                    alignment: Alignment.center,
                      child: HowToUse(),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  const Footer()
                ],
              ),
            ),

            Visibility(
              visible: Provider.of<ColorDetails>(context, listen: true).getHover,
              child: Container(
                color: Colors.black.withOpacity(0.9),
                height: screenHeight(context),
                width: screenWidth(context),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.cloud_upload,
                      size: 140,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text.rich(
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
                        fontSize: 17
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
