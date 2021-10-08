import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:unic_app/components/colors.dart';

class EditTextField extends StatefulWidget {
  EditTextField({
    Key key,
    @required this.size,
    @required this.hintTitle,
    @required this.hintText,
    this.controller,
    this.isNumber = false,
    this.enabled = true,
  }) : super(key: key);

  final Size size;
  final String hintTitle;
  final String hintText;
  final TextEditingController controller;
  bool isNumber = false;
  bool enabled;

  @override
  State<EditTextField> createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<EditTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55,
        padding: EdgeInsets.symmetric(
            vertical: widget.size.height / (812 / 6),
            horizontal: widget.size.width / (375 / 16)),
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText('${widget.hintTitle}',
                  style: TextStyle(
                      color: kTextSecondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
              TextField(
                controller: widget.controller,
                enabled: widget.enabled,
                // onChanged: (val) => widget.controller.text = val,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: -20),
                    // hintText: widget.hintText ?? '',
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: kTextPrimary),
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              )
            ],
          ),
          widget.isNumber
              ? Container()
              : Positioned(
                  top: widget.size.height / (812 / 12),
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
                color: widget.isNumber ? kTextSecondaryColor : kPrimaryColor,
                width: 1),
            borderRadius: BorderRadius.all(Radius.circular(15))));
  }
}

class TopCancelSaveRow extends StatelessWidget {
  const TopCancelSaveRow({
    Key key,
    this.onTap,
  }) : super(key: key);
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: AutoSizeText('Cancel',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400)),
        ),
        AutoSizeText(
          'Edit profile',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        GestureDetector(
          onTap: onTap,
          child: AutoSizeText(
            'Save',
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
