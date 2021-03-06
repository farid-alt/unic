import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/map_page/crossText.dart';
import 'package:unic_app/components/ride%20history/start2end_icon.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/models/user/ride.dart';
import 'package:unic_app/translates.dart';
import 'package:unic_app/views/user/ride_details/ride_details_view.dart';
import 'package:unic_app/views/user/ride_history/ride_history_viewmodel.dart';

class RideHistoryContainer extends ViewModelWidget<RideHistoryViewModel> {
  RideHistoryContainer(
      {Key key,
      @required this.size,
      @required this.endAdress,
      @required this.startAdress,
      @required this.rideDate,
      @required this.ridePrice,
      @required this.rideRating,
      this.isDriver = false,
      // @required this.index,
      @required this.ride})
      : super(key: key);

  final Size size;
  final String startAdress, endAdress;
  final String rideDate;
  final double rideRating;
  final String ridePrice;
  // final int index;
  final Ride ride;
  bool isDriver;
  @override
  Widget build(BuildContext context, RideHistoryViewModel model) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.height / (812 / 6)),
                    child: StartToEndIcon(size: size),
                  ),
                  SizedBox(width: size.width / (375 / 12)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width / (375 / 120),
                        child: AutoSizeText(
                          '$startAdress',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: kTextPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height / (812 / 38)),
                        child: SizedBox(
                          width: size.width / (375 / 92),
                          child: AutoSizeText(
                            '$endAdress',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: kTextPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: size.height / (812 / 5)),
                  AutoSizeText(
                    '$rideDate',
                    style: TextStyle(
                        color: Color(0xff848B8F),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: size.height / (812 / 8)),
                  // RatingBarIndicator(
                  //   rating: model.rides[0].rideRating,
                  //   itemBuilder: (context, index) => Icon(
                  //     Icons.star,
                  //     color: kPrimaryColor,
                  //   ),
                  //   itemCount: 5,
                  //   itemSize: 16,
                  //   direction: Axis.horizontal,
                  // ),
                  SizedBox(height: size.height / (812 / 8)),
                  ride.ridePrice == ride.tarrifPrice
                      ? AutoSizeText(
                          '$ridePrice AZN',
                          style: TextStyle(
                              color: kTextPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        )
                      : NewPriceRow(
                          promoPrice: ride.ridePrice,
                          tarifPrice: ride.tarrifPrice,
                          size: size,
                        ),
                ],
              )
            ],
          ),
          SizedBox(height: size.height / (812 / 16)),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RideDetailsView(
                              driver: isDriver,
                              ride: ride,
                            )));
              },
              child: buildContainerBtnText(
                  size, '${kMenuTranslates['ride_details'][LANGUAGE]}'))
        ],
      ),
      padding: EdgeInsets.symmetric(
          horizontal: size.width / (375 / 16),
          vertical: size.height / (812 / 16)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Color(0xffF8F9FA),
      ),
    );
  }
}

Container buildContainerBtnText(Size size, String title) {
  return Container(
    width: double.infinity,
    height: size.height / (812 / 48),
    child: Center(
      child: AutoSizeText(
        '$title',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: kPrimaryColor, fontWeight: FontWeight.w500, fontSize: 14),
      ),
    ),
    decoration: BoxDecoration(
      color: Color(0xffECECEC),
      borderRadius: BorderRadius.circular(14),
    ),
  );
}
