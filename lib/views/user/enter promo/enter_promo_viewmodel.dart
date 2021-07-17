import 'package:flutter/material.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/services/web_services.dart';

class EnterPromoViewModel extends ChangeNotifier {
  justNotify() =>
      notifyListeners(); //for apply button's color change like setState
  String enteredPromo = '';
  sendPromo() async {
    var data = await WebService.postCall(url: SEND_PROMO, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    }, data: {
      'id': '1',
      'promo_code': enteredPromo,
    });
    print(data);
    // if (data[0] == 200) {
    //   _user = Driver.fromJson(data[1]['data']['driver']);
    // }
  }
}
