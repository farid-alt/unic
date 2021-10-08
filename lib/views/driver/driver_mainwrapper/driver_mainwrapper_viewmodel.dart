import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/models/user/user.dart';
import 'package:unic_app/services/web_services.dart';
import 'package:unic_app/views/user/map_page/map_page_view.dart';
import 'package:unic_app/views/user/profile_page/profile_page_view.dart';

class DriverMainWrapperViewModel extends ChangeNotifier {
  User _user;
  Future getUser;
  DriverMainWrapperViewModel() {
    getUser = getUserApi();
  }
  User get user => _user;
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
        profilePicAdress: data[1]['data']['driver']['image'],
        // surname: ' ',
        // profilePicAdress: data[1]['data']['image'],
        // id: data[1]['data']['id'],
        // email: data[1]['data']['user']['email'],
        // homeAdress: data[1]['data']['home_address'],
        // workAdress: data[1]['data']['work_address'],
        // phone: data[1]['data']['user']['phone']
      );
      // _faqs = data[1]['data']
      //     .map<FaqWidgetModel>(
      //       (val) =>
      //           FaqWidgetModel(content: val['content'], title: val['title']),
      //     )
      //     .toList();
    }
    notifyListeners();
  }
}
