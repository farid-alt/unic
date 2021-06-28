import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/primary_button.dart';
import 'package:unic_app/views/user/code_page/code_page_viewmodel.dart';
import 'package:unic_app/views/user/map_page/map_page_view.dart';
import 'package:unic_app/views/user/profile_page/profile%20edit/profile_edit_view.dart';

class InputCodeContainer extends ViewModelWidget<CodePageViewModel> {
  const InputCodeContainer({
    Key key,
    @required this.size,
    @required this.fullnameController,
  }) : super(key: key);

  final Size size;
  final TextEditingController fullnameController;

  @override
  Widget build(BuildContext context, CodePageViewModel model) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.only(
          top: size.height / (812 / 56),
          bottom: size.height / (812 / 34),
          left: size.width / (375 / 16),
          right: size.width / (375 / 16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText(
            'Enter verification code',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: kTextPrimary),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: size.height / (812 / 32), top: size.height / (812 / 8)),
            child: AutoSizeText(
              'A code has been sent to${model.number} via SMS',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: kTextSecondaryColor),
            ),
          ),
          PinPut(
            //controller: _codeController,

            onChanged: (val) => model.codeInput = val,
            fieldsCount: 4,
            eachFieldMargin:
                EdgeInsets.symmetric(horizontal: size.width / (375 / 0)),
            eachFieldHeight: size.height / (812 / 60),
            eachFieldWidth: size.width / (375 / 60),
            autofocus: true,
            submittedFieldDecoration: BoxDecoration(
                border: Border.all(color: Color(0xff071E30), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(14))),
            followingFieldDecoration: BoxDecoration(
                color: Color(0xffEDEDED),
                borderRadius: BorderRadius.all(Radius.circular(14))),
            selectedFieldDecoration: BoxDecoration(
                border: Border.all(color: Color(0xff071E30), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(14))),
          ),
          SizedBox(height: size.height / (812 / 32)),
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            child: PrimaryButton(
                size: size,
                color:
                    model.codeInput != model.trueCode ? kGrey : kPrimaryColor,
                textColor: Colors.white,
                title: 'Done',
                function: () async {
                  if (model.codeInput != model.trueCode) {
                    //do nothing

                  } else {
                    //TODO: implement login
                    if (model.codeInput == model.trueCode) {
                      //do something
                      await model.loginCodeConfirm();
                      showDialog(
                          context: context,
                          builder: (ctx) => Dialog(
                                backgroundColor: Colors.transparent,
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.height / (812 / 10),
                                        horizontal: size.width / (375 / 16)),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: size.width /
                                                          (375 / 16)),
                                                  child: AutoSizeText(
                                                      'Fullname',
                                                      style: TextStyle(
                                                          color:
                                                              kTextSecondaryColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ),
                                                TextField(
                                                  onChanged: (val) {
                                                    fullnameController.text =
                                                        val;
                                                    model.fullname =
                                                        fullnameController.text;
                                                  },
                                                  decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: size.height /
                                                                  (812 / -20)),
                                                      hintText: ' ',
                                                      hintStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: kTextPrimary),
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none),
                                                )
                                              ],
                                            ),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: kPrimaryColor,
                                                    width: 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)))),
                                        SizedBox(
                                            height: size.height / (812 / 10)),
                                        AnimatedContainer(
                                          duration: Duration(milliseconds: 300),
                                          child: PrimaryButton(
                                            function: () async {
                                              var statusCode =
                                                  await model.addFullname();
                                              if (statusCode == 200) {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MapPageView()));
                                              }
                                            },
                                            size: size,
                                            color: model.fullname.isNotEmpty
                                                ? kPrimaryColor
                                                : kTextSecondaryColor,
                                            textColor: Colors.white,
                                            title: 'Set name',
                                          ),
                                        )
                                      ],
                                    ),
                                    width: double.infinity,
                                    //height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5))),
                              ));
                      print('ture');
                    }
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class InputNumberContainer extends ViewModelWidget<CodePageViewModel> {
  const InputNumberContainer({
    Key key,
    @required this.size,
    @required PhoneNumber number,
    @required this.controller,
  })  : _number = number,
        super(key: key);

  final Size size;
  final PhoneNumber _number;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, CodePageViewModel model) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.only(
          top: size.height / (812 / 56),
          bottom: size.height / (812 / 34),
          left: size.width / (375 / 16),
          right: size.width / (375 / 16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText(
            'Enter you phone number',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: kTextPrimary),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: size.height / (812 / 32), top: size.height / (812 / 8)),
            child: AutoSizeText(
              'We’ll send you a verification code to your phone.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: kTextSecondaryColor),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: size.height / (812 / 8),
                horizontal: size.width / (375 / 8)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Color(0xffA6ABAF), width: 1)),
            child: InternationalPhoneNumberInput(
              //maxLength: 11,
              keyboardType: TextInputType.number,
              initialValue: _number,
              textFieldController: controller,
              inputBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 5.0),
              ),
              inputDecoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: '-- --- ----',
                  hintStyle: TextStyle(
                      fontSize: 16,
                      color: kTextPrimary,
                      fontWeight: FontWeight.w400),
                  contentPadding:
                      EdgeInsets.only(bottom: size.height / (812 / 15))),
              onInputChanged: (_number) => model.number = _number.phoneNumber,
            ),
          ),
          SizedBox(height: size.height / (812 / 32)),
          PrimaryButton(
            size: size,
            color: kPrimaryColor,
            textColor: Colors.white,
            title: 'Send code',
            function: () async {
              //TODO: implement code sending
              await model.login();
              // controller.dispose();
              model.pageController.animateToPage(1,
                  duration: Duration(milliseconds: 300), curve: Curves.linear);
              model.index = 1;
            },
          ),
        ],
      ),
    );
  }
}
