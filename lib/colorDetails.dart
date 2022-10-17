


import 'package:flutter/material.dart';

class ColorDetails extends ChangeNotifier {
  int slideNo = 1;

  int get getSlideNo {
    return slideNo;
  }

  void setSlideNo(int val) {
    slideNo = val;
    notifyListeners();
  }

  void incSlideNo() {
    if (slideNo != 30) {
      slideNo++;
    }
    notifyListeners();
  }

  void decSlideNo() {
    if (slideNo != 1) {
      slideNo--;
    }
    notifyListeners();
  }
}