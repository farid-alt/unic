import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/services/web_services.dart';

class AddFullnameViewModel extends ChangeNotifier {
  justNotify() =>
      notifyListeners(); //for apply button's color change like setState
  TextEditingController fullnameController = TextEditingController();

  addFullname() async {
    print(fullnameController.text);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await WebService.postCall(url: ADD_FULLNAME, data: {
      'full_name': fullnameController.text,
      'user_id': prefs.getString('userId'),
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
