// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:kf_drawer/kf_drawer.dart';
// import 'package:stacked/stacked.dart';
// import 'package:unic_app/views/user/main_wrapper/main_wrapper_viewmodel.dart';

// class DrawerItem extends ViewModelWidget<MainWrapperViewModel> {
//   Function function;
//   String title;
//   String iconPath;
//   int index;
//   DrawerItem({this.function, this.iconPath, this.title, this.index});

//   @override
//   Widget build(BuildContext context, model) {
//     return KFDrawerItem.initWithPage(
//       text: AutoSizeText(
//         '$title',
//         style: TextStyle(
//             fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
//       ),
//       icon: SvgPicture.asset(
//         'assets/user_drawer/$iconPath',
//       ),
//       page: model.pages[index],
//       onPressed: () {},
//     );
//   }
// }
