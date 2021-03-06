import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/primary_button.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/translates.dart';
import 'package:unic_app/views/user/enter%20promo/enter_promo_viewmodel.dart';
import 'package:unic_app/views/user/promotions_page/promotions_view.dart';

class EnterPromoView extends StatefulWidget {
  @override
  _EnterPromoViewState createState() => _EnterPromoViewState();
}

class _EnterPromoViewState extends State<EnterPromoView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TextEditingController _textController = TextEditingController();

    return ViewModelBuilder<EnterPromoViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height / (812 / 60),
              horizontal: size.width / (375 / 16)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildTopSide(),
              SizedBox(height: size.height / (812 / 32)),
              AutoSizeText('${kMenuTranslates['enter_code2'][LANGUAGE]}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kTextSecondaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
              SizedBox(height: size.height / (812 / 32)),
              TextField(
                autofocus: false,
                //TODO: label text ui issue
                onChanged: (val) {
                  model.enteredPromo = val;
                },
                controller: _textController,
                decoration: InputDecoration(
                  labelText: '${kMenuTranslates['promo_code'][LANGUAGE]}',
                  // floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: kTextPrimary)),
                ),
              ),
              SizedBox(height: size.height / (812 / 60)),
              PrimaryButton(
                  function: () async {
                    //TODO: promocode validation

                    final response = await model.sendPromo();
                    if (response == 200) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PromotionsView()));
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Check promo code again',
                          gravity: ToastGravity.CENTER);
                    }
                  },
                  color: _textController.text.isNotEmpty
                      ? kPrimaryColor
                      : kTextSecondaryColor,
                  size: size,
                  textColor: Colors.white,
                  title: '${kGeneralTranslates['apply'][LANGUAGE]}'),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => EnterPromoViewModel(),
    );
  }

  Row buildTopSide() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: AutoSizeText("${kGeneralTranslates['cancel'][LANGUAGE]}",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
        ),
        AutoSizeText('${kMenuTranslates['enter_promo_code'][LANGUAGE]}',
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
    );
  }
}
