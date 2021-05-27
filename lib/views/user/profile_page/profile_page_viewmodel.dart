import 'package:flutter/material.dart';
import 'package:unic_app/models/user/user.dart';

class UserProfilePageViewModel extends ChangeNotifier {
  String _language = 'English';
  bool _notifSwitchOn = true;
  User _user = User(
      name: 'Rustam',
      surname: 'Azizov',
      email: 'rustamazizov@gmail.com',
      phone: '+994552768495',
      profilePicAdress:
          'https://cdn1.vectorstock.com/i/thumb-large/46/00/male-default-placeholder-avatar-profile-gray-vector-31934600.jpg');

  get user => _user;
  set userName(String value) {
    _user.name = value;
    notifyListeners();
  }

  set userFullName(String val) {
    var newVal = val.split(' ');
    _user.name = newVal[0];
    _user.surname = newVal[1];
    notifyListeners();
  }

  get notifSwitchOn => _notifSwitchOn;
  set notifSwitchOn(bool val) {
    _notifSwitchOn = val;
    notifyListeners();
  }

  get language => _language;
  set language(String val) {
    _language = val;
    notifyListeners();
  }
}
