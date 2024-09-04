import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:spiner_wheel/utils/images.dart';

class PinWheelLogic extends ChangeNotifier {
  late StreamController<int> controller;
  bool isSpinning = true;
  double scaleFactor = 1;
  String image = Images.playNow;

  init() {
    controller = StreamController<int>();
  }

  scroll(int index) {
    controller.add(Fortune.randomInt(0, index));
    isSpinning = false;
    scaleFactor = 1.2;
    image = Images.disiblePLayNow;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 200),() {
      scaleFactor = 1;
      image = Images.playNow;
      notifyListeners();
    },);
  }

  click(int index) {
    controller.add(Fortune.randomInt(0, index));
    isSpinning = false;
    scaleFactor = 1.2;
    image = Images.disiblePLayNow;

    notifyListeners();
    Future.delayed(const Duration(milliseconds: 200),() {
      scaleFactor = 1;
      image = Images.playNow;
      notifyListeners();
    },);
  }

  restoreSizeButton(){

    image = Images.playNow;
    isSpinning = true;
    notifyListeners();
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

}