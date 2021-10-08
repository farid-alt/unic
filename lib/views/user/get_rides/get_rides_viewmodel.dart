import 'package:flutter/material.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/models/user/promotion.dart';
import 'package:unic_app/models/user/referral.dart';
import 'package:unic_app/services/web_services.dart';

class GetRidesViewModel extends ChangeNotifier {
  int discount = 2;
  Referal referal = Referal(discountAmount: 0, refCode: '');
  Future profileFuture;
  GetRidesViewModel() {
    profileFuture = getProfile();
  }

  getProfile() async {
    var data = await WebService.getCall(url: GET_USER, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $TOKEN'
    });
    print(data);

    if (data[0] == 200) {
      print(data);
      referal.refCode = data[1]['data']['customer']['promo_code'] ?? '';
      referal.discountAmount =
          data[1]['data']['customer']['free_rides_count'] ?? 0;
      print("FREE ${data[1]['data']['customer']['promo_code']}");
      notifyListeners();
    }
  }
}
