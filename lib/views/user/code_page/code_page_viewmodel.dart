import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/services/web_services.dart';
//import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class CodePageViewModel extends ChangeNotifier {
  String _number = ' '; //phone number
  PageController _pageController = PageController(initialPage: 0);
  int _index = 0; // index for page animation check ups
  String _codeInput = ''; //user's input code
  String _trueCode = '1234'; // Variable for user inputted code check up
  String _fullname = '';
  String userId;

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

  login() async {
    var data = await WebService.postCall(url: LOGIN, data: {
      'phone': _number,
    }, headers: {
      'Accept': 'application/json'
    });
    if (data[0] == 200) {
      _trueCode = data[1]['data']['customer']['verification_code'].toString();
    }
  }

  loginCodeConfirm() async {
    var data = await WebService.postCall(
        url: CODE_CONFIRM,
        data: {'phone': _number, 'verification_code': _trueCode},
        headers: {'Accept': 'application/json'});
    if (data[0] == 200) {
      //print(data[1]);
      TOKEN = data[1]['data']['access_token'];
      userId = data[1]['data']['userDetail']['user_id'].toString();
      ID = data[1]['data']['userDetail']['id'].toString();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('id', ID);
      prefs.setString('userId', userId);
      prefs.setString('token', data[1]['data']['access_token']);
      print('$ID');
      //print(TOKEN);
    }
    return data;
  }

  addFullname() async {
    print('$_fullname &&& $ID');
    var data = await WebService.postCall(url: ADD_FULLNAME, data: {
      'full_name': _fullname,
      'user_id': userId.toString()
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
    if (data[0] == 200) {
      //print(data[1]);
      print('success $data[1]');
    }
    return data[0];
  }
}
