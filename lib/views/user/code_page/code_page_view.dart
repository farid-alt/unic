import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/arrow_back_button.dart';
import 'package:unic_app/components/code%20page/input_containers.dart';
import 'package:unic_app/components/colors.dart';

import 'package:unic_app/views/user/code_page/code_page_viewmodel.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class CodePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController controller = TextEditingController();
    PhoneNumber _number = PhoneNumber(isoCode: 'AZ');
    final TextEditingController _codeController = TextEditingController();
    final TextEditingController _fullnameController = TextEditingController();

    _codeController.text = '';

    return ViewModelBuilder<CodePageViewModel>.nonReactive(
        builder: (context, CodePageViewModel model, child) {
          return Scaffold(
            backgroundColor: kPrimaryColor,
            resizeToAvoidBottomInset: true,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 15,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width / (375 / 16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height / (812 / 30)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  if (model.index == 0)
                                    Navigator.pop(context);
                                  else {
                                    model.index = -1;
                                    model.pageController.previousPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.linear);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ArrowBackBtn(),
                                )),
                            // GestureDetector(
                            //   onTap: () {
                            //     //TODO: implement cancel button action
                            //   },
                            //   child: AutoSizeText(
                            //     'Cancel',
                            //     style: TextStyle(
                            //         color: Colors.white,
                            //         fontSize: 14,
                            //         fontWeight: FontWeight.w500),
                            //   ),
                            // ),
                          ],
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: size.height / (812 / 45)),
                          width: double.infinity,
                          height: size.height / (812 / 271),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/code_page/mail_image.png'))),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 11,
                  child: PageView(
                      controller: model.pageController,
                      scrollDirection: Axis.horizontal,
                      allowImplicitScrolling: false,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        InputNumberContainer(
                            size: size,
                            number: _number,
                            controller: controller),
                        InputCodeContainer(
                          size: size,
                          fullnameController: _fullnameController,
                        )
                      ]),
                )
              ],
            ),
          );
        },
        viewModelBuilder: () => CodePageViewModel());
  }
}
