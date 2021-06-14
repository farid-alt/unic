import 'dart:async';

import 'package:animator/animator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:location/location.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/primary_button.dart';
import 'package:unic_app/views/user/map_page/map_page_viewmodel.dart';
import 'package:unic_app/views/user/profile_page/profile_page_viewmodel.dart';
import 'package:unic_app/views/user/select_adress/select_adress_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPageView extends KFDrawerContent {
  @override
  _MapPageViewState createState() => _MapPageViewState();
}

class _MapPageViewState extends State<MapPageView> {
  // final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<MapPageViewModel>.reactive(
      builder: (context, MapPageViewModel model, child) => Scaffold(
          // backgroundColor: kPrimaryColor,
          body: Container(
        child: Stack(
          children: [
            Container(
              child: FutureBuilder<LocationData>(
                future: model.findMyLocation(),
                builder: (context, snapshot) {
                  return GoogleMap(
                    polylines: Set<Polyline>.of(model.polylines.values),
                    onMapCreated: (controller) {
                      model.mapController = controller;
                      // _controller.complete(controller);
                    },
                    markers: model.markers.values.toSet(),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                            snapshot.data.latitude, snapshot.data.longitude),
                        zoom: 15),
                  );
                },
              ),
            ),
            if (model.status == StatusOfMap.SearchingDriver)
              Overlay.show(context),
            Positioned(
              left: size.width / (375 / 16),
              top: size.height / (815 / 60),
              child: InkWell(
                onTap: widget.onMenuPressed,
                child: Container(
                  height: size.width / (375 / 40),
                  width: size.width / (375 / 40),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: kPrimaryColor),
                  child: Center(
                    child: SvgPicture.asset('assets/map_page/burger.svg'),
                  ),
                ),
              ),
            ),
            model.status == StatusOfMap.SearchingDriver
                ? CancelOrderMapPage(size: size)
                : model.status == StatusOfMap.ApplyYourTrip
                    ? SelectTripOptions(size: size)
                    : model.status == StatusOfMap.DriverComes
                        ? DriverIsComing(size: size)
                        : model.status == StatusOfMap.YouAreOnWay
                            ? YouAreOnWay(size: size)
                            : StartMapBottom(size: size)
          ],
        ),
      )),
      viewModelBuilder: () => MapPageViewModel(),
    );
  }
}

