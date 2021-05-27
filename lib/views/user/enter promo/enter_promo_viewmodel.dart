import 'package:flutter/material.dart';

class EnterPromoViewModel extends ChangeNotifier {
  justNotify() =>
      notifyListeners(); //for apply button's color change like setState
  String enteredPromo;
}
