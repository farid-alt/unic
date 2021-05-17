import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:unic_app/components/colors.dart';

class IntroTextComponent extends StatelessWidget {
  const IntroTextComponent(
      {Key key, @required this.size, this.text, this.title})
      : super(key: key);

  final Size size;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: size.height / (815 / 56),
        ),
        AutoSizeText(
          '$title',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: kTextPrimary),
        ),
        SizedBox(
          height: size.height / (815 / 16),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width / (375 / 16),
          ),
          child: AutoSizeText(
            '$text',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff565C61)),
          ),
        ),
      ],
    );
  }
}
