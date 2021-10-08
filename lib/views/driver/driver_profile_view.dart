import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/arrow_back_button.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/driver_profile_top/driver_profile_top_component.dart';
import 'package:unic_app/components/driver_profile_top/driver_textfield.dart';

import 'package:unic_app/components/profile%20page/profile_page_comp.dart';
import 'package:unic_app/views/driver/driver_profile_viewmodel.dart';
import 'package:unic_app/views/user/profile_page/profile_page_viewmodel.dart';

class DriverProfileView extends KFDrawerContent {
  @override
  _DriverProfileViewState createState() => _DriverProfileViewState();
}

class _DriverProfileViewState extends State<DriverProfileView> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ViewModelBuilder<DriverProfileViewModel>.reactive(
        builder: (context, DriverProfileViewModel model, child) => Scaffold(
              backgroundColor: Colors.white,
              body: FutureBuilder(
                  future: model.driverProfileFuture,
                  builder: (context, snapshot) {
                    // print("FULLNAME ${model.user.fullname}");
                    if (snapshot.hasData) {
                      return SafeArea(
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Stack(
                                  overflow: Overflow.visible,
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      height: size.height / (815 / 500),
                                      child: Column(
                                        children: [
                                          Container(
                                            color: kPrimaryColor,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: size.width / (375 / 16),
                                                  right:
                                                      size.width / (375 / 16),
                                                  top: size.height / (812 / 40),
                                                  bottom: size.height /
                                                      (812 / 150)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  ArrowBackBtnCenterTextAndSave(
                                                      onSave: () {
                                                        model.sendUserData();
                                                        // model.addFullname();
                                                      },
                                                      text: 'My profile'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    PositionedWithCircleAvatarDriver(
                                        size: size),
                                  ],
                                ),
                                Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width / (375 / 16)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              'Full name',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: kTextPrimary),
                                            ),
                                            SizedBox(
                                              height: size.height / (815 / 10),
                                            ),
                                            EditTextFieldDriver(
                                                initialValue:
                                                    model.user.fullname ?? '',
                                                onChanged: (val) {
                                                  model.user.fullname = val;
                                                },
                                                isNumber: false,
                                                size: size,
                                                hintTitle: '',
                                                hintText: ''),
                                          ],
                                        ),
                                        SizedBox(
                                          height: size.height / (815 / 15),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              'E-mail',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: kTextPrimary),
                                            ),
                                            SizedBox(
                                              height: size.height / (815 / 10),
                                            ),
                                            EditTextFieldDriver(
                                                initialValue:
                                                    model.user.email ?? '',
                                                onChanged: (val) {
                                                  model.user.email = val;
                                                },
                                                isNumber: false,
                                                size: size,
                                                hintTitle: '',
                                                hintText: ''),
                                          ],
                                        ),
                                        SizedBox(
                                          height: size.height / (815 / 15),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              'Phone number',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: kTextPrimary),
                                            ),
                                            SizedBox(
                                              height: size.height / (815 / 10),
                                            ),
                                            EditTextFieldDriver(
                                                enabled: false,
                                                initialValue:
                                                    model.user.number ?? '',
                                                onChanged: (val) {
                                                  model.user.number = val;
                                                },
                                                isNumber: true,
                                                size: size,
                                                hintTitle: '',
                                                hintText: ''),
                                          ],
                                        ),
                                        SizedBox(
                                            height: size.height / (815 / 30)),
                                        Divider(
                                          thickness: 0.7,
                                          height: 1,
                                          color: Color(0xffEBEDEE),
                                        ),
                                        SizedBox(
                                            height: size.height / (815 / 32)),
                                        boldTextBuilder('Language'),
                                        SizedBox(
                                            height: size.height / (812 / 16)),
                                        LanguageRow(
                                            language: '${model.language}'),
                                        SizedBox(
                                            height: size.height / (815 / 100)),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
        viewModelBuilder: () => DriverProfileViewModel());
  }

  AutoSizeText boldTextBuilder(String text) {
    return AutoSizeText(
      '$text',
      style: TextStyle(
          color: kTextPrimary, fontSize: 16, fontWeight: FontWeight.w600),
    );
  }
}

class ArrowBackBtnCenterTextAndSave extends StatelessWidget {
  ArrowBackBtnCenterTextAndSave({
    Key key,
    @required this.onSave,
    @required this.text,
  }) : super(key: key);

  final String text;
  final Function onSave;

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
        GestureDetector(
          onTap: () => onSave(),
          child: Text(
            'Save',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
