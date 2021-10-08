import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/primary_button.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/translates.dart';
import 'package:unic_app/views/driver_map/driver_map_view.dart';
import 'package:unic_app/views/driver_map/driver_map_viewmodel.dart';
import 'package:unic_app/views/user/map_page/map_page_viewmodel.dart';

class DriverYourTripEnded extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
  DriverYourTripEnded({Key key, this.model, this.size}) : super(key: key);
  final DriverMapViewModel model;

  final Size size;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: size.height / (815 / 30),
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: size.width / (375 / 16)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            model.status = StatusOfMapDriver.WaitinigForTrip;
                          },
                          child: SvgPicture.asset(
                            'assets/map_page/close_square.svg',
                            color: kPrimaryColor,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        AutoSizeText(
                          '${kOrderTranslates['ride_completed'][LANGUAGE]}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        SvgPicture.asset(
                          'assets/close_square.svg',
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                    SizedBox(height: size.height / (815 / 30)),
                    EndTripCustomerContainer(size: size, model: model),
                    SizedBox(height: size.height / (815 / 51)),
                    AutoSizeText(
                      '${kOrderTranslates['end_of_trip'][LANGUAGE]}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: kTextSecondaryColor),
                    ),
                    SizedBox(height: size.height / (815 / 57)),
                    AutoSizeText(
                      model.paymentType == 'Cash'
                          ? '${kOrderTranslates['payment_with_cash'][LANGUAGE]}: '
                          : '${kOrderTranslates['payment_with_card'][LANGUAGE]}: ',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: kTextPrimary),
                    ),
                    SizedBox(height: size.height / (815 / 30)),
                    model.paymentType == 'Cash'
                        ? buildContainerCash(payment: model.costOfTrip)
                        : buildContainerCard(payment: model.costOfTrip),
                    SizedBox(height: size.height / (815 / 140)),
                  ],
                ),
              ),
              PrimaryButton(
                size: size,
                color: kPrimaryColor,
                function: () =>
                    model.status = StatusOfMapDriver.WaitinigForTrip,
                textColor: Colors.white,
                title: '${kGeneralTranslates['done'][LANGUAGE]}',
              )
            ],
          ),
        ),
      ),
    );
  }

  buildContainerCash({payment}) {
    return Container(
      width: size.width,
      height: size.height / (815 / 180),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: size.height / (815 / 8),
          top: size.height / (815 / 14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  '$payment ',
                  style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                SvgPicture.asset('assets/map_page/manat.svg'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildContainerCard({payment}) {
    return Container(
      width: size.width,
      height: size.height / (815 / 180),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: size.height / (815 / 8),
          top: size.height / (815 / 14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: size.width / (375 / 16)),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset('assets/map_page/credit_card.svg')),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  '$payment ',
                  style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                SvgPicture.asset('assets/map_page/manat.svg'),
              ],
            ),
            Container(
              width: size.width / (375 / 300),
              height: size.height / (815 / 35),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      color: Color(0xff000000).withOpacity(0.25))
                ],
                color: Color(0xffFF0000),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: AutoSizeText(
                  'Do not take cash, the payment is proceeded with card.',
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EndTripCustomerContainer extends StatelessWidget {
  const EndTripCustomerContainer({
    Key key,
    @required this.size,
    @required this.model,
  }) : super(key: key);

  final Size size;
  final DriverMapViewModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: size.height / (815 / 110),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: kPrimaryColor, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: size.height / (815 / 16),
          horizontal: size.width / (375 / 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: size.width / (375 / 32),
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: size.width / (375 / 30),
                    backgroundImage: NetworkImage(
                        "https://unikeco.az${model.customer.profilePicAdress}"),
                  ),
                ),
                SizedBox(
                  width: size.width / (375 / 16),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      '${kOrderTranslates['your_trip_was'][LANGUAGE]} ${model.customer.name}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: size.height / (815 / 4),
                    ),
                    AutoSizeText(
                      '${model.customer.phone}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
