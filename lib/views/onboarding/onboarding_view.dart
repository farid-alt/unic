import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/primary_button.dart';
import 'package:unic_app/views/onboarding/onboarding_viewmodel.dart';
import 'package:auto_size_text/auto_size_text.dart';

class OnboardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder.reactive(
        builder: ((context, OnboardingViewModel model, child) {
          return Scaffold(
            body: Column(
              children: [
                Flexible(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    color: kPrimaryColor,
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height / (812 / 70),
                        ),
                        AutoSizeText(
                          'Welcome,',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        AutoSizeText(
                          'Our Community!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: size.height / (812 / 44),
                        ),
                        Image.asset(
                          'assets/onboarding/main_image.png',
                          width: size.width / (375 / 343),
                          height: size.height / (815 / 300),
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          height: size.height / (815 / 140),
                          width: size.width,
                          child: PageView(
                            controller: model.pageController,
                            onPageChanged: (value) {
                              model.index = value;
                            },
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: size.height / (815 / 56),
                                  ),
                                  AutoSizeText(
                                    'Title here',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: kTextPrimary),
                                  ),
                                  SizedBox(
                                    height: size.height / (815 / 16),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width / (375 / 16),
                                    ),
                                    child: AutoSizeText(
                                      'Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff565C61)),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: size.height / (815 / 56),
                                  ),
                                  AutoSizeText(
                                    'Title here',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: kTextPrimary),
                                  ),
                                  SizedBox(
                                    height: size.height / (815 / 16),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width / (375 / 16),
                                    ),
                                    child: AutoSizeText(
                                      'Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet Lorem ipsum.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff565C61)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height / (815 / 32),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                  color: model.index == 0
                                      ? kPrimaryColor
                                      : Color(0xffCED3D8),
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                  color: model.index == 1
                                      ? kPrimaryColor
                                      : Color(0xffCED3D8),
                                  shape: BoxShape.circle),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height / (815 / 32),
                        ),
                        PrimaryButton(
                          function: () {
                            if (model.index == 0) {
                              model.pageController.animateToPage(1,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.linear);
                            }
                          },
                          color: kPrimaryColor,
                          textColor: Colors.white,
                          title: model.index == 0 ? 'Next' : 'Get started',
                          size: size,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        viewModelBuilder: () => OnboardingViewModel());
  }
}
