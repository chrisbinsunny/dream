


import 'package:flutter/material.dart';

import 'upload/dropFile.dart';

class ColorDetails extends ChangeNotifier {
  DroppedFile? file= DroppedFile(url: "#", mime: "image/jpeg", bytes: 171941, name: "Splash.jpg");
  Color color =Colors.black, grad1= Colors.orange, grad2= Colors.indigo;
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

  Color get getGrad1{
    return grad1;
  }

  void setGrad1(Color grad11){
    grad1=grad11;
    notifyListeners();
  }

  Color get getGrad2{
    return grad2;
  }

  void setGrad2(Color grad21){
    grad2=grad21;
    notifyListeners();
  }
}