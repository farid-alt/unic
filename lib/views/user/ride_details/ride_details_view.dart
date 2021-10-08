import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/back_with_title.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/map_page/crossText.dart';
import 'package:unic_app/components/ride%20history/start2end_icon.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/models/user/driver.dart';
import 'package:unic_app/models/user/ride.dart';
import 'package:unic_app/translates.dart';
import 'package:unic_app/views/user/ride_details/ride_details_viewmodel.dart';
import 'package:unic_app/views/user/ride_history/ride_history_viewmodel.dart';
import 'package:unic_app/views/user/ride_issues/ride_issues_view.dart';
import 'package:unic_app/views/user/support/support_view.dart';

class RideDetailsView extends StatelessWidget {
  final Ride ride;
  bool driver;
  TextEditingController issueTopicController = TextEditingController();
  TextEditingController issueDescriptionController = TextEditingController();
  RideDetailsView({Key key, @required this.ride, this.driver = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<RideDetailsViewModel>.reactive(
        builder: (context, RideDetailsViewModel model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / (375 / 16),
                  vertical: size.height / (812 / 60)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BackWithTitle(
                        size: size,
                        title: '${kMenuTranslates['ride_details'][LANGUAGE]}'),
                    SizedBox(height: size.height / (812 / 32)),
                    RideDetailedContainer(
                        size: size,
                        // index: index,
                        startAdress: ride.startAdress,
                        endAdress: ride.endAdress,
                        endTime: DateFormat('HH:mm').format(ride.endTime),
                        startTime: DateFormat('HH:mm').format(ride.startTime)),
                    SizedBox(height: size.height / (812 / 16)),
                    Container(
                      width: double.infinity,
                      height: size.height / (812 / 218),
                      decoration: buildBoxDecoration(),
                    ),
                    SizedBox(height: size.height / (812 / 16)),
                    //TODO ADD DRIVER
                    // YourTripWithContainer(
                    //     size: size,
                    //     // index: index,
                    //     photo: ride.driver.profilePicAdress,
                    //     name: ride.driver.name,
                    //     number: ride.driver.number,
                    //     rating: ride.driver.rating),
                    SizedBox(height: size.height / (812 / 16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PaymentContainer(
                            title:
                                '${kMenuTranslates['payment_method'][LANGUAGE]}',
                            size: size,
                            // index: index,
                            paymentMethodFlag: true,
                            paymentMethod: ride.paymentMethod),
                        PaymentContainer(
                            title: '${kMenuTranslates['payment'][LANGUAGE]}',
                            size: size,
                            // index: index,
                            ride: ride,
                            paymentMethodFlag: false,
                            paymentMethod: ride.ridePrice.toString() + ' AZN'),
                      ],
                    ),
                    SizedBox(height: size.height / (812 / 16)),
                    GestureDetector(
                      onTap: () {
                        if (driver) {
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: Container(
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.all(16),
                                            height: size.height / (812 / 100),
                                            child: TextField(
                                              controller: issueTopicController,
                                              maxLines: 5,
                                              autocorrect: false,
                                              decoration: InputDecoration(
                                                  hintText: 'Write topic',
                                                  border: InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none),
                                            ),
                                            color: Color(0xffF8F9FA),
                                          ),
                                          SizedBox(
                                              height: size.height / (812 / 16)),
                                          Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.all(16),
                                            height: size.height / (812 / 200),
                                            child: TextField(
                                              controller:
                                                  issueDescriptionController,
                                              onChanged: (val) {
                                                // model.choosenIssueDescription = val;
                                              },
                                              maxLines: 5,
                                              autocorrect: false,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      'Write what happenned here',
                                                  border: InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  disabledBorder:
                                                      InputBorder.none),
                                            ),
                                            color: Color(0xffF8F9FA),
                                          ),
                                          SizedBox(
                                              height: size.height / (812 / 16)),
                                          ElevatedButton(
                                              onPressed: () {
                                                //TODO: implement sending issue
                                                // if (model.choosenIssueDescription
                                                //     .isNotEmpty)
                                                if (issueDescriptionController
                                                        .text.isEmpty ||
                                                    issueTopicController
                                                        .text.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg: 'Check the data',
                                                      gravity:
                                                          ToastGravity.CENTER);
                                                } else {
                                                  model.sendIssue(
                                                      rideId: ride.rideId,
                                                      topic:
                                                          issueTopicController
                                                              .text,
                                                      text:
                                                          issueDescriptionController
                                                              .text);
                                                  Navigator.pop(context);
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Your issue was successfully send');
                                                }
                                                // print(model
                                                //     .choosenIssueDescription);
                                              },
                                              child: Text('Send'))
                                        ],
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height / (812 / 16),
                                          horizontal: size.width / (375 / 16)),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  ));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RideIssuesView(
                                        rideId: ride.rideId.toString(),
                                        // customer: ride.customer,
                                      )));
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: size.height / (812 / 60),
                        padding: EdgeInsets.symmetric(
                            vertical: size.height / (812 / 18)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: kPrimaryColor),
                        child: Center(
                          child: AutoSizeText(
                            '${kMenuTranslates['report_a_problem'][LANGUAGE]}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     //TODO: report a problem
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => RideIssuesView(
                    //                   customer: model.rides[index].customer,
                    //                 )));
                    //   },
                    //   child: Container(
                    //     width: double.infinity,
                    //     height: size.height / (812 / 65),
                    //     padding: EdgeInsets.symmetric(
                    //         vertical: size.height / (812 / 16)),
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(14),
                    //         color: Color(0xffF8F9FA)),
                    //     child: Center(
                    //       child: AutoSizeText(
                    //         'Report a problem',
                    //         style: TextStyle(
                    //             color: kPrimaryColor,
                    //             fontSize: 15,
                    //             fontWeight: FontWeight.w500),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: size.height / (812 / 16)),
                  ],
                ),
              ),
            ),
          );
        },
        viewModelBuilder: () => RideDetailsViewModel());
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: Color(0xffF8F9FA),
    );
  }
}

