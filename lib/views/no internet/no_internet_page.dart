import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/primary_button.dart';

class NoInternetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffF5F5F8),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / (375 / 30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width / (375 / 134),
              height: size.height / (812 / 120),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/ride_history/noInternet.png'))),
            ),
            SizedBox(height: size.height / (812 / 27)),
            AutoSizeText('No internet Connection',
                style: TextStyle(
                    color: kTextPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 24)),
            SizedBox(height: size.height / (812 / 16)),
            AutoSizeText(
                'Your internet connection is currently\nnot available please check or try again.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: kTextSecondaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16)),
            SizedBox(height: size.height / (812 / 56)),
            PrimaryButton(
              function: () {}, //TODO: implement try again
              color: kPrimaryColor,
              size: size,
              textColor: Colors.white,
              title: 'Try again',
            )
          ],
        ),
      ),
    );
  }
}
