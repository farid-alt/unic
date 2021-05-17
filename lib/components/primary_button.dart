import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  Size size;
  String title;
  Color color;
  Color textColor;
  Function function;
  PrimaryButton(
      {this.size, this.color, this.textColor, this.title, this.function});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => function(),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(
          horizontal: size.width / (375 / 16),
        ),
        width: size.width,
        height: 60,
        child: Center(
          child: AutoSizeText(
            '$title',
            style: TextStyle(fontSize: 20, color: textColor),
          ),
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
