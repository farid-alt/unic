import 'package:flutter/material.dart';
//import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class CodePageViewModel extends ChangeNotifier {
  String _number = ' '; //phone number
  PageController _pageController = PageController(initialPage: 0);
  int _index = 0; // index for page animation check ups
  String _codeInput = ''; //user's input code
  String _trueCode = '1234'; // Variable for user inputted code check up
  String _fullname = '';

  get fullname => _fullname;
  set fullname(String val) {
    _fullname = val;
    notifyListeners();
  }

  get codeInput => _codeInput;

  set codeInput(val) {
    _codeInput = val;
    notifyListeners();
  }

  get trueCode => _trueCode;

  PageController get pageController => _pageController;

  set index(int i) {
    _index += i;
    notifyListeners();
  }

  get index => _index;

  get number => _number;

  set number(String text) {
    _number = text;
    notifyListeners();
  }
}
