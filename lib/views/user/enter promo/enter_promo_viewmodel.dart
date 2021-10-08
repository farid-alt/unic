import 'package:flutter/material.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/services/web_services.dart';

class EnterPromoViewModel extends ChangeNotifier {
  justNotify() =>
      notifyListeners(); //for apply button's color change like setState
  String _enteredPromo = '';
  set enteredPromo(val) {
    _enteredPromo = val;
    notifyListeners();
  }

  String get enteredPromo => this._enteredPromo;

  sendPromo() async {
    print(_enteredPromo);
    var data = await WebService.postCall(url: SEND_PROMO, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    }, data: {
      'id': ID,
      'promo_code': _enteredPromo,
    });
    print(data);
    return data[0];
    // if (data[0] == 200) {
    //   _user = Driver.fromJson(data[1]['data']['driver']);
    // }
  }
}
