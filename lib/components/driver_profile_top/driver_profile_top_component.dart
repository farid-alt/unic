import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/services/image_picker.dart';
import 'package:unic_app/views/driver/driver_profile_viewmodel.dart';
import 'package:unic_app/views/user/profile_page/profile_page_viewmodel.dart';

class PositionedWithCircleAvatarDriver
    extends ViewModelWidget<DriverProfileViewModel> {
  const PositionedWithCircleAvatarDriver({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context, DriverProfileViewModel model) {
    return Positioned(
        top: size.height / (812 / 150),
        left: size.width / (375 / 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: size.width / (375 / 56),
                backgroundImage: model.localFile != null
                    ? AssetImage(model.localFile.path)
                    : NetworkImage(
                        'https://unikeco.az${model.user.profilePicAdress}')),
            SizedBox(height: size.height / (812 / 10)),
            AutoSizeText('${model.user.fullname}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kTextPrimary)),
            SizedBox(height: size.height / (812 / 6)),
            GestureDetector(
              onTap: () async {
                try {
                  final resultOfImagePicker = await getImage();
                  if (resultOfImagePicker.runtimeType != 'No selected image') {
                    model.localFile = resultOfImagePicker;
                    await model.sendDriverImage();
                    // setState(() {});
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: AutoSizeText('Edit image',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: kTextSecondaryColor)),
            ),
            SizedBox(
              height: size.height / (815 / 24),
            ),
            AutoSizeText(
              'Rating – ${model.user.rating}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kTextSecondaryColor),
            ),
            SizedBox(
              height: size.height / (815 / 20),
            ),
            RatingBarIndicator(
                rating: model.user.rating,
                unratedColor: kPrimaryColor,
                itemBuilder: (context, index) {
                  return model.user.rating > index
                      ? Icon(
                          Icons.star,
                          color: kPrimaryColor,
                        )
                      : Icon(
                          Icons.star_border_outlined,
                          color: kPrimaryColor,
                        );
                }),
            SizedBox(
              height: size.height / (815 / 17),
            ),
            AutoSizeText(
              'Activity – ${model.user.activity}%',
              style: TextStyle(
                  color: kTextSecondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            // LinearPercentIndicator(
            //   width: 170.0,
            //   animation: true,
            //   animationDuration: 1000,
            //   lineHeight: 20.0,
            //   leading: new Text("left content"),
            //   trailing: new Text("right content"),
            //   percent: 0.2,
            //   center: Text("20.0%"),
            //   linearStrokeCap: LinearStrokeCap.butt,
            //   progressColor: Colors.red,
            // ),
          ],
        ));
  }
}
