import 'package:flutter/material.dart';
import 'package:unic_app/models/user/driver.dart';
import 'package:unic_app/models/user/user.dart';

class DriverProfileViewModel extends ChangeNotifier {
  String _language = 'English';
  get language => _language;
  set language(String val) {
    _language = val;
    notifyListeners();
  }

  Driver get user => _user;
  Driver _user = Driver(
      rating: 4,
      name: 'Rustam',
      surname: 'Azizov',
      // email: 'rustamazizov@gmail.com',
      number: '+994552768495',
      profilePicAdress:
          'https://cdn1.vectorstock.com/i/thumb-large/46/00/male-default-placeholder-avatar-profile-gray-vector-31934600.jpg');
}
