import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/back_with_title.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/translates.dart';
import 'package:unic_app/views/user/privacy%20and%20policy/privacy_viewmodel.dart';
import 'package:unic_app/views/user/terms%20and%20conditions/terms_viewmodel.dart';

class PrivacyPage extends KFDrawerContent {
  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<PrivacyViewModel>.nonReactive(
        viewModelBuilder: () => PrivacyViewModel(),
        builder: (context, model, child) => FutureBuilder(
            future: model.futurePrivacy,
            builder: (context, snapshot) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: size.width / (375 / 16)),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height / (812 / 60)),
                        BackWithTitle(
                            size: size,
                            title:
                                '${kMenuTranslates['privacy_policy'][LANGUAGE]}'),
                        SizedBox(height: size.height / (812 / 32)),
                        Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                model.privacy,
                                style: TextStyle(
                                    color: Color(
                                      0xff5D6A75,
                                    ),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width / (375 / 16),
                              vertical: size.height / (812 / 16)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Color(0xffE9F5FF)),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
