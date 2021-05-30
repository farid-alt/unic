import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/back_with_title.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/views/user/faq/faq_viewmodel.dart';

class FaqView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool whatIsPressed = false;
    bool contactPressed = false;
    bool pricesPressed = false;
    bool safetyPressed = false;

    return ViewModelBuilder<FaqViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BackWithTitle(size: size, title: 'faq'.toUpperCase()),
                SizedBox(height: size.height / (812 / 32)),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText('What is UNIK?',
                              style: TextStyle(
                                  color: kTextPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                          GestureDetector(
                            onTap: () {
                              whatIsPressed = !whatIsPressed;
                              model.justNotify();
                            },
                            child: SvgPicture.asset(
                                whatIsPressed
                                    ? 'assets/up_arrow.svg'
                                    : 'assets/down_arrow.svg',
                                height: size.height / (812 / 10),
                                width: size.width / (375 / 8)),
                          )
                        ],
                      ),
                      if (whatIsPressed)
                        Padding(
                          padding:
                              EdgeInsets.only(top: size.height / (812 / 16)),
                          child: AutoSizeText(
                            model.whatIsText,
                            style: TextStyle(
                                color: kTextSecondaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                    ],
                  ),
                  height: size.height / (812 / (whatIsPressed ? 191 : 60)),
                  padding: EdgeInsets.symmetric(
                      vertical: size.height / (812 / 16),
                      horizontal: size.width / (375 / 16)),
                  decoration: BoxDecoration(
                      color: Color(0xffE9F5FF),
                      borderRadius: BorderRadius.circular(15)),
                ),
                SizedBox(height: size.height / (812 / 16)),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText('How to contact us',
                              style: TextStyle(
                                  color: kTextPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                          GestureDetector(
                            onTap: () {
                              contactPressed = !contactPressed;
                              model.justNotify();
                            },
                            child: SvgPicture.asset(
                                contactPressed
                                    ? 'assets/up_arrow.svg'
                                    : 'assets/down_arrow.svg',
                                height: size.height / (812 / 10),
                                width: size.width / (375 / 8)),
                          )
                        ],
                      ),
                      if (contactPressed)
                        Padding(
                          padding:
                              EdgeInsets.only(top: size.height / (812 / 16)),
                          child: AutoSizeText(
                            model.whatIsText,
                            style: TextStyle(
                                color: kTextSecondaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                    ],
                  ),
                  height: size.height / (812 / (contactPressed ? 191 : 60)),
                  padding: EdgeInsets.symmetric(
                      vertical: size.height / (812 / 16),
                      horizontal: size.width / (375 / 16)),
                  decoration: BoxDecoration(
                      color: Color(0xffE9F5FF),
                      borderRadius: BorderRadius.circular(15)),
                ),
                SizedBox(height: size.height / (812 / 16)),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText('Prices',
                              style: TextStyle(
                                  color: kTextPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                          GestureDetector(
                            onTap: () {
                              pricesPressed = !pricesPressed;
                              model.justNotify();
                            },
                            child: SvgPicture.asset(
                                pricesPressed
                                    ? 'assets/up_arrow.svg'
                                    : 'assets/down_arrow.svg',
                                height: size.height / (812 / 10),
                                width: size.width / (375 / 8)),
                          )
                        ],
                      ),
                      if (pricesPressed)
                        Padding(
                          padding:
                              EdgeInsets.only(top: size.height / (812 / 16)),
                          child: AutoSizeText(
                            model.whatIsText,
                            style: TextStyle(
                                color: kTextSecondaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                    ],
                  ),
                  height: size.height / (812 / (pricesPressed ? 191 : 60)),
                  padding: EdgeInsets.symmetric(
                      vertical: size.height / (812 / 16),
                      horizontal: size.width / (375 / 16)),
                  decoration: BoxDecoration(
                      color: Color(0xffE9F5FF),
                      borderRadius: BorderRadius.circular(15)),
                ),
                SizedBox(height: size.height / (812 / 16)),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText('Safety',
                              style: TextStyle(
                                  color: kTextPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                          GestureDetector(
                            onTap: () {
                              safetyPressed = !safetyPressed;
                              model.justNotify();
                            },
                            child: SvgPicture.asset(
                                safetyPressed
                                    ? 'assets/up_arrow.svg'
                                    : 'assets/down_arrow.svg',
                                height: size.height / (812 / 10),
                                width: size.width / (375 / 8)),
                          )
                        ],
                      ),
                      if (safetyPressed)
                        Padding(
                          padding:
                              EdgeInsets.only(top: size.height / (812 / 16)),
                          child: AutoSizeText(
                            model.whatIsText,
                            style: TextStyle(
                                color: kTextSecondaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                    ],
                  ),
                  height: size.height / (812 / (safetyPressed ? 191 : 60)),
                  padding: EdgeInsets.symmetric(
                      vertical: size.height / (812 / 16),
                      horizontal: size.width / (375 / 16)),
                  decoration: BoxDecoration(
                      color: Color(0xffE9F5FF),
                      borderRadius: BorderRadius.circular(15)),
                )
              ],
            ),
            padding: EdgeInsets.symmetric(
                vertical: size.height / (812 / 60),
                horizontal: size.width / (375 / 16)),
          )),
      viewModelBuilder: () => FaqViewModel(),
    );
  }
}
