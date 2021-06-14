import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:unic_app/components/colors.dart';

class EditTextFieldDriver extends StatelessWidget {
  EditTextFieldDriver({
    Key key,
    @required this.size,
    @required this.hintTitle,
    @required this.hintText,
    this.controller,
    this.isNumber = false,
  }) : super(key: key);

  final Size size;
  final String hintTitle;
  final String hintText;
  final TextEditingController controller;
  bool isNumber = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size.height / (812 / 70),
        padding: EdgeInsets.symmetric(
            vertical: size.height / (812 / 6),
            horizontal: size.width / (375 / 16)),
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AutoSizeText('$hintTitle',
              //     style: TextStyle(
              //         color: kTextSecondaryColor,
              //         fontSize: 14,
              //         fontWeight: FontWeight.w400)),
              TextField(
                onChanged: (val) => controller.text = val,
                decoration: InputDecoration(
                    // contentPadding:
                    //     EdgeInsets.only(top: size.height / (812 / -20)),
                    // hintText: '$hintText',
                    // hintStyle: TextStyle(
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.w400,
                    //     color: kTextPrimary),
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              )
            ],
          ),
          isNumber
              ? Container()
              : Positioned(
                  top: size.height / (812 / 12),
                  right: 0,
                  child: AutoSizeText('edit',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ),
        ]),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(
                color: isNumber ? kTextSecondaryColor : kPrimaryColor,
                width: 1),
            borderRadius: BorderRadius.all(Radius.circular(15))));
  }
}
