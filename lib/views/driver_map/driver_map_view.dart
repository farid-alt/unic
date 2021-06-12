import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:location/location.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/primary_button.dart';
import 'package:unic_app/views/driver/driver_profile_viewmodel.dart';
import 'package:unic_app/views/driver_map/driver_map_viewmodel.dart';
import 'package:unic_app/views/trip_ended/trip_ended_view.dart';
import 'package:unic_app/views/user/map_page/map_page_view.dart';
import 'package:unic_app/views/user/map_page/map_page_viewmodel.dart';
import 'package:unic_app/views/user/select_adress/select_adress_view.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverMapView extends KFDrawerContent {
  @override
  _DriverMapViewState createState() => _DriverMapViewState();
}

class _DriverMapViewState extends State<DriverMapView> {
  // final Completer<GoogleMapController> _controller = Completer();
  DragStartDetails startVerticalDragDetails;
  DragUpdateDetails updateVerticalDragDetails;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<DriverMapViewModel>.reactive(
      builder: (context, DriverMapViewModel model, child) => Scaffold(
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
            // if (model.status == StatusOfMap.SearchingDriver)
            //   Overlay.show(context),
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
            model.status == StatusOfMapDriver.WaitinigForTrip
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: size.height / (815 / 120),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: PrimaryButton(
                          function: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DriverYourTripEnded(
                                        model: model,
                                        size: size,
                                      ))),
                          // model.status = StatusOfMapDriver.AcceptTrip,
                          size: size,
                          color: kPrimaryColor,
                          textColor: Colors.white,
                          title: 'Your trip will appear here',
                        ),
                      ),
                    ),
                  )
                : model.status == StatusOfMapDriver.AcceptTrip
                    ? YouAreOnTheRoadToClient(size: size)
                    : model.status == StatusOfMapDriver.SwipeToTakeCustomer
                        ? TakeACustomer(size: size)
                        : model.status == StatusOfMapDriver.SwipeToEndTrip
                            ? YouAreOnRoadEndTrip(size: size)
                            : Text('')
          ],
        ),
      )),
      viewModelBuilder: () => DriverMapViewModel(),
    );
  }
}

class YouAreOnRoadEndTrip extends ViewModelWidget<DriverMapViewModel> {
  YouAreOnRoadEndTrip({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;
  // bool accept = false;
  DragStartDetails startVerticalDragDetails;
  DragUpdateDetails updateVerticalDragDetails;
  @override
  Widget build(BuildContext context, model) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: model.detailsOpened
            ? size.height / (815 / 410)
            : size.height / (815 / 350),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            GestureDetector(
              onVerticalDragStart: (dragDetails) {
                startVerticalDragDetails = dragDetails;
              },
              onVerticalDragUpdate: (dragDetails) {
                updateVerticalDragDetails = dragDetails;
              },
              onVerticalDragEnd: (endDetails) {
                print('a');
                double dx = updateVerticalDragDetails.globalPosition.dx -
                    startVerticalDragDetails.globalPosition.dx;
                double dy = updateVerticalDragDetails.globalPosition.dy -
                    startVerticalDragDetails.globalPosition.dy;
                double velocity = endDetails.primaryVelocity;

                //Convert values to be positive
                if (dx < 0) dx = -dx;
                if (dy < 0) dy = -dy;

                if (velocity < 0) {
                  model.changeDetails = true;
                  print('Up');
                } else {
                  model.changeDetails = false;
                  print('down');
                }
              },
              child: Container(
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
                                  NetworkImage(model.customer.profilePicAdress),
                            ),
                          ),
                          SizedBox(
                            width: size.width / (375 / 16),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                'Your trip is with ${model.customer.name}',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: size.height / (815 / 4),
                              ),
                              Row(
                                children: [
                                  //TODO Change to driver vehicle

                                  AutoSizeText(
                                    '${model.customer.phone}',
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () => launch(model.customer.phone),
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
                          ElementSelectAdress(size: size, color: kPrimaryColor),
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
                  if (model.detailsOpened) TripInfoContainerDriver(size: size),
                  SizedBox(
                    height: size.height / (815 / 16),
                  ),
                  Container(
                    width: size.width,
                    height: 60,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: AutoSizeText(
                            'Swipe to end trip',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        AnimatedPositioned(
                          left: model.endTrip ? 300 : 1,
                          bottom: 0,
                          duration: Duration(milliseconds: 300),
                          child: GestureDetector(
                            // onTap: () => model.status =
                            //     StatusOfMapDriver
                            //         .TripEnded,
                            onPanUpdate: (details) {
                              if (details.delta.dx > 0)
                                model.endTrip = true;
                              // print("Dragging in +X direction");

                              else
                                model.endTrip = false;

                              if (details.delta.dy > 0)
                                print("Dragging in +Y direction");
                              else
                                print("Dragging in -Y direction");
                            },
                            child: Container(
                              margin: EdgeInsets.all(1),
                              width: size.width / (375 / 72),
                              height: 58,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.white),
                              child: Center(
                                child: SvgPicture.asset(
                                    'assets/map_page/arrowRight.svg'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height / (815 / 16),
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

class TripInfoContainerDriver extends ViewModelWidget<DriverMapViewModel> {
  const TripInfoContainerDriver({
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

class TakeACustomer extends ViewModelWidget<DriverMapViewModel> {
  const TakeACustomer({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, model) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: size.height / (815 / 350),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          color: Colors.white,
        ),
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
                                NetworkImage(model.customer.profilePicAdress),
                          ),
                        ),
                        SizedBox(
                          width: size.width / (375 / 16),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'Your trip is with ${model.customer.name}',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: size.height / (815 / 4),
                            ),
                            Row(
                              children: [
                                //TODO Change to driver vehicle

                                AutoSizeText(
                                  '${model.customer.phone}',
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => launch(model.customer.phone),
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
                          ElementSelectAdress(size: size, color: kPrimaryColor),
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
                  Container(
                    width: size.width,
                    height: 60,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: AutoSizeText(
                            'Swipe to start trip',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              model.status = StatusOfMapDriver.SwipeToEndTrip,
                          child: Container(
                            margin: EdgeInsets.all(1),
                            width: size.width / (375 / 72),
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white),
                            child: Center(
                              child: SvgPicture.asset(
                                  'assets/map_page/arrowRight.svg'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height / (815 / 16),
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

class YouAreOnTheRoadToClient extends ViewModelWidget<DriverMapViewModel> {
  const YouAreOnTheRoadToClient({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, model) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: size.height / (815 / 260),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width / (375 / 16),
              vertical: size.height / (815 / 15)),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
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
                      SizedBox(
                        height: size.height / (815 / 10),
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
                    ],
                  ),
                  AutoSizeText('Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffFF4E4E),
                      )),
                ],
              ),
              SizedBox(
                height: size.height / (815 / 18),
              ),
              Container(
                width: size.width,
                height: 60,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: AutoSizeText(
                        'Swipe to accept',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          model.status = StatusOfMapDriver.SwipeToTakeCustomer,
                      child: Container(
                        margin: EdgeInsets.all(1),
                        width: size.width / (375 / 72),
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white),
                        child: Center(
                          child: SvgPicture.asset(
                              'assets/map_page/arrowRight.svg'),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
