import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:unic_app/views/driver/driver_profile_view.dart';
import 'package:unic_app/views/driver/driver_profile_viewmodel.dart';
import 'package:unic_app/views/driver_map/driver_map_view.dart';
import 'package:unic_app/views/driver_map/driver_map_viewmodel.dart';
import 'package:unic_app/views/user/main_wrapper/main_wrapper_view.dart';
import 'package:unic_app/views/user/map_page/map_page_view.dart';
import 'package:unic_app/views/user/ride_history/ride_history_view.dart';

import 'package:unic_app/views/user/support/support_view.dart';

void main() {
  initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
      ),
      // home: OnboardingView(),
      home: MapPageView(),
      //home: UserProfileEditPageView(),
    );
  }
}
