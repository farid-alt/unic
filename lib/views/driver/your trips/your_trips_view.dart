import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/views/driver/your%20trips/your_trips_viewmodel.dart';

class YourTripsView extends StatelessWidget {
  const YourTripsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ViewModelBuilder<YourTripsViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width / (375 / 16),
                    vertical: size.height / (812 / 68)),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AutoSizeText('Your trips',
                          style: TextStyle(
                              color: kTextPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                      SizedBox(height: size.height / (812 / 42)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText(
                              model.isOnline
                                  ? 'You are online'
                                  : 'You are offline',
                              style: TextStyle(
                                  color: kTextPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                          GestureDetector(
                            onTap: () => model.isOnline = !model.isOnline,
                            child: SvgPicture.asset(
                                model.isOnline
                                    ? 'assets/user_profile/icons/switch-on.svg'
                                    : 'assets/user_profile/icons/off.svg',
                                height: size.height / (812 / 30),
                                width: size.width / (375 / 50)),
                          )
                        ],
                      ),
                      SizedBox(height: size.height / (812 / 24)),
                      Container(
                        height: size.height / (812 / 129),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width / (375 / 16),
                          vertical: size.height / (812 / 16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AutoSizeText('#1  Your trip',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16)),
                                GestureDetector(
                                  onTap: (){},//TODO: canceling trip
                                  child: SvgPicture.asset('assets/Close Square.svg',
                                      height: size.width / (375 / 20),
                                      width: size.width / (375 / 20)),
                                )
                              ],
                            ),
                      SizedBox(height: size.height / (812 / 20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar()
                        ],
                      )

                          ],
                        ),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(14),
                                topRight: Radius.circular(14))),
                      )
                    ],
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => YourTripsViewModel());
  }
}
