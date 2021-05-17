import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/intro/text_component.dart';
import 'package:unic_app/components/intro/upper_part.dart';
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
                  child: IntroUpperPart(size: size),
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
                              IntroTextComponent(
                                size: size,
                                text: model.text1,
                                title: model.title1,
                              ),
                              IntroTextComponent(
                                size: size,
                                text: model.text2,
                                title: model.title2,
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
