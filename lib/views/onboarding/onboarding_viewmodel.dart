import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  PageController _pageController = PageController(initialPage: 0);
  int _index = 0;
  String _title1 = 'Title of page';
  String _text1 =
      'Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum.';
  String _title2 = 'Title of page';
  String _text2 =
      'Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum.';

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

  get title1 => this._title1;
  get text1 => this._text1;
  get title2 => this._title1;
  get text2 => this._text1;
}
