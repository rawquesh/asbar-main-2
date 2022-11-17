import 'package:flutter/foundation.dart';

class MainProvider extends ChangeNotifier {
  bool showSpinner = false;
  changeShowSpinner(bool b) {
    showSpinner = b;
    notifyListeners();
  }

  ///Tabs Scaffold
  int bottomTabIndex = 0;
  changeBottomTabIndex(int i) {
    bottomTabIndex = i;
    notifyListeners();
  }

  ///Home Tab
  int styleOptionsIndex = 1;
  changeStyleOptionsIndex(int i) {
    styleOptionsIndex = i;
    notifyListeners();
  }

  int operationTypeIndex = 1;
  changeOperationTypeIndex(int i) {
    operationTypeIndex = i;
    notifyListeners();
  }

  double sliderValue = 1;
  changeSliderValue(double i) {
    sliderValue = i;
    notifyListeners();
  }

  int facePartIndex = 0;
  changeFacePartIndex(int i) {
    facePartIndex = i;
    notifyListeners();
  }

  int operationTypeBodyPartIndex = 0;
  changeOperationTypeBodyPartIndex(int i) {
    operationTypeBodyPartIndex = i;
    notifyListeners();
  }
}
