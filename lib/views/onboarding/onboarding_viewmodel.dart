import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  PageController _pageController = PageController(initialPage: 0);
  int _index = 0;

  PageController get pageController => _pageController;
  set pageController(value) {
    this._pageController = value;
    notifyListeners();
  }

  int get index => this._index;
  set index(value) {
    this._index = value;
    notifyListeners();
  }
}
