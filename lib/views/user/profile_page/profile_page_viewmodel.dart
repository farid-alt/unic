import 'package:flutter/material.dart';
import 'package:unic_app/models/user/user.dart';
import 'package:unic_app/services/web_services.dart';

import '../../../endpoints.dart';

class UserProfilePageViewModel extends ChangeNotifier {
  Future getUser;
  String _language = 'English';
  bool _notifSwitchOn = true;
  User _user;
  UserProfilePageViewModel() {
    getUser = getUserApi();
  }
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

  getUserApi() async {
    var data = await WebService.getCall(url: GET_USER, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
    print(data);

    if (data[0] == 200) {
      print(data);
      _user = User(
          name: data[1]['data']['user']['full_name'],
          surname: ' ',
          profilePicAdress: data[1]['data']['image'],
          id: data[1]['data']['id'],
          email: data[1]['data']['user']['email'],
          homeAdress: data[1]['data']['home_address'],
          workAdress: data[1]['data']['work_address'],
          phone: data[1]['data']['user']['phone']);
      // _faqs = data[1]['data']
      //     .map<FaqWidgetModel>(
      //       (val) =>
      //           FaqWidgetModel(content: val['content'], title: val['title']),
      //     )
      //     .toList();
    }
  }
}
