import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/models/user/payment_method.dart';
import 'package:unic_app/translates.dart';
import 'package:unic_app/views/user/payments/payments_view.dart';
import 'package:unic_app/views/user/payments/payments_viewmodel.dart';

class AddCardView extends StatefulWidget {
  AddCardView({Key key, @required this.model}) : super(key: key);
  final PaymentsViewModel model;
  @override
  _AddCardViewState createState() => _AddCardViewState();
}

class _AddCardViewState extends State<AddCardView> {
  TextEditingController _cardNumber = TextEditingController();

  TextEditingController _expiryDate = TextEditingController();

  TextEditingController _secureCode = TextEditingController();
  MaskTextInputFormatter maskTextInputFormatter = MaskTextInputFormatter(
    mask: '##/##',
  );
  MaskTextInputFormatter maskTextInputFormatterCardNumber =
      MaskTextInputFormatter(
    mask: '#### #### #### ####',
  );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width / (375 / 16),
            vertical: size.height / (812 / 60)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: AutoSizeText(
                      "${kGeneralTranslates['cancel'][LANGUAGE]}",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                ),
                AutoSizeText("${kMenuTranslates['new_card'][LANGUAGE]}",
                    style: TextStyle(
                        color: kTextPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
                AutoSizeText('Cancel',
                    style: TextStyle(
                        color: Colors.transparent,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: size.height / (812 / 40)),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
              controller: _cardNumber,
              inputFormatters: [maskTextInputFormatterCardNumber],
              decoration: InputDecoration(
                  prefixIcon: UnconstrainedBox(
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: size.width / (375 / 16),
                          left: size.width / (375 / 16)),
                      child: SvgPicture.asset('assets/cred_card.svg',
                          height: size.height / (812 / 16),
                          width: size.width / (375 / 24)),
                    ),
                  ),
                  //labelText: 'Card number',
                  hintText: '${kMenuTranslates['card_number'][LANGUAGE]}',
                  hintStyle: TextStyle(
                    color: kTextPrimary,
                    fontWeight: FontWeight.w400,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(14)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: _cardNumber.text.isNotEmpty
                              ? kPrimaryColor
                              : kTextPrimary),
                      borderRadius: BorderRadius.circular(14))),
            ),
            SizedBox(height: size.height / (812 / 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width / (375 / 165),
                  child: TextField(
                    inputFormatters: [maskTextInputFormatter],
                    keyboardType: TextInputType.number,
                    onChanged: (_) => setState(() {}),
                    controller: _expiryDate,
                    decoration: InputDecoration(
                        hintText: '${kMenuTranslates['expiry_date'][LANGUAGE]}',
                        //labelText: 'Expiry date',
                        hintStyle: TextStyle(
                          color: kTextPrimary,
                          fontWeight: FontWeight.w400,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(14)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: _expiryDate.text.isNotEmpty
                                    ? kPrimaryColor
                                    : kTextPrimary),
                            borderRadius: BorderRadius.circular(14))),
                  ),
                ),
                SizedBox(
                  width: size.width / (375 / 165),
                  child: TextField(
                    maxLength: 3,
                    keyboardType: TextInputType.phone,
                    onChanged: (_) => setState(() {}),
                    controller: _secureCode,
                    decoration: InputDecoration(
                        //contentPadding: EdgeInsets.only(left: 5),
                        hintText: '${kMenuTranslates['secure_code'][LANGUAGE]}',
                        //labelText: 'Secure code',

                        hintStyle: TextStyle(
                          color: kTextPrimary,
                          fontWeight: FontWeight.w400,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(14)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: _secureCode.text.isNotEmpty
                                    ? kPrimaryColor
                                    : kTextPrimary),
                            borderRadius: BorderRadius.circular(14))),
                  ),
                ),
              ],
            ),
            Expanded(child: SizedBox(height: 1)),
            GestureDetector(
              onTap: () async {
                //TODO: add card
                String cardNumber = _cardNumber.text.replaceAll(' ', '');
                print(cardNumber);
                print(cardNumber.length);
                var year = _expiryDate.text.substring(3);
                var month = _expiryDate.text.substring(0, 2);
                if (_cardNumber.text.isNotEmpty &&
                    _secureCode.text.isNotEmpty &&
                    cardNumber.length == 16) {
                  final response = await widget.model.addCardApi(
                      cardNumber: cardNumber,
                      ccv: _secureCode.text,
                      expDate: DateTime(int.parse('20$year'), int.parse(month))
                          .toString());
                  if (response == 200) {
                    Navigator.pop(context);
                  } else {
                    Fluttertoast.showToast(msg: 'Check card data');
                  }
                  // widget.model.newCard({
                  //   'cash': 'false',
                  //   'card': PaymentMethod(
                  //       cardCcv: _secureCode.text,
                  //       cardNumber: cardNumber,
                  //       expDate: _expiryDate.text,
                  //       type: _cardNumber.text[0] == 5.toString()
                  //           ? PaymentType.MasterCard
                  //           : PaymentType.Visa),
                  //   'isChoosen': false
                  // });

                } else {}

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => PaymentsView()));
              },
              child: Container(
                width: double.infinity,
                height: size.height / (812 / 60),
                child: Center(
                    child: AutoSizeText(
                  '${kMenuTranslates['add_card'][LANGUAGE]}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                )),
                decoration: BoxDecoration(
                    color: _cardNumber.text.isNotEmpty &&
                            _expiryDate.text.isNotEmpty &&
                            _secureCode.text.isNotEmpty
                        ? kPrimaryColor
                        : kTextSecondaryColor,
                    borderRadius: BorderRadius.circular(14)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
