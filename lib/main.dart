import 'package:flutter/material.dart';
import 'package:unic_app/views/contact%20us/contact_us.dart';
import 'package:unic_app/views/no%20internet/no_internet_page.dart';
import 'package:unic_app/views/onboarding/onboarding_view.dart';
import 'package:unic_app/views/user/code_page/code_page_view.dart';
import 'package:unic_app/views/user/code_page/code_page_viewmodel.dart';
import 'package:unic_app/views/user/enter%20promo/enter_promo_view.dart';
import 'package:unic_app/views/user/get_rides/get_rides_view.dart';
import 'package:unic_app/views/user/privacy%20and%20policy/privacy.dart';
import 'package:unic_app/views/user/profile_page/profile%20edit/profile_edit_view.dart';
import 'package:unic_app/views/user/profile_page/profile_page_view.dart';
import 'package:unic_app/views/user/promotions_page/promotions_view.dart';
import 'package:unic_app/views/user/ride_history/ride_history_view.dart';
import 'package:unic_app/views/user/terms%20and%20conditions/terms_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Inter'),
      // home: OnboardingView(),
      home: ContactUs(),
      //home: UserProfileEditPageView(),
    );
  }
}
