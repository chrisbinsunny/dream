


import 'package:flutter/material.dart';


class GradientMakerDetails extends ChangeNotifier {

List<Color> grads= [
  Color(0xFFEE950F),
  Color(0xFF3F51B5)
];

List<Color> get getGrads{
    return grads;
  }

  void setGrad1(Color grad, int index){
    grads[index]=grad;
    notifyListeners();
  }

}