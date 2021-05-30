import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/back_with_title.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/ride%20history/start2end_icon.dart';
import 'package:unic_app/views/user/ride_history/ride_history_viewmodel.dart';
import 'package:unic_app/views/user/ride_issues/ride_issues_view.dart';
import 'package:unic_app/views/user/support/support_view.dart';

class RideDetailsView extends StatelessWidget {
  final int index;

  const RideDetailsView({Key key, @required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder.nonReactive(
      builder: (context, model, child) => Scaffold(
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
                BackWithTitle(size: size, title: 'Ride details'),
                SizedBox(height: size.height / (812 / 32)),
                RideDetailedContainer(
                    size: size,
                    index: index,
                    startAdress: model.rides[index].startAdress,
                    endAdress: model.rides[index].endAdress,
                    endTime:
                        DateFormat('HH:mm').format(model.rides[index].endTime),
                    startTime: DateFormat('HH:mm')
                        .format(model.rides[index].startTime)),
                SizedBox(height: size.height / (812 / 16)),
                Container(
                  width: double.infinity,
                  height: size.height / (812 / 218),
                  decoration: buildBoxDecoration(),
                ),
                SizedBox(height: size.height / (812 / 16)),
                YourTripWithContainer(
                    size: size,
                    index: index,
                    photo: model.rides[index].driver.profilePicAdress,
                    name: model.rides[index].driver.name,
                    number: model.rides[index].driver.number,
                    rating: model.rides[index].driver.rating),
                SizedBox(height: size.height / (812 / 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PaymentContainer(
                        title: 'Payment method',
                        size: size,
                        index: index,
                        content: model.rides[index].paymentMethod),
                    PaymentContainer(
                        title: 'Payment',
                        size: size,
                        index: index,
                        content:
                            model.rides[index].ridePrice.toString() + ' AZN'),
                  ],
                ),
                SizedBox(height: size.height / (812 / 16)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RideIssuesView(
                                  customer: model.rides[index].customer,
                                )));
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
                        'Report a problem',
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
      ),
      viewModelBuilder: () => RideHistoryViewModel(),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: Color(0xffF8F9FA),
    );
  }
}

class PaymentContainer extends StatelessWidget {
  const PaymentContainer({
    Key key,
    @required this.size,
    @required this.index,
    @required this.content,
    @required this.title,
  }) : super(key: key);

  final Size size;
  final int index;
  final String content;
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
          AutoSizeText(
            '${content}',
            style: TextStyle(
                color: kTextPrimary, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14), color: Color(0xffF8F9FA)),
    );
  }
}

class YourTripWithContainer extends StatelessWidget {
  const YourTripWithContainer({
    Key key,
    @required this.size,
    @required this.index,
    @required this.name,
    @required this.number,
    @required this.rating,
    @required this.photo,
  }) : super(key: key);

  final Size size;
  final int index;
  final String name, number, photo;
  final double rating;

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
                  backgroundImage: photo.isNotEmpty
                      ? NetworkImage('${photo}')
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
                                  text: '${name}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: kTextPrimary,
                                      fontSize: 14))
                            ])
                      ],
                    )),
                    SizedBox(height: size.height / (812 / 10)),
                    AutoSizeText(
                      '${number}',
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
                rating % 1 == 0 ? '${rating.toString()[0]}' : '${rating}',
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
    @required this.index,
    @required this.startAdress,
    @required this.startTime,
    @required this.endAdress,
    @required this.endTime,
  }) : super(key: key);

  final Size size;
  final int index;
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
                'From - ${startTime}',
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
                'To - ${endTime}',
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
