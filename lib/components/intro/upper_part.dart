import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:unic_app/components/colors.dart';

class IntroUpperPart extends StatelessWidget {
  const IntroUpperPart({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: kPrimaryColor,
      child: Column(
        children: [
          SizedBox(
            height: size.height / (812 / 70),
          ),
          AutoSizeText(
            'Welcome,',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          AutoSizeText(
            'Our Community!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: size.height / (812 / 44),
          ),
          Image.asset(
            'assets/onboarding/main_image.png',
            width: size.width / (375 / 343),
            height: size.height / (815 / 300),
          )
        ],
      ),
    );
  }
}
