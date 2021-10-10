import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/models/user/ride.dart';

class NewPriceRow extends StatelessWidget {
  const NewPriceRow({
    Key key,
    this.promoPrice,
    this.tarifPrice,
    @required this.size,
    // @required this.ridePrice,
  }) : super(key: key);

  final String tarifPrice;
  final String promoPrice;
  final Size size;
  // final String ridePrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AutoSizeText(
          '${tarifPrice} AZN',
          style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: kTextPrimary,
              fontSize: 8,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          width: size.width / (375 / 5),
        ),
        AutoSizeText(
          '${promoPrice} AZN',
          style: TextStyle(
              color: kTextPrimary, fontSize: 16, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}

class NewPriceColumnSmall extends StatelessWidget {
  const NewPriceColumnSmall({
    Key key,
    this.promoPrice,
    this.tarifPrice,
    @required this.size,
    // @required this.ridePrice,
  }) : super(key: key);

  final String tarifPrice;
  final String promoPrice;
  final Size size;
  // final String ridePrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AutoSizeText(
          '${tarifPrice} AZN',
          style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.white,
              fontSize: 8,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          width: size.width / (375 / 5),
        ),
        AutoSizeText(
          '${promoPrice} AZN',
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}

class NewPriceRowSmall extends StatelessWidget {
  const NewPriceRowSmall({
    Key key,
    this.promoPrice,
    this.tarifPrice,
    @required this.size,
    // @required this.ridePrice,
  }) : super(key: key);

  final String tarifPrice;
  final String promoPrice;
  final Size size;
  // final String ridePrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AutoSizeText(
          '${tarifPrice} AZN',
          style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: kTextPrimary,
              fontSize: 6,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          width: size.width / (375 / 5),
        ),
        AutoSizeText(
          '${promoPrice} AZN',
          style: TextStyle(
              color: kTextPrimary, fontSize: 14, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
