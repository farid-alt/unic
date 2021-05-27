import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/arrow_back_button.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/profile%20page/profile_page_comp.dart';
import 'package:unic_app/views/user/profile_page/profile_page_viewmodel.dart';

class UserProfilePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<UserProfilePageViewModel>.reactive(
        builder: (context, UserProfilePageViewModel model, child) => Scaffold(
              backgroundColor: kPrimaryColor,
              body: Stack(children: [
                Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width / (375 / 16),
                            vertical: size.height / (812 / 60)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ArrowBackBtnCenterText(text: 'My profile')
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                        flex: 3,
                        child: Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width / (375 / 16),
                              vertical: size.height / (812 / 128)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              boldTextBuilder('Saved destinations'),
                              SavedDestinationsRow(
                                  size: size,
                                  iconAdress:
                                      'assets/user_profile/icons/houseIcon.svg',
                                  title: 'Home'),
                              Divider(thickness: 0.7),
                              SavedDestinationsRow(
                                  size: size,
                                  iconAdress:
                                      'assets/user_profile/icons/suitcase.svg',
                                  title: 'Work'),
                              boldTextBuilder('Language'),
                              SizedBox(height: size.height / (812 / 16)),
                              LanguageRow(language: '${model.language}'),
                              SizedBox(height: size.height / (812 / 16)),
                              boldTextBuilder('Settings'),
                              SizedBox(height: size.height / (812 / 16)),
                              NotificationSwitchRow(
                                  onTapIcon: () {
                                    print('before ${model.notifSwitchOn}');
                                    model.notifSwitchOn
                                        ? model.notifSwitchOn = false
                                        : model.notifSwitchOn = true;
                                    print('after ${model.notifSwitchOn}');
                                  },
                                  size: size,
                                  svgAdress: model.notifSwitchOn
                                      ? 'assets/user_profile/icons/switch-on.svg'
                                      : 'assets/user_profile/icons/off.svg'), //TODO: switch-off icon
                            ],
                          ),
                        ))
                  ],
                ),
                PositionedWithCircleAvatar(size: size)
              ]),
            ),
        viewModelBuilder: () => UserProfilePageViewModel());
  }

  AutoSizeText boldTextBuilder(String text) {
    return AutoSizeText(
      '$text',
      style: TextStyle(
          color: kTextPrimary, fontSize: 16, fontWeight: FontWeight.w600),
    );
  }
}
