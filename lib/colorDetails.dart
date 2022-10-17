


import 'package:flutter/material.dart';

import 'dropFile/dropFile.dart';

class ColorDetails extends ChangeNotifier {
  DroppedFile? file;
  Offset coordinates=const Offset(0, 0);

  DroppedFile? get getFile {
    return file;
  }

  void setFile(DroppedFile? file1) {
    file = file1;
    notifyListeners();
  }

  Offset get getCoordinates{
    return coordinates;
  }

  void setCoordinates(Offset coordinates1){
    coordinates= coordinates1;
    notifyListeners();
  }
}