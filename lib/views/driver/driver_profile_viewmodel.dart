import 'package:flutter/material.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/models/user/driver.dart';
import 'package:unic_app/models/user/user.dart';
import 'package:unic_app/services/web_services.dart';

class DriverProfileViewModel extends ChangeNotifier {
  String _language = 'English';

  Future driverProfileFuture;
  DriverProfileViewModel() {
    driverProfileFuture = getDriverProfile();
  }
  acceptyOrder() async {
    var data = await WebService.postCall(url: ACCEPT_ORDER, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    }, data: {
      'id': '1',
      'driver_id': _user.id.toString(),
      'order_id': '1'
    });
    print(data);
    // if (data[0] == 200) {
    //   _user = Driver.fromJson(data[1]['data']['driver']);
    // }
  }

  pickUpCustomer() async {
    var data = await WebService.postCall(url: PICK_UP, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    }, data: {
      'id': '1',
      'driver_id': _user.id.toString(),
      'order_id': '1'
    });
    print(data);
    // if (data[0] == 200) {
    //   _user = Driver.fromJson(data[1]['data']['driver']);
    // }
  }

  completeOrder() async {
    var data = await WebService.postCall(url: PICK_UP, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    }, data: {
      'id': '1',
      'driver_id': _user.id.toString(),
      'order_id': '1',
      'type': '0'
    });
    print(data);
    // if (data[0] == 200) {
    //   _user = Driver.fromJson(data[1]['data']['driver']);
    // }
  }

  cancelOrder() async {
    var data = await WebService.postCall(url: CANCEL_ORDER, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    }, data: {
      'id': '1',
      'driver_id': _user.id.toString(),
      'order_id': '1',
      'type': '0'
    });
    print(data);
    // if (data[0] == 200) {
    //   _user = Driver.fromJson(data[1]['data']['driver']);
    // }
  }

  getDriverProfile() async {
    var data = await WebService.getCall(url: GET_USER, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
    print(data);
    if (data[0] == 200) {
      _user = Driver.fromJson(data[1]['data']['driver']);
    }
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
