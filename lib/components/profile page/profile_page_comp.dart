import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/arrow_back_button.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/views/user/profile_page/profile%20edit/profile_edit_view.dart';
import 'package:unic_app/views/user/profile_page/profile_page_viewmodel.dart';

class PositionedWithCircleAvatar
    extends ViewModelWidget<UserProfilePageViewModel> {
  const PositionedWithCircleAvatar({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, UserProfilePageViewModel model) {
    return Positioned(
        top: size.height / (812 / 146),
        left: size.width / (375 / 132),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: size.width / (375 / 56),
              foregroundImage: model.localFile != null
                  ? AssetImage(model.localFile.path)
                  : model.user.profilePicAdress != null
                      ? NetworkImage(
                          'https://unikeco.az${model.user.profilePicAdress}')
                      : NetworkImage(
                          'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png'),
            ),
            SizedBox(height: size.height / (812 / 10)),
            Column(
              children: [
                AutoSizeText('${model.user.fullname}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: kTextPrimary)),
                SizedBox(height: size.height / (812 / 6)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserProfileEditPageView(
                                  model: model,
                                )));
                  },
                  child: AutoSizeText('Edit profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: kTextSecondaryColor)),
                ),
              ],
            ),
          ],
        ));
  }
}

class LanguageRow extends StatelessWidget {
  const LanguageRow({
    Key key,
    @required this.language,
  }) : super(key: key);
  final String language;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText('$language',
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w500)),
        GestureDetector(
            onTap: () {
              //TODO: impllement
            },
            child: Icon(
              Icons.arrow_forward_ios,
              color: kTextSecondaryColor,
              size: 19,
            ))
      ],
    );
  }
}

class NotificationSwitchRow extends StatelessWidget {
  const NotificationSwitchRow({
    Key key,
    @required this.size,
    @required this.svgAdress,
    @required this.onTapIcon,
  }) : super(key: key);

  final Size size;
  final String svgAdress;
  final Function onTapIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AutoSizeText('Notification',
            style: TextStyle(
                color: kTextPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500)),
        GestureDetector(
          onTap: onTapIcon,
          child: SvgPicture.asset(
            '$svgAdress',
            height: 30,
            width: 40,
          ),
        )
      ],
    );
  }
}

class SavedDestinationsRow extends StatelessWidget {
  const SavedDestinationsRow({
    Key key,
    @required this.size,
    @required this.title,
    @required this.iconAdress,
  }) : super(key: key);

  final Size size;
  final String title;
  final String iconAdress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height / (812 / 16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset('$iconAdress',
                  height: size.height / (812 / 17),
                  width: size.width / (375 / 17)),
              SizedBox(width: size.width / (375 / 12)),
              AutoSizeText(
                '$title',
                style: TextStyle(
                    color: kTextPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          GestureDetector(
              onTap: () {
                //TODO: implement action
              },
              child: Icon(
                Icons.arrow_forward_ios,
                color: kTextSecondaryColor,
                size: 19,
              ))
        ],
      ),
    );
  }
}

class ArrowBackBtnCenterText extends StatelessWidget {
  const ArrowBackBtnCenterText({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: ArrowBackBtn(),
        ),
        AutoSizeText(
          '${text}',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        Text('321265', style: TextStyle(color: Colors.transparent)),
      ],
    );
  }
}
