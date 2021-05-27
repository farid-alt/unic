import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unic_app/components/colors.dart';

class PromoCodeRow extends StatelessWidget {
  const PromoCodeRow({
    Key key,
    @required this.size,
    @required this.promoCode,
    @required this.number,
    @required this.isUsed,
  }) : super(key: key);

  final Size size;
  final String promoCode;
  final int number; //index of promocode in list for view
  final bool isUsed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //SizedBox(height: size.height / (375 / 24)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText('#$number',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                SizedBox(width: size.width / (375 / 16)),
                AutoSizeText('$promoCode',
                    style: TextStyle(
                        color: kTextPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500))
              ],
            ),
            AutoSizeText(isUsed ? 'used' : '',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
          ],
        ),
      ],
    );
  }
}

class PromotionPageRows extends StatelessWidget {
  const PromotionPageRows({
    Key key,
    @required this.size,
    @required this.iconAdress,
    @required this.title,
  }) : super(key: key);

  final Size size;
  final String iconAdress;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              '${iconAdress}',
              height: size.height / (812 / 19),
              width: size.width / (375 / 20),
            ),
            SizedBox(width: size.width / (375 / 12)),
            AutoSizeText('$title',
                style: TextStyle(
                    fontSize: 16,
                    color: kTextPrimary,
                    fontWeight: FontWeight.w500)),
          ],
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: kTextSecondaryColor,
          size: size.width / (375 / 16),
        )
      ],
    );
  }
}

class NoPromoCodesWidget extends StatelessWidget {
  const NoPromoCodesWidget({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            height: size.height / (812 / 48),
            width: size.width / (375 / 48),
            decoration: BoxDecoration(
                color: kTextSecondaryColor, shape: BoxShape.circle),
            margin: EdgeInsets.only(
                bottom: size.height / (812 / 10),
                top: size.height / (812 / 210)),
            child: Center(
                child: SvgPicture.asset(
              'assets/promotions/Discount.svg',
              color: Colors.white,
            )),
          ),
          AutoSizeText(
            'Your promo codes\nwill appear here',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: kTextSecondaryColor),
          )
        ],
      ),
    );
  }
}
