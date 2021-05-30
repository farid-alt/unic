import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:unic_app/components/colors.dart';

class BackWithTitle extends StatelessWidget {
  const BackWithTitle({
    Key key,
    @required this.size,
    this.title = 'Promotions',
    this.isBlue = false,
  }) : super(key: key);

  final Size size;
  final String title;
  final bool isBlue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Icon(Icons.arrow_back_ios,
                color: isBlue ? Colors.white : kPrimaryColor,
                size: size.height / (812 / 24)),
            AutoSizeText(
              'Back',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isBlue ? Colors.white : kPrimaryColor),
            ),
            // SizedBox(width: size.width / (375 / 0)),
          ]),
        ),
        AutoSizeText(
          '$title',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: isBlue ? Colors.white : kTextPrimary),
        ),

        // SizedBox(width: size.width / (375 / 10)),
        Row(
          children: [
            AutoSizeText('Back',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.transparent,
                )),
            Icon(Icons.arrow_back_ios,
                color: Colors.transparent, size: size.height / (812 / 24)),
          ],
        ),
      ],
    );
  }
}
