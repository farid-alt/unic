import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/drawer/drawerItem.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/translates.dart';
import 'package:unic_app/views/driver/driver_mainwrapper/driver_mainwrapper_viewmodel.dart';
import 'package:unic_app/views/driver/driver_profile_view.dart';
import 'package:unic_app/views/driver_map/driver_map_view.dart';
import 'package:unic_app/views/user/code_page/code_page_view.dart';
import 'package:unic_app/views/user/main_wrapper/main_wrapper_view.dart';
import 'package:unic_app/views/user/main_wrapper/main_wrapper_viewmodel.dart';
import 'package:unic_app/views/user/map_page/map_page_view.dart';
import 'package:unic_app/views/user/map_page/map_page_viewmodel.dart';
import 'package:unic_app/views/user/payments/payments_view.dart';
import 'package:unic_app/views/user/privacy%20and%20policy/privacy.dart';
import 'package:unic_app/views/user/profile_page/profile_page_view.dart';
import 'package:unic_app/views/user/profile_page/profile_page_viewmodel.dart';
import 'package:unic_app/views/user/promotions_page/promotions_view.dart';
import 'package:unic_app/views/user/ride_history/ride_history_view.dart';
import 'package:unic_app/views/user/support/support_view.dart';
import 'package:unic_app/views/user/terms%20and%20conditions/terms_view.dart';

class DriverMainWrapperView extends StatefulWidget {
  int index = 0;
  DriverMainWrapperView({this.index});
  @override
  _DriverMainWrapperViewState createState() => _DriverMainWrapperViewState();
}

class _DriverMainWrapperViewState extends State<DriverMainWrapperView> {
  KFDrawerController _drawerController;
  // KFDrawerController get drawerController => _drawerController;
  // set drawerController(controller) {
  //   this._drawerController = controller;
  // }

  // List pages = [
  //   MapPageView(),
  //   UserProfilePageView(),
  //   // MapPageView(),
  //   // UserProfilePageView(),
  //   // MapPageView(),
  //   // UserProfilePageView(),
  // ];

  // int index = 0;

  // List get pages => this._pages;

  @override
  void initState() {
    _drawerController = KFDrawerController(
      initialPage: DriverMapView(),
      items: [
        // KFDrawerItem.initWithPage(
        //   text: AutoSizeText(
        //     'Payments',
        //     style: TextStyle(
        //         fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
        //   ),
        //   icon: SvgPicture.asset(
        //     'assets/user_drawer/Wallet.svg',
        //   ),
        //   page: MapPageView(),
        //   onPressed: () {},
        // ),
        // KFDrawerItem.initWithPage(
        //   text: AutoSizeText(
        //     'Payments',
        //     style: TextStyle(
        //         fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
        //   ),
        //   icon: SvgPicture.asset(
        //     'assets/user_drawer/Wallet.svg',
        //   ),
        //   page: UserProfilePageView(),
        //   onPressed: () {},
        // )
        // buildDrawerItem(
        //   title: 'Payments',
        //   icon: 'Wallet.svg',
        //   page: PaymentsView(),
        //   function: () => Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => PaymentsView())),
        // ),
        buildDrawerItem(
          title: 'Promotions',
          icon: 'Discount.svg',
          page: PromotionsView(),
          function: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => PromotionsView())),
        ),
        buildDrawerItem(
          title: 'Ride history',
          icon: 'Calendar.svg',
          page: RideHistoryView(),
          function: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RideHistoryView(
                        driver: true,
                      ))),
        ),
        buildDrawerItem(
          title: 'Support',
          icon: 'Message.svg',
          page: SupportView(),
          function: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SupportView(
                        driver: true,
                      ))),
        ),
        buildDrawerItem(
          title: 'Terms & Conditions',
          icon: 'Document.svg',
          page: TermsPage(),
          function: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => TermsPage())),
        ),
        buildDrawerItem(
          title: 'Privacy & Policy',
          icon: 'Password.svg',
          page: PrivacyPage(),
          function: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => PrivacyPage())),
        ),
        buildDrawerItem(
            title: 'Logout',
            icon: 'Logout.svg',
            page: PrivacyPage(),
            function: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => CodePageView()),
                  (Route<dynamic> route) => false);
            }),
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('here3');
    return ViewModelBuilder<DriverMainWrapperViewModel>.reactive(
        builder: (context, DriverMainWrapperViewModel model, child) {
          return Scaffold(
              backgroundColor: kPrimaryColor,
              body: KFDrawer(
                animationDuration: Duration(milliseconds: 200),
                // menuPadding:
                //     EdgeInsets.only(left: 16.width, bottom: 24.height),
                controller: _drawerController,
                header: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      // padding: EdgeInsets.symmetric(horizontal: 16.0.width),
                      // width: MediaQuery.of(context).size.width * 0.5,
                      // height: 260.height,
                      child: Row(
                    children: [
                      SizedBox(
                        width: size.width / (375 / 16),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DriverProfileView()))
                            .then((value) {
                          model.getUser = model.getUserApi();
                        }),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: size.width / (375 / 27),
                              backgroundImage: NetworkImage(
                                  'https://unikeco.az${model.user.profilePicAdress}'),
                            ),
                            SizedBox(
                              width: size.width / (375 / 16),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  '${model.user.name}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: size.height / (815 / 4),
                                ),
                                AutoSizeText(
                                  '${kMenuTranslates['edit_profile'][LANGUAGE]}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
                footer: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainWrapperView())),
                    child: Container(
                      width: size.width / (375 / 213),
                      height: size.height / (815 / 60),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width / (375 / 16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              'Become a customer'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: kTextPrimary),
                            ),
                            Icon(Icons.arrow_forward,
                                size: size.width / (375 / 18)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        },
        viewModelBuilder: () => DriverMainWrapperViewModel());
  }

  KFDrawerItem buildDrawerItem({title, icon, page, function}) {
    return KFDrawerItem.initWithPage(
      text: AutoSizeText(
        '$title',
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
      ),
      icon: SvgPicture.asset(
        'assets/user_drawer/$icon',
      ),
      page: page,
      onPressed: () => function(),
    );
  }
}
