import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/providers/language_provider.dart';
import 'package:unic_app/views/driver/driver_mainwrapper/driver_mainwrapper.dart';

import 'package:unic_app/views/driver/driver_profile_view.dart';
import 'package:unic_app/views/driver/driver_profile_viewmodel.dart';
import 'package:unic_app/views/driver_map/driver_map_view.dart';
import 'package:unic_app/views/driver_map/driver_map_viewmodel.dart';
import 'package:unic_app/views/onboarding/onboarding_view.dart';
import 'package:unic_app/views/user/get_rides/get_rides_view.dart';
import 'package:unic_app/views/user/main_wrapper/main_wrapper_view.dart';
import 'package:unic_app/views/user/map_page/map_page_view.dart';
import 'package:unic_app/views/user/payments/payments_view.dart';
import 'package:unic_app/views/user/profile_page/profile_page_view.dart';
import 'package:unic_app/views/user/ride_history/ride_history_view.dart';
import 'package:provider/provider.dart';
import 'package:unic_app/views/user/support/support_view.dart';

import 'views/user/code_page/code_page_view.dart';
//TODO CHAnge user id everywhere

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
        //  home: CodePageView(),
        home: ChangeNotifierProvider(
            create: (context) => LanguageProvider(), child: CheckClass())
        //home: UserProfileEditPageView(),
        );
  }
}

class CheckClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MainWrapperView();
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.data.containsKey('id')) {
            ID = snapshot.data.getString('id');
            print("ID $ID");
          }
          print('here1');
          // snapshot.data.clear();
          if (snapshot.data.containsKey('token')) {
            TOKEN = snapshot.data.getString('token');
            print('here2');
            print(TOKEN);
            return MainWrapperView();
          } else {
            return OnboardingView();
          }
        });
  }
}
