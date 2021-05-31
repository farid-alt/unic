import 'dart:async';

import 'package:animator/animator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:location/location.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/views/user/map_page/map_page_viewmodel.dart';
import 'package:unic_app/views/user/profile_page/profile_page_viewmodel.dart';
import 'package:unic_app/views/user/select_adress/select_adress_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_animarker/animation/animarker_controller.dart';
// import 'package:flutter_animarker/animation/bearing_tween.dart';
// import 'package:flutter_animarker/animation/location_tween.dart';
// import 'package:flutter_animarker/animation/proxy_location_animation.dart';
// import 'package:flutter_animarker/core/anilocation_task_description.dart';
// import 'package:flutter_animarker/core/animarker_controller_description.dart';
// import 'package:flutter_animarker/core/i_anilocation_task.dart';
// import 'package:flutter_animarker/core/i_animarker_controller.dart';
// import 'package:flutter_animarker/core/i_interpolation_service.dart';
// import 'package:flutter_animarker/core/i_interpolation_service_optimized.dart';
// import 'package:flutter_animarker/core/i_lat_lng.dart';
// import 'package:flutter_animarker/core/i_location_dispatcher.dart';
// import 'package:flutter_animarker/core/ripple_marker.dart';
// import 'package:flutter_animarker/flutter_map_marker_animation.dart';
// import 'package:flutter_animarker/helpers/extensions.dart';
// import 'package:flutter_animarker/helpers/google_map_helper.dart';
// import 'package:flutter_animarker/helpers/math_util.dart';
// import 'package:flutter_animarker/helpers/spherical_util.dart';
// import 'package:flutter_animarker/infrastructure/anilocation_task_impl.dart';
// import 'package:flutter_animarker/infrastructure/i_location_observable.dart';
// import 'package:flutter_animarker/infrastructure/interpolators/angle_interpolator_impl.dart';
// import 'package:flutter_animarker/infrastructure/interpolators/line_location_interpolator_impl.dart';
// import 'package:flutter_animarker/infrastructure/interpolators/polynomial_location_interpolator_impl.dart';
// import 'package:flutter_animarker/infrastructure/location_dispatcher_impl.dart';
// import 'package:flutter_animarker/models/lat_lng_info.dart';
// import 'package:flutter_animarker/widgets/animarker.dart';

// import 'package:flutter_animarker/flutter_map_marker_animation.dart';
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
                        onMapCreated: (controller) {
                          model.mapController = controller;

                          // _controller.complete(controller);
                        },
                        markers: model.markers.values.toSet(),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(snapshot.data.latitude,
                                snapshot.data.longitude),
                            zoom: 15),
                      );
                    })),
            // Overlay.show(context),
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
            Positioned(
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
                            padding:
                                EdgeInsets.only(right: size.width / (375 / 16)),
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
                                  child: SvgPicture.asset(
                                      'assets/map_page/Discovery.svg'),
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
                          Navigator.of(context).push(CupertinoPageRoute(
                            fullscreenDialog: true,
                            builder: (BuildContext context) {
                              return SelectAdressView();
                            },
                          ));
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
            )
          ],
        ),
      )),
      viewModelBuilder: () => MapPageViewModel(),
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
