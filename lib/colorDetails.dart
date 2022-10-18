


import 'package:flutter/material.dart';

import 'dropFile/dropFile.dart';

class ColorDetails extends ChangeNotifier {
  DroppedFile? file;
  Color color =Colors.black;
  Color colorTemp =Color(0xff8540ec);
  bool hover= false;

  DroppedFile? get getFile {
    return file;
  }

  void setFile(DroppedFile? file1) {
    file = file1;
    notifyListeners();
  }


  Color get getColor{
    return color;
  }

  void setColor(Color color1){
    color= color1;
    notifyListeners();
  }

  Color get getColorTemp{
    return colorTemp;
  }

  void setColorTemp(Color colorTemp1){
    colorTemp= colorTemp1;
    notifyListeners();
  }

  bool get getHover{
    return hover;
  }

  void setHover(bool hover1){
    hover=hover1;
    notifyListeners();
  }
}