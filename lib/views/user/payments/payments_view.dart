import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/back_with_title.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/views/user/payments/payments_viewmodel.dart';
import '/views/user/add card/add_card_view.dart';

class PaymentsView extends KFDrawerContent {
  @override
  _PaymentsViewState createState() => _PaymentsViewState();
}

class _PaymentsViewState extends State<PaymentsView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ViewModelBuilder<PaymentsViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(
            top: size.height / (812 / 60),
            bottom: size.height / (812 / 50),
            left: size.width / (375 / 16),
            right: size.width / (375 / 16),
          ),
          child: FutureBuilder(
              future: model.getCreditCards,
              builder: (context, snapshot) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackWithTitle(size: size, title: 'Payments'),
                    SizedBox(height: size.height / (812 / 55)),
                    for (int i = 0; i < model.payments.length; i++)
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PaymentMethodRow(size: size, index: i),
                            SizedBox(height: size.height / (812 / 28))
                          ]),
                    Expanded(child: SizedBox(height: 1)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddCardView(model: model)));
                      },
                      child: Container(
                        width: double.infinity,
                        height: size.height / (812 / 60),
                        child: Center(
                          child: AutoSizeText(
                            'Add card',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                    SizedBox(height: size.height / (812 / 10)),
                  ],
                );
              }),
        ),
      ),
      viewModelBuilder: () => PaymentsViewModel(),
    );
  }
}

class PaymentMethodRow extends ViewModelWidget<PaymentsViewModel> {
  const PaymentMethodRow({
    Key key,
    @required this.index,
    @required this.size,
  }) : super(key: key);

  final Size size;
  final int index;

  @override
  Widget build(BuildContext context, PaymentsViewModel model) {
    return GestureDetector(
      onTap: () => model.changeSelectedElement(index),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                  model.payments[index]['card'].type == PaymentType.MasterCard
                      ? 'assets/master.png'
                      : model.payments[index]['card'].type == PaymentType.Visa
                          ? 'assets/visa.png'
                          : 'assets/Wallet.png',
                  height: size.width / (375 / 32),
                  width: size.width / (375 / 32)),
              SizedBox(width: size.width / (375 / 16)),
              AutoSizeText(
                model.payments[index]['card'].type == PaymentType.MasterCard
                    ? 'MasterCard ' +
                        '****' +
                        model.payments[index]['card'].cardNumber.substring(
                            (model.payments[index]['card'].cardNumber.length /
                                            model.payments[index]['card']
                                                .cardNumber.length <=
                                        8
                                    ? 4
                                    : 11)
                                .toInt())
                    : model.payments[index]['card'].type == PaymentType.Visa
                        ? 'Visa ' +
                            '****' +
                            model.payments[index]['card'].cardNumber.substring(
                                (model.payments[index]['card'].cardNumber
                                            .length /
                                        2)
                                    .toInt())
                        : 'Cash',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: kTextPrimary),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: SvgPicture.asset(
              'assets/notChoosen.svg',
              height: size.width / (375 / 16),
              width: size.width / (375 / 16),
              color: model.payments[index]['isChoosen']
                  ? kPrimaryColor
                  : Color(0xffE1E1E1),
            ),
          )
        ],
      ),
    );
  }
}