class YouAreOnWay extends ViewModelWidget<MapPageViewModel> {
  const YouAreOnWay({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, model) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            height: model.detailsOpenedOnWay
                ? size.height / 1.4
                : size.height / 2.3,
            color: Colors.white,
            duration: Duration(milliseconds: 300),
            child: Column(
              children: [
                Container(
                  constraints: BoxConstraints(
                    minHeight: size.height / (815 / 110),
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height / (815 / 16),
                      horizontal: size.width / (375 / 16),
                    ),
                    child: model.detailsOpenedOnWay
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: size.width / (375 / 32),
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: size.width / (375 / 30),
                                      backgroundImage: NetworkImage(
                                          model.driver.profilePicAdress),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width / (375 / 16),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        'Your driver is ${model.driver.name}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: size.height / (815 / 4),
                                      ),
                                      RatingBarIndicator(
                                          itemSize: size.width / (375 / 15),
                                          rating: model.driver.rating,
                                          itemBuilder: (context, index) {
                                            return Icon(
                                              Icons.star,
                                              color: Colors.white,
                                            );
                                          }),
                                      SizedBox(
                                        height: size.height / (815 / 5),
                                      ),
                                      Row(
                                        children: [
                                          //TODO Change to driver vehicle
                                          SvgPicture.asset(true
                                              ? 'assets/moped.svg'
                                              : 'assets/moto.svg'),
                                          SizedBox(
                                            width: size.width / (375 / 8),
                                          ),
                                          AutoSizeText(
                                            '${model.driver.vehicleNumberId}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Center(
                            child: AutoSizeText(
                              '${model.timeToArrivetToDestination} min left',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: size.width / (375 / 16)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height / (815 / 16),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          'Your trip',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: kTextPrimary),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElementSelectAdress(
                                  size: size, color: kPrimaryColor),
                              for (var i = 0; i < model.adresses.length; i++)
                                ElementSelectAdress2(
                                    size: size,
                                    color: kPrimaryColor,
                                    last: i != model.adresses.length - 1)
                            ],
                          ),
                          SizedBox(
                            width: size.width / (375 / 14),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: size.height / (815 / 13)),
                                    child: AutoSizeText(
                                      '${model.firstAdress.nameOfPlace}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: kPrimaryColor),
                                    ),
                                  )
                                ],
                              ),
                              for (var i = 0; i < model.adresses.length; i++)
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: size.height / (815 / 40)),
                                  child: Column(
                                    children: [
                                      AutoSizeText(
                                        '${model.adresses[i].nameOfPlace}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: kPrimaryColor),
                                      )
                                    ],
                                  ),
                                ),

                              // return Text('a');
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height / (815 / 16),
                      ),
                      ChangeDestination(size: size),
                      SizedBox(
                        height: size.height / (815 / 8),
                      ),
                      TripInfoContainer(size: size),
                      SizedBox(
                        height: size.height / (815 / 8),
                      ),
                      PaymentType(size: size),
                      SizedBox(
                        height: size.height / (815 / 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: size.width,
            height: size.height / (815 / 100),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(bottom: size.height / (815 / 30)),
              child: PrimaryButton(
                function: () {
                  // model.detailsOpenedOnWay = !model.detailsOpenedOnWay;
                  // model.drawPolyline();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => YourTripEnded(
                        size: size,
                        model: model,
                      ),
                    ),
                  );
                },
                color: kPrimaryColor,
                textColor: Colors.white,
                title: model.detailsOpenedOnWay ? 'Cancel' : 'Order details',
                size: size,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class YourTripEnded extends StatefulWidget {
  YourTripEnded({Key key, this.model, this.size}) : super(key: key);
  final MapPageViewModel model;
  final Size size;

  @override
  _YourTripEndedState createState() => _YourTripEndedState();
}

