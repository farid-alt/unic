import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/views/user/map_page/map_page_viewmodel.dart';
import 'package:unic_app/views/user/profile_page/profile_page_viewmodel.dart';
import 'package:unic_app/views/user/select_adress/select_adress_view.dart';

class MapPageView extends KFDrawerContent {
  @override
  _MapPageViewState createState() => _MapPageViewState();
}

class _MapPageViewState extends State<MapPageView> {
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
              child: GoogleMap(
                myLocationButtonEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(40, 50),
                ),
              ),
            ),
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
                        child: Container(
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
                        ),
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
