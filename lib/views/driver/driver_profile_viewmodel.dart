import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/models/user/driver.dart';
import 'package:unic_app/models/user/user.dart';
import 'package:unic_app/services/web_services.dart';
import 'package:http/http.dart' as http;

class DriverProfileViewModel extends ChangeNotifier {
  String _language = 'English';

  Future driverProfileFuture;
  DriverProfileViewModel() {
    driverProfileFuture = getDriverProfile();
  }
  File localFile;

  getDriverProfile() async {
    var data = await WebService.getCall(url: GET_USER, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
    print(data);
    if (data[0] == 200) {
      _user = Driver.fromJson(data[1]['data']['driver']);
    }
    return data[0];
    notifyListeners();
  }

  sendDriverImage() {
    print("STARTED");
    print(localFile.path);
    var postUri = Uri.parse(SEND_DRIVER_DATA);
    var request = new http.MultipartRequest("POST", postUri);
    request.fields.addAll({'id': DRIVERID});
    request.files.add(http.MultipartFile(
      'image',
      localFile.readAsBytes().asStream(),
      localFile.lengthSync(),
      filename: localFile.path.split("/").last,
    ));
    request.headers.addAll({
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $TOKEN"
    });

    request.send().then((response) {
      print(response.statusCode);
      response.stream.bytesToString().then((value) {
        print(value);
      });
      if (response.statusCode == 200) {
        print("Uploaded!");
        return response.statusCode;
      }
    });
    notifyListeners();
    print("ENDEDß");
  }

  sendUserData() async {
    var data = await WebService.postCall(url: SEND_DRIVER_DATA, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    }, data: {
      'id': DRIVERID.toString(),
      // 'phone': _user.number,
      'email': _user.email,
      'full_name': _user.fullname
    });
    print("SEND DRIVER DATA ${data}");

    if (data[0] == 200) {
      print(data);
    }
    notifyListeners();
    return data;
  }

  addFullname() async {
    // print('$_fullname &&& $ID');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await WebService.postCall(url: ADD_FULLNAME, data: {
      'full_name': _user.fullname,
      'user_id': prefs.getString('userId'),
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
    if (data[0] == 200) {
      //print(data[1]);
      print('success $data[1]');
    }
    notifyListeners();
    return data[0];
  }

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
