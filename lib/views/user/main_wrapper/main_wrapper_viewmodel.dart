import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:unic_app/views/user/map_page/map_page_view.dart';
import 'package:unic_app/views/user/profile_page/profile_page_view.dart';

class MainWrapperViewModel extends ChangeNotifier {
  KFDrawerController _drawerController;
  KFDrawerController get drawerController => _drawerController;
  set drawerController(controller) {
    this._drawerController = controller;
  }

  List _pages = [
    MapPageView(),
    UserProfilePageView(),
    MapPageView(),
    UserProfilePageView(),
    MapPageView(),
    // UserProfilePageView(),
  ];

  // int index = 0;

  List get pages => this._pages;
}
