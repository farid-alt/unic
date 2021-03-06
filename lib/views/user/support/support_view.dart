import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/back_with_title.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/models/user/ride.dart';
import 'package:unic_app/translates.dart';
import 'package:unic_app/views/contact%20us/contact_us.dart';
import 'package:unic_app/views/user/faq/faq_view.dart';
import 'package:unic_app/views/user/ride_history/ride_history_viewmodel.dart';
import 'package:unic_app/views/user/ride_issues/ride_issues_view.dart';
import 'package:unic_app/views/user/support/support_viewmodel.dart';

class SupportView extends KFDrawerContent {
  SupportView({this.driver = false});
  bool driver;
  @override
  _SupportViewState createState() => _SupportViewState();
}

class _SupportViewState extends State<SupportView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<SupportViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width / (375 / 16),
                vertical: size.height / (812 / 60)),
            child: FutureBuilder(
                future: model.ridesFuture,
                builder: (context, snapshot) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BackWithTitle(
                          size: size,
                          title: '${kMenuTranslates['support'][LANGUAGE]}'),
                      SizedBox(height: size.height / (812 / 32)),
                      if (!widget.driver && model.rides.length != 0)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              '${kMenuTranslates['select_your_ride'][LANGUAGE]}',
                              style: TextStyle(
                                  color: kTextPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: size.height / (812 / 16)),
                            for (int index = 0;
                                index < model.rides.length;
                                index++)
                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RideIssuesView(
                                            rideId: model.rides[index].rideId
                                                .toString()))),
                                child: RideContainerSmallSupport(
                                    size: size,
                                    rideDate:
                                        '${DateFormat.MMMMd('en').format(model.rides[index].rideDate)}, ${DateFormat('hh:mm').format(model.rides[index].rideDate)}',
                                    endAdress: model.rides[index].endAdress,
                                    isMoped: model.rides[index].driver.isMoped),
                              ),
                            SizedBox(height: size.height / (812 / 16)),
                          ],
                        ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactUs()));
                          },
                          child: SimpleSupportContainer(
                              size: size,
                              title:
                                  '${kMenuTranslates['contact_us'][LANGUAGE]}')),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FaqView()));
                          },
                          child: SimpleSupportContainer(
                              size: size,
                              title: '${kMenuTranslates['faq'][LANGUAGE]}')),
                    ],
                  );
                }),
          )),
      viewModelBuilder: () => SupportViewModel(),
    );
  }
}

class SimpleSupportContainer extends StatelessWidget {
  const SimpleSupportContainer({
    Key key,
    @required this.size,
    @required this.title,
  }) : super(key: key);

  final Size size;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height / (812 / 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText('$title',
              style: TextStyle(
                  color: kTextPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500)),
          Icon(Icons.arrow_forward_ios,
              color: kTextSecondaryColor, size: size.width / (375 / 20))
        ],
      ),
      padding: EdgeInsets.symmetric(
          vertical: size.height / (812 / 16),
          horizontal: size.width / (375 / 16)),
      margin: EdgeInsets.only(bottom: size.height / (812 / 16)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Color(0xffF8F9FA)),
    );
  }
}

class RideContainerSmallSupport extends StatelessWidget {
  const RideContainerSmallSupport(
      {Key key,
      @required this.size,
      @required this.endAdress,
      @required this.rideDate,
      @required this.isMoped})
      : super(key: key);

  final Size size;
  final String endAdress;
  final String rideDate;
  final bool isMoped;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: size.height / (812 / 8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width / (375 / 32),
                height: size.height / (812 / 32),
                child: Center(
                  child: SvgPicture.asset(
                    isMoped ? 'assets/moped.svg' : 'assets/moto.svg',
                    height: size.height / (812 / 11),
                    width: size.width / (375 / 16),
                  ),
                ),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
              ),
              SizedBox(width: size.width / (375 / 16)),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width / (375 / 232),
                    child: AutoSizeText(
                      '$endAdress',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: kTextPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  AutoSizeText(
                    '$rideDate',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: kTextSecondaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              )
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: kTextSecondaryColor,
            size: size.width / (375 / 20),
          )
        ],
      ),
      padding: EdgeInsets.symmetric(
          vertical: size.height / (812 / 16),
          horizontal: size.width / (375 / 16)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Color(0xffF8F9FA)),
    );
  }
}
