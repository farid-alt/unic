import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ArrowBackBtn extends StatelessWidget {
  const ArrowBackBtn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Colors.white,
        ),
        AutoSizeText(
          'Back',
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
