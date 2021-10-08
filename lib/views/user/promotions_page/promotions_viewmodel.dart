import 'package:flutter/material.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/models/user/promotion.dart';
import 'package:unic_app/services/web_services.dart';

class PromotionsViewModel extends ChangeNotifier {
  int countOfFreeRides = 0;
  List<Promotion> _promotions = [
    // Promotion(isUsed: true, promoCode: 'promo1', userId: 123),
    // Promotion(isUsed: false, promoCode: 'promo2', userId: 124),
    // Promotion(isUsed: true, promoCode: 'promo3', userId: 125),
  ];

  get promotions => _promotions;
  Future profileFuture;
  PromotionsViewModel() {
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
      countOfFreeRides = data[1]['data']['customer']['free_rides_count'];
      print("FREE ${data[1]['data']['customer']['free_rides_count']}");
    }
    notifyListeners();
  }
}
