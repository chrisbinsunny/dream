


import 'package:flutter/material.dart';


class GradientMakerDetails extends ChangeNotifier {

List<Color> grads= [
  Color(0xFFEE950F),
  Color(0xFF3F51B5)
];

double angle=315;

///0= Linear Gradient
///1= Radial Gradient
///2= Sweep Gradient
int gradientType=0;

List<Color> get getGrads{
    return grads;
  }

  void setGrad(Color grad, int index){
    grads[index]=grad;
    notifyListeners();
  }

void setGrads(List<String> gradsStr,){
  List<Color>grads1=[];
  for (var element in gradsStr) {
    grads.add(Color(int.parse(element.substring(1, 7), radix: 16) + 0xFF000000));
  }
  grads=grads1;
  notifyListeners();
}

void addGrad(){
  grads.add(Colors.white);
  notifyListeners();
}

void removeGrad(int index){
  grads.removeAt(index);
  notifyListeners();
}


double get getAngle{
  return angle;
}

void setAngle(double angle1){
  angle=angle1;
  notifyListeners();
}

int get getGradType{
  return gradientType;
}

void setGradType(int gradientType1){
  gradientType=gradientType1;
  notifyListeners();
}

}