class _YourTripEndedState extends State<YourTripEnded> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: widget.size.height / (815 / 30),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: widget.size.width / (375 / 16)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(
                              'assets/map_page/close_square.svg',
                              color: kPrimaryColor,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          AutoSizeText(
                            'Ride completed!',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          SvgPicture.asset(
                            'assets/close_square.svg',
                            color: kPrimaryColor,
                          ),
                        ],
                      ),
                      SizedBox(height: widget.size.height / (815 / 30)),
                      EndTripDriverContainer(
                          size: widget.size, model: widget.model),
                      SizedBox(height: widget.size.height / (815 / 70)),
                      AutoSizeText(
                        'How was your trip?',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: kTextPrimary),
                      ),
                      SizedBox(height: widget.size.height / (815 / 10)),
                      Container(
                        width: widget.size.width / (375 / 288),
                        child: AutoSizeText(
                          'Help us improve our services and your experience by rating this trip.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1.5,
                              color: kTextSecondaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: widget.size.height / (815 / 16)),
                      RatingBar(
                        allowHalfRating: false,
                        onRatingUpdate: (value) {
                          widget.model.ratingToTrip = value;
                        },
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                          full: Icon(
                            Icons.star,
                            color: kPrimaryColor,
                          ),
                          half: Icon(
                            Icons.star_half,
                            color: kPrimaryColor,
                          ),
                          empty: Icon(
                            Icons.star_border_purple500_outlined,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: widget.size.height / (815 / 48),
                      ),
                      AutoSizeText(
                        'Tip',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: widget.size.height / (815 / 16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          4,
                          (index) => InkWell(
                            onTap: () {
                              widget.model.tipSelectedIndex = index;
                              setState(() {});
                            },
                            child: Container(
                              width: widget.size.width / (375 / 80),
                              height: widget.size.height / (815 / 37),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: widget.model.tipSelectedIndex == index
                                      ? kPrimaryColor
                                      : Colors.transparent,
                                  border: Border.all(
                                      width: 1, color: kPrimaryColor)),
                              child: Center(
                                child: AutoSizeText(
                                  '${index * 5} %',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          widget.model.tipSelectedIndex == index
                                              ? Colors.white
                                              : kPrimaryColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: widget.size.height / (815 / 48),
                      ),
                      Container(
                        height: widget.size.height / (815 / 65),
                        width: widget.size.width / (375 / 343),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xffF4F7FA),
                        ),
                        child: Center(
                          child: TextField(
                            controller: _controller,
                            style: TextStyle(fontSize: 15, color: kTextPrimary),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: widget.size.width / (375 / 16)),
                                border: InputBorder.none,
                                hintText: 'Write your comment',
                                hintStyle: TextStyle(
                                    fontSize: 15, color: kTextSecondaryColor)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: widget.size.height / (815 / 60),
                      ),
                      PrimaryButton(
                        size: widget.size,
                        textColor: Colors.white,
                        title: 'Done',
                        color: kPrimaryColor,
                        function: () {},
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EndTripDriverContainer extends StatelessWidget {
  const EndTripDriverContainer({
    Key key,
    @required this.size,
    @required this.model,
  }) : super(key: key);

  final Size size;
  final MapPageViewModel model;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: size.width / (375 / 32),
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: size.width / (375 / 30),
                    backgroundImage:
                        NetworkImage(model.driver.profilePicAdress),
                  ),
                ),
                SizedBox(
                  width: size.width / (375 / 16),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      'Your driver is ${model.driver.name}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: size.height / (815 / 4),
                    ),
                    RatingBarIndicator(
                        itemSize: size.width / (375 / 15),
                        rating: model.driver.rating,
                        itemBuilder: (context, index) {
                          return Icon(
                            Icons.star,
                            color: Colors.white,
                          );
                        }),
                    SizedBox(
                      height: size.height / (815 / 5),
                    ),
                    Row(
                      children: [
                        //TODO Change to driver vehicle
                        SvgPicture.asset(
                            true ? 'assets/moped.svg' : 'assets/moto.svg'),
                        SizedBox(
                          width: size.width / (375 / 8),
                        ),
                        AutoSizeText(
                          '${model.driver.vehicleNumberId}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            AutoSizeText('5 azn',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white))
          ],
        ),
      ),
    );
  }
}

class DriverIsComing extends ViewModelWidget<MapPageViewModel> {
  const DriverIsComing({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, model) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            height: model.detailsOpened ? size.height / 1.4 : size.height / 2.3,
            color: Colors.white,
            duration: Duration(milliseconds: 300),
            child: Column(
              children: [
                Container(
                  constraints: BoxConstraints(
                    minHeight: size.height / (815 / 110),
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height / (815 / 16),
                      horizontal: size.width / (375 / 16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: size.width / (375 / 32),
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: size.width / (375 / 30),
                                backgroundImage:
                                    NetworkImage(model.driver.profilePicAdress),
                              ),
                            ),
                            SizedBox(
                              width: size.width / (375 / 16),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  'Your driver is ${model.driver.name}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: size.height / (815 / 4),
                                ),
                                RatingBarIndicator(
                                    itemSize: size.width / (375 / 15),
                                    rating: model.driver.rating,
                                    itemBuilder: (context, index) {
                                      return Icon(
                                        Icons.star,
                                        color: Colors.white,
                                      );
                                    }),
                                SizedBox(
                                  height: size.height / (815 / 5),
                                ),
                                Row(
                                  children: [
                                    //TODO Change to driver vehicle
                                    SvgPicture.asset(true
                                        ? 'assets/moped.svg'
                                        : 'assets/moto.svg'),
                                    SizedBox(
                                      width: size.width / (375 / 8),
                                    ),
                                    AutoSizeText(
                                      '${model.driver.vehicleNumberId}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                AutoSizeText(
                                  '${model.timeToArrivetToYouLeft} min',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: size.width / (375 / 10),
                                ),
                                SvgPicture.asset(
                                    'assets/map_page/time_square.svg',
                                    color: Colors.white)
                              ],
                            ),
                            SizedBox(
                              height: size.height / (815 / 17),
                            ),
                            InkWell(
                              onTap: () => launch(model.driver.number),
                              child: Container(
                                  width: size.width / (375 / 88),
                                  height: size.height / (815 / 36),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xff37A9FF),
                                  ),
                                  child: Center(
                                    child: AutoSizeText(
                                      'Call',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: size.width / (375 / 16)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height / (815 / 16),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          'Your trip',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: kTextPrimary),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElementSelectAdress(
                                  size: size, color: kPrimaryColor),
                              for (var i = 0; i < model.adresses.length; i++)
                                ElementSelectAdress2(
                                    size: size,
                                    color: kPrimaryColor,
                                    last: i != model.adresses.length - 1)
                            ],
                          ),
                          SizedBox(
                            width: size.width / (375 / 14),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: size.height / (815 / 13)),
                                    child: AutoSizeText(
                                      '${model.firstAdress.nameOfPlace}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: kPrimaryColor),
                                    ),
                                  )
                                ],
                              ),
                              for (var i = 0; i < model.adresses.length; i++)
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: size.height / (815 / 40)),
                                  child: Column(
                                    children: [
                                      AutoSizeText(
                                        '${model.adresses[i].nameOfPlace}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: kPrimaryColor),
                                      )
                                    ],
                                  ),
                                ),

                              // return Text('a');
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height / (815 / 16),
                      ),
                      ChangeDestination(size: size),
                      SizedBox(
                        height: size.height / (815 / 8),
                      ),
                      TripInfoContainer(size: size),
                      SizedBox(
                        height: size.height / (815 / 8),
                      ),
                      PaymentType(size: size),
                      SizedBox(
                        height: size.height / (815 / 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: size.width,
            height: size.height / (815 / 100),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width / (375 / 185),
                  child: PrimaryButton(
                      function: () => model.status = StatusOfMap.YouAreOnWay,
                      color: kTextSecondaryColor,
                      size: size,
                      title: 'Cancel',
                      textColor: Colors.white),
                ),
                Container(
                  width: size.width / (375 / 185),
                  child: PrimaryButton(
                      function: () =>
                          model.detailsOpened = !model.detailsOpened,
                      color: kPrimaryColor,
                      size: size,
                      title: model.detailsOpened ? 'Close' : 'Details',
                      textColor: Colors.white),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class PrimaryButtonSmall extends StatelessWidget {
  const PrimaryButtonSmall({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width / (375 / 167),
        height: size.height / (815 / 65),
        decoration: BoxDecoration(
          color: kTextSecondaryColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: AutoSizeText('Cancel',
              style: TextStyle(fontSize: 20, color: Colors.white)),
        ));
  }
}

class SelectTripOptions extends ViewModelWidget<MapPageViewModel> {
  const SelectTripOptions({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, model) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: size.height / (815 / 480),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: size.height / (815 / 110),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height / (815 / 16),
                  horizontal: size.width / (375 / 16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElementSelectAdress(
                              color: Colors.white,
                              size: size,
                            ),
                            for (var i = 0; i < model.adresses.length; i++)
                              ElementSelectAdress2(
                                  color: Colors.white,
                                  size: size,
                                  last: i != model.adresses.length - 1)
                          ],
                        ),
                        SizedBox(
                          width: size.width / (375 / 14),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: size.height / (815 / 13)),
                                  child: AutoSizeText(
                                    '${model.firstAdress.nameOfPlace}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            for (var i = 0; i < model.adresses.length; i++)
                              Padding(
                                padding: EdgeInsets.only(
                                    top: size.height / (815 / 40)),
                                child: Column(
                                  children: [
                                    AutoSizeText(
                                      '${model.adresses[i].nameOfPlace}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),

                            // return Text('a');
                          ],
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        model.status = StatusOfMap.Start;
                      },
                      child:
                          SvgPicture.asset('assets/map_page/close_square.svg'),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height / (815 / 15),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: size.width / (375 / 16)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MotoOrMopedContainer(
                          onTap: () {
                            model.selectedVehicle = Vehicle.Moped;
                            HapticFeedback.mediumImpact();
                          },
                          size: size,
                          icon: 'assets/moped.svg',
                          selected: model.selectedVehicle == Vehicle.Moped,
                          text: 'Moped'),
                      MotoOrMopedContainer(
                          onTap: () {
                            model.selectedVehicle = Vehicle.Motorcycle;
                            HapticFeedback.mediumImpact();
                          },
                          size: size,
                          icon: 'assets/moto.svg',
                          selected: model.selectedVehicle == Vehicle.Motorcycle,
                          text: 'Motorcycle'),
                    ],
                  ),
                  SizedBox(
                    height: size.height / (815 / 16),
                  ),
                  TripInfoContainer(size: size),
                  SizedBox(
                    height: size.height / (815 / 8),
                  ),
                  PaymentType(size: size),
                  SizedBox(
                    height: size.height / (815 / 16),
                  ),
                  PrimaryButton(
                    size: size,
                    title: 'Apply',
                    color: kPrimaryColor,
                    textColor: Colors.white,
                    function: () {
                      model.status = StatusOfMap.SearchingDriver;
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PaymentType extends ViewModelWidget<MapPageViewModel> {
  const PaymentType({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, model) {
    return Container(
        width: double.infinity,
        height: size.height / (815 / 65),
        decoration: BoxDecoration(
          color: kF8F9,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width / (375 / 16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                'Payment method',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: kTextPrimary),
              ),
              Row(
                children: [
                  DropdownButton<String>(
                    style: TextStyle(
                        color: kTextPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                    value: model.paymentType,
                    items: <String>['Cash', 'Card'].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      model.paymentType = value;
                    },
                  )
                ],
              )
            ],
          ),
        ));
  }
}

class ChangeDestination extends ViewModelWidget<MapPageViewModel> {
  const ChangeDestination({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, model) {
    return Container(
        width: double.infinity,
        height: size.height / (815 / 65),
        decoration: BoxDecoration(
          color: kF8F9,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width / (375 / 16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/map_page/Location.svg',
                  color: kPrimaryColor),
              SizedBox(
                width: size.width / (375 / 10),
              ),
              AutoSizeText('Change destination',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: kPrimaryColor))
            ],
          ),
        ));
  }
}

class TripInfoContainer extends ViewModelWidget<MapPageViewModel> {
  const TripInfoContainer({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, model) {
    return Container(
        width: double.infinity,
        height: size.height / (815 / 65),
        decoration: BoxDecoration(
          color: kF8F9,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width / (375 / 16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DetailsAboutTripRow(
                size: size,
                icon: 'assets/map_page/Location.svg',
                text: '${model.distanceOfTrip} km',
              ),
              DetailsAboutTripRow(
                size: size,
                icon: 'assets/map_page/time_square.svg',
                text: '${model.timeOfTrip} min',
              ),
              DetailsAboutTripRow(
                size: size,
                icon: 'assets/map_page/rectangle_money.svg',
                text: '${model.costOfTrip} AZN',
              ),
            ],
          ),
        ));
  }
}

class DetailsAboutTripRow extends StatelessWidget {
  const DetailsAboutTripRow({
    Key key,
    @required this.size,
    this.icon,
    this.text,
  }) : super(key: key);

  final Size size;
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          '$icon',
          color: kTextSecondaryColor,
        ),
        SizedBox(
          width: size.width / (375 / 8),
        ),
        AutoSizeText(
          '$text',
          style: TextStyle(
              fontSize: 15, color: kTextPrimary, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}

class MotoOrMopedContainer extends StatelessWidget {
  const MotoOrMopedContainer({
    Key key,
    @required this.size,
    this.icon,
    this.selected,
    this.text,
    this.onTap,
  }) : super(key: key);

  final Size size;
  final String icon;
  final bool selected;
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: size.width / (375 / 167),
        height: size.height / (815 / 76),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? kPrimaryColor : Color(0xffA6ABAF),
            width: 1,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width / (375 / 40),
                height: size.height / (815 / 40),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected ? kPrimaryColor : Color(0xffA6ABAF)),
                child: Center(
                  child: SvgPicture.asset(
                    '$icon',
                    width: size.width / (375 / 24),
                    height: size.height / (815 / 16),
                  ),
                ),
              ),
              SizedBox(width: size.width / (375 / 10)),
              AutoSizeText(
                '$text',
                style: TextStyle(
                    fontSize: selected ? 16 : 15,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected ? kTextPrimary : kTextPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CancelOrderMapPage extends ViewModelWidget<MapPageViewModel> {
  const CancelOrderMapPage({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, model) {
    return Positioned(
      left: size.width / (375 / 16),
      right: size.width / (375 / 16),
      bottom: size.height / (815 / 60),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width / (375 / 0),
        ),
        child: PrimaryButton(
          size: size,
          function: () {
            model.status = StatusOfMap.DriverComes;
          },
          color: kPrimaryColor,
          title: 'Cancel order search',
          textColor: Colors.white,
        ),
      ),
    );
  }
}

class StartMapBottom extends ViewModelWidget<MapPageViewModel> {
  const StartMapBottom({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, model) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: size.width / (375 / 16)),
                    child: InkWell(
                      onTap: () {
                        model.animateToMyPosition();
                      },
                      child: Container(
                        width: size.width / (375 / 48),
                        height: size.width / (375 / 48),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child:
                              SvgPicture.asset('assets/map_page/Discovery.svg'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height / (815 / 16),
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  // Navigator.of(context)
                  //     .push(CupertinoPageRoute(
                  //   fullscreenDialog: true,
                  //   builder: (BuildContext context) {
                  //     return SelectAdressView();
                  //   },
                  // ))
                  //     .then((value) async {
                  //   if (value[0] == 'OK') {
                  //     try {
                  //       await model.animateToMyPosition();
                  //       model.status = StatusOfMap.ApplyYourTrip;
                  //       model.firstAdress = value[1];
                  //       model.adresses = value[2];

                  //       print('Done');
                  //     } catch (e) {
                  //       print(e);
                  //     }
                  //   }
                  // });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => YourTripEnded(
                        size: size,
                        model: model,
                      ),
                    ),
                  );
                },
                child: WhereToGo(size: size),
              ),
            ),
            SizedBox(
              height: size.height / (815 / 24),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MapPageBigMapPage(
                    size: size,
                    iconPath: 'assets/map_page/Home.svg',
                    title: 'Home',
                    function: () {}),
                MapPageBigMapPage(
                    size: size,
                    iconPath: 'assets/map_page/Work.svg',
                    title: 'Work',
                    function: () {}),
                MapPageBigMapPage(
                    size: size,
                    iconPath: 'assets/map_page/Location.svg',
                    title: 'Last',
                    function: () {}),
              ],
            ),
            SizedBox(
              height: size.height / (815 / 50),
            ),
          ],
        ),
      ),
    );
  }
}

