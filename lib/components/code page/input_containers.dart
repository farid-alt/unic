import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/primary_button.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/views/contact%20us/contact_us.dart';
import 'package:unic_app/views/user/add_fullname/add_fullname_view.dart';
import 'package:unic_app/views/user/code_page/code_page_viewmodel.dart';
import 'package:unic_app/views/user/faq/faq_view.dart';
import 'package:unic_app/views/user/main_wrapper/main_wrapper_view.dart';
import 'package:unic_app/views/user/map_page/map_page_view.dart';
import 'package:unic_app/views/user/payments/payments_view.dart';
import 'package:unic_app/views/user/profile_page/profile%20edit/profile_edit_view.dart';
import 'package:unic_app/views/user/terms%20and%20conditions/terms_view.dart';

import '../../translates.dart';

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
          top: size.height / (812 / 46),
          bottom: size.height / (812 / 24),
          left: size.width / (375 / 16),
          right: size.width / (375 / 16)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              kOnboardingScreen['enter_verification_code'][LANGUAGE],
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: kTextPrimary),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: size.height / (812 / 32),
                  top: size.height / (812 / 8)),
              child: AutoSizeText(
                '${kOnboardingScreen['code_has_been_sent'][LANGUAGE]} ${model.number} ${kOnboardingScreen['via_sms'][LANGUAGE]}',
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
                  title: '${kGeneralTranslates['done'][LANGUAGE]}',
                  function: () async {
                    if (model.codeInput != model.trueCode) {
                      //do nothing

                    } else {
                      //TODO: implement login
                      if (model.codeInput == model.trueCode) {
                        //do something
                        model.loginCodeConfirm().then((val) {
                          if (val[0] == 200) {
                            if (val[1]['data']['userDetail']['user']
                                        ['full_name'] ==
                                    null ||
                                val[1]['data']['userDetail']['user']
                                        ['full_name'] ==
                                    '') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddFullnameView()));
                            } else {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainWrapperView()),
                                  (route) => false);
                            }
                          } else {
                            Fluttertoast.showToast(msg: 'Check the data');
                          }
                        });

                        print('ture');
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class EnterFullname extends StatefulWidget {
  const EnterFullname({Key key, @required this.size, this.model})
      : super(key: key);

  final Size size;
  final CodePageViewModel model;

  @override
  _EnterFullnameState createState() => _EnterFullnameState();
}

class _EnterFullnameState extends State<EnterFullname> {
  TextEditingController fullnameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
          padding: EdgeInsets.symmetric(
              vertical: widget.size.height / (812 / 10),
              horizontal: widget.size.width / (375 / 16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: widget.size.width / (375 / 16)),
                        child: AutoSizeText(
                            "${kInputTranslates['fullname'][LANGUAGE]}",
                            style: TextStyle(
                                color: kTextSecondaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)),
                      ),
                      TextField(
                        controller: fullnameController,
                        onChanged: (val) {
                          setState(() {});
                          // fullnameController.text = val;
                          // model.fullname = fullnameController.text;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: widget.size.width / (375 / 15),
                                top: widget.size.height / (812 / -20)),
                            hintText: ' ',
                            hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: kTextPrimary),
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none),
                      )
                    ],
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
              SizedBox(height: widget.size.height / (812 / 10)),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                child: PrimaryButton(
                    function: () async {
                      if (fullnameController.text.isNotEmpty) {
                        widget.model.fullname = fullnameController.text;
                        var statusCode = await widget.model.addFullname();
                        if (statusCode == 200) {
                          //   Navigator.pushReplacement(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               MapPageView()));
                          // }
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => MainWrapperView()),
                              (Route<dynamic> route) => false);
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => MapPageView()));
                        }
                      }
                    },
                    size: widget.size,
                    color: fullnameController.text.isNotEmpty
                        ? kPrimaryColor
                        : kTextSecondaryColor,
                    textColor: Colors.white,
                    title: kGeneralTranslates['set_name'][LANGUAGE]),
              )
            ],
          ),
          width: double.infinity,
          //height: 50,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5))),
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
          top: size.height / (812 / 46),
          bottom: size.height / (812 / 24),
          left: size.width / (375 / 16),
          right: size.width / (375 / 16)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              '${kOnboardingScreen['enter_phone'][LANGUAGE]}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: kTextPrimary),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: size.height / (812 / 32),
                  top: size.height / (812 / 8)),
              child: AutoSizeText(
                '${kOnboardingScreen['we_will_send_you'][LANGUAGE]}',
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
              title: '${kGeneralTranslates['send_code'][LANGUAGE]}',
              function: () async {
                //TODO: implement code sending
                model.login();
                // controller.dispose();
                model.pageController.animateToPage(1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear);
                model.index = 1;
                SystemChannels.textInput.invokeMethod('TextInput.hide');
              },
            ),
          ],
        ),
      ),
    );
  }
}
