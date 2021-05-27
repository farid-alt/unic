import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/primary_button.dart';
import 'package:unic_app/views/user/enter%20promo/enter_promo_viewmodel.dart';

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
              AutoSizeText(
                  'Enter the code and it will be\napplied to your next ride.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kTextSecondaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
              SizedBox(height: size.height / (812 / 32)),
              TextField(
                autofocus: false,
                //TODO: label text ui issue
                onChanged: (val) => model.justNotify(),
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Promo code',
                  // floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: kTextPrimary)),
                ),
              ),
              SizedBox(height: size.height / (812 / 60)),
              GestureDetector(
                onTap: () {
                  //TODO: promocode validation
                  if (_textController.text.isNotEmpty)
                    model.enteredPromo = _textController.text;
                },
                child: PrimaryButton(
                    color: _textController.text.isNotEmpty
                        ? kPrimaryColor
                        : kTextSecondaryColor,
                    size: size,
                    textColor: Colors.white,
                    title: 'Apply'),
              ),
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
          child: AutoSizeText('Cancel',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
        ),
        AutoSizeText('Enter promo code',
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