class WhereToGo extends StatelessWidget {
  const WhereToGo({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / (375 / 343),
      height: size.height / (815 / 65),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: size.width / (375 / 18),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/map_page/Search.svg',
              color: kPrimaryColor,
            ),
            SizedBox(
              width: size.width / (375 / 19),
            ),
            AutoSizeText(
              'Where to?',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: kTextPrimary),
            )
          ],
        ),
      ),
    );
  }
}

class Overlay {
  static Widget show(BuildContext context) {
    final spinkit = SpinKitPulse(
      color: Color(0xffB5CFE3).withOpacity(0.7),
      size: 150.0,
    );
    final spinkit2 = SpinKitPulse(
      color: Color(0xff75AED9).withOpacity(0.7),
      size: 100.0,
    );

    return Container(
      child: Stack(
        children: [
          spinkit,
          spinkit2,
        ],
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white.withOpacity(0),
    );
  }
}

class MapPageBigMapPage extends StatelessWidget {
  Size size;
  String title;
  String iconPath;
  Function function;
  MapPageBigMapPage({this.size, this.function, this.iconPath, this.title});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => function(),
      child: Container(
        width: size.width / (375 / 96),
        height: size.width / (375 / 96),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(2, 2),
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width / (375 / 40),
              height: size.width / (375 / 40),
              decoration:
                  BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
              child: Center(
                child: SvgPicture.asset('${iconPath}'),
              ),
            ),
            SizedBox(
              height: size.height / (815 / 6),
            ),
            AutoSizeText(
              '$title',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
