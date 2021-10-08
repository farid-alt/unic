import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unic_app/models/adress.dart';
import 'package:unic_app/models/user/user.dart';
import 'package:unic_app/services/web_services.dart';
import 'package:http/http.dart' as http;
import '../../../endpoints.dart';

class UserProfilePageViewModel extends ChangeNotifier {
  Future getUser;
  String _language = 'English';
  bool _notifSwitchOn = true;
  User _user;
  File localFile;
  UserProfilePageViewModel() {
    getUser = getUserApi();
  }
  User get user => _user;
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

  sendAdress({String place, Adress adress}) async {
    var data = await WebService.postCall(url: SEND_USER_DATA, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    }, data: {
      "${place}_address": adress.nameOfPlace.toString(),
      "${place}_address_latitude": adress.lat.toString(),
      "${place}_address_longitude": adress.lng.toString(),
      'id': _user.id.toString()
      // "full_name": _user.fullname,
      // "user_id": _user.id.toString()
    });
    print(data);

    if (data[0] == 200) {
      print(data);
    }
  }

  sendUserData() async {
    var data = await WebService.postCall(url: SEND_USER_DATA, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    }, data: {
      'id': _user.id.toString(),
      'phone': _user.phone,
      'email': _user.email
    });
    print(data);

    if (data[0] == 200) {
      print(data);
    }
    notifyListeners();
  }

  sendUserImage() {
    print("STARTED");
    print(localFile.path);
    var postUri = Uri.parse(SEND_USER_DATA);
    var request = new http.MultipartRequest("POST", postUri);
    request.fields.addAll({'id': ID});
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

  getUserApi() async {
    var data = await WebService.getCall(url: GET_USER, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
    print(data);

    if (data[0] == 200) {
      print(data);
      _user = User(
        name: data[1]['data']['customer']['user']['full_name'],
        surname: ' ',
        profilePicAdress: data[1]['data']['customer']['image'],
        id: data[1]['data']['customer']['id'],
        email: data[1]['data']['customer']['user']['email'],
        // homeAdress: data[1]['data']['home_address'],
        // workAdress: data[1]['data']['work_address'],
        phone: data[1]['data']['customer']['user']['phone'],
        homeAdress: data[1]['data']['customer']['home_address'] == null
            ? Adress()
            : Adress(
                nameOfPlace: data[1]['data']['customer']['home_address'],
                lat: double.parse(
                    data[1]['data']['customer']['home_address_latitude']),
                lng: double.parse(
                    data[1]['data']['customer']['home_address_longitude']),
              ),
        workAdress: data[1]['data']['customer']['work_adress'] == null
            ? Adress()
            : Adress(
                nameOfPlace: data[1]['data']['customer']['work_adress'],
                lat: double.parse(
                    data[1]['data']['customer']['work_adress_latitude']),
                lng: double.parse(
                    data[1]['data']['customer']['work_adress_longitude']),
              ),

        //TODO ADD last adress
      );
      notifyListeners();
      // _faqs = data[1]['data']
      //     .map<FaqWidgetModel>(
      //       (val) =>
      //           FaqWidgetModel(content: val['content'], title: val['title']),
      //     )
      //     .toList();
    }
  }
}
