import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/back_with_title.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/primary_button.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/translates.dart';
import 'package:unic_app/views/user/get_rides/get_rides_viewmodel.dart';
import 'package:clipboard/clipboard.dart';

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
          BackWithTitle(
              size: size,
              title: '${kMenuTranslates['get_free_rides'][LANGUAGE]}',
              isBlue: true),
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
            '${kMenuTranslates['get_free_rides'][LANGUAGE]}',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
          ),
          SizedBox(height: size.height / (812 / 10)),
          AutoSizeText(
            '${kMenuTranslates['invite1'][LANGUAGE]} ${model.referal.discountAmount} ${kMenuTranslates['invite2'][LANGUAGE]}',
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
                    AutoSizeText("${kMenuTranslates['promo_code'][LANGUAGE]}",
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
                InkWell(
                    onTap: () {
                      FlutterClipboard.copy(model.referal.refCode)
                          .then((value) => print('copied'));
                      Fluttertoast.showToast(
                          msg: 'Copied!',
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.green);
                    },
                    child: Icon(Icons.copy, color: kPrimaryColor, size: 16))
              ],
            ),
          ),
          SizedBox(height: size.height / (812 / 24)),
          PrimaryButton(
            color: kPrimaryColor,
            size: size,
            textColor: Colors.white,
            function: () => Share.share(
                'Download Unic and use my promo code ${model.referal.refCode}'),
            title: "${kMenuTranslates['invite_your_friend'][LANGUAGE]}",
          ),
        ],
      ),
    );
  }
}
