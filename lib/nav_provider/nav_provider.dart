import 'package:flutter/material.dart';

class NavProvider extends ChangeNotifier {
  int currentIndex = 0;

  List<Widget> screens = [
    Text('Home'),
    Text('Activity'),
    Text('Account'),
  ];

  updateCurrentIndex(int value) {
    currentIndex = value;
    notifyListeners();
  }

  bool checkCurrentState(int value) {
    return currentIndex == value;
  }
}
