import 'package:flutter/material.dart';
import 'package:unic_app/models/user/promotion.dart';

class PromotionsViewModel extends ChangeNotifier {
  List<Promotion> _promotions = [
    // Promotion(isUsed: true, promoCode: 'promo1', userId: 123),
    // Promotion(isUsed: false, promoCode: 'promo2', userId: 124),
    // Promotion(isUsed: true, promoCode: 'promo3', userId: 125),
  ];

  get promotions => _promotions;
}
