import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/back_with_title.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/primary_button.dart';
import 'package:unic_app/views/user/get_rides/get_rides_viewmodel.dart';

class PrimaryColorBox extends ViewModelWidget<GetRidesViewModel> {
  const PrimaryColorBox({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, GetRidesViewModel model) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width / (375 / 16),
          vertical: size.height / (812 / 50)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BackWithTitle(size: size, title: 'Get free rides', isBlue: true),
          SizedBox(height: size.height / (812 / 70)),
          Container(
            height: size.height / (812 / 193),
            width: size.width / (375 / 221),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/onboarding/main_image.png'),
            )),
          ),
          SizedBox(height: size.height / (812 / 24)),
          AutoSizeText(
            'Get free rides!',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
          ),
          SizedBox(height: size.height / (812 / 10)),
          AutoSizeText(
            'Invite a friend and get ${model.referal.discountAmount} AZN off\nyour next trip!',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class WhiteBox extends ViewModelWidget<GetRidesViewModel> {
  const WhiteBox({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, GetRidesViewModel model) {
    return Container(
      padding: EdgeInsets.only(
          left: size.width / (375 / 16),
          right: size.width / (375 / 16),
          top: size.height / (812 / 32),
          bottom: size.height / (812 / 50)),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: size.height / (812 / 6),
                horizontal: size.width / (375 / 16)),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: kPrimaryColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText('Your code',
                        style: TextStyle(
                            color: kTextSecondaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                    AutoSizeText('${model.referal.refCode}',
                        style: TextStyle(
                            color: kTextPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                Icon(Icons.copy, color: kPrimaryColor, size: 16)
              ],
            ),
          ),
          SizedBox(height: size.height / (812 / 24)),
          GestureDetector(
            onTap: () {}, //TODO: Invitation implementation
            child: PrimaryButton(
              color: kPrimaryColor,
              size: size,
              textColor: Colors.white,
              title: 'Invite your friend',
            ),
          ),
        ],
      ),
    );
  }
}
