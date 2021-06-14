import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:unic_app/views/driver/your%20trips/your_trips_view.dart';

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
      home: YourTripsView(),
      //home: UserProfileEditPageView(),
    );
  }
}