class PaymentContainer extends StatelessWidget {
  const PaymentContainer(
      {Key key,
      @required this.size,
      // @required this.index,
      @required this.paymentMethod,
      @required this.title,
      this.paymentMethodFlag,
      this.ride})
      : super(key: key);
  final Ride ride;
  final Size size;
  // final int index;
  final String paymentMethod;
  final bool paymentMethodFlag;

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / (375 / 168),
      padding: EdgeInsets.symmetric(
          horizontal: size.width / (375 / 16),
          vertical: size.height / (812 / 16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            '$title',
            style: TextStyle(
                color: kTextPrimary, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: size.height / (812 / 4)),
          // AutoSizeText(
          //   '${content}',
          //   style: TextStyle(
          //       color: kTextPrimary, fontSize: 16, fontWeight: FontWeight.w700),
          // ),
          paymentMethodFlag
              ? AutoSizeText(
                  '${paymentMethod}',
                  style: TextStyle(
                      color: kTextPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                )
              : ride.ridePrice == ride.tarrifPrice
                  ? AutoSizeText(
                      '${ride.ridePrice} AZN',
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
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14), color: Color(0xffF8F9FA)),
    );
  }
}

class YourTripWithContainer extends StatelessWidget {
  const YourTripWithContainer(
      {Key key,
      @required this.size,
      // // @required this.index,
      // @required this.name,
      // @required this.number,
      // @required this.rating,
      // @required this.photo,
      this.driver})
      : super(key: key);

  final Size size;
  // final int index;
  // final String name, number, photo;
  // final double rating;
  final Driver driver;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: size.width / (375 / 16),
          vertical: size.height / (812 / 16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: size.width / (375 / 24),
                  backgroundImage: driver.profilePicAdress.isNotEmpty
                      ? NetworkImage('${driver.profilePicAdress.isNotEmpty}')
                      : AssetImage('assets/avatar_placeholder.png'),
                ),
                SizedBox(width: size.width / (375 / 10)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText.rich(TextSpan(
                      children: [
                        TextSpan(
                            text: 'Your trip with ',
                            style: TextStyle(
                                color: kTextPrimary,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                            children: [
                              TextSpan(
                                  text: '${driver.fullname}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: kTextPrimary,
                                      fontSize: 14))
                            ])
                      ],
                    )),
                    SizedBox(height: size.height / (812 / 10)),
                    AutoSizeText(
                      '${driver.fullname}',
                      style: TextStyle(
                          color: kTextSecondaryColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ]),
          Row(
            children: [
              AutoSizeText(
                driver.rating % 1 == 0
                    ? '${driver.rating.toString()[0]}'
                    : '${driver.rating}',
                style: TextStyle(
                    color: kTextPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(width: size.width / (375 / 2)),
              Icon(Icons.star, color: kPrimaryColor, size: 16)
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Color(0xffF8F9FA),
      ),
    );
  }
}

class RideDetailedContainer extends StatelessWidget {
  const RideDetailedContainer({
    Key key,
    @required this.size,
    // @required this.index,
    @required this.startAdress,
    @required this.startTime,
    @required this.endAdress,
    @required this.endTime,
  }) : super(key: key);

  final Size size;
  // final int index;
  final String startAdress;
  final String startTime;
  final String endAdress;
  final String endTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: size.width / (375 / 18),
          vertical: size.height / (812 / 20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height / (812 / 5)),
            child: StartToEndIcon(size: size),
          ),
          SizedBox(width: size.width / (375 / 10)),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                '${startAdress}',
                style: TextStyle(
                    color: kTextPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              AutoSizeText(
                '${kMenuTranslates['from'][LANGUAGE]} - ${startTime}',
                style: TextStyle(
                    color: Color(0xff969B9E),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: size.height / (812 / 25)),
              AutoSizeText(
                '${endAdress}',
                style: TextStyle(
                    color: kTextPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              AutoSizeText(
                '${kMenuTranslates['to'][LANGUAGE]} - ${endTime}',
                style: TextStyle(
                    color: Color(0xff969B9E),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Color(0xffF8F9FA),
      ),
    );
  }
}
