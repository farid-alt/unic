import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FaqViewModel extends ChangeNotifier {
  String whatIsText =
      'Unik is a taxi service app with the goal of finding the experienced drivers to the customers. Our goal is to find you the vehicle you need and take you to the destination point at a faster rate than any other services safely. ';
  void justNotify() => notifyListeners();
}
