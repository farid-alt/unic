import 'package:flutter/material.dart';
import 'package:unic_app/models/user/promotion.dart';
import 'package:unic_app/models/user/referral.dart';

class GetRidesViewModel extends ChangeNotifier {
  int discount = 2;
  Referal referal = Referal(discountAmount: 2, refCode: 'AFSANA123');
}
