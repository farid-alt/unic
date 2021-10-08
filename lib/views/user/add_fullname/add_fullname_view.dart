import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/primary_button.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/translates.dart';
import 'package:unic_app/views/user/add_fullname/add_fullname_viewmodel.dart';
import 'package:unic_app/views/user/enter%20promo/enter_promo_viewmodel.dart';
import 'package:unic_app/views/user/main_wrapper/main_wrapper_view.dart';
import 'package:unic_app/views/user/promotions_page/promotions_view.dart';

class AddFullnameView extends StatefulWidget {
  @override
  _AddFullnameViewState createState() => _AddFullnameViewState();
}

class _AddFullnameViewState extends State<AddFullnameView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // TextEditingController _textController = TextEditingController();

    return ViewModelBuilder<AddFullnameViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: size.height / (812 / 60),
              horizontal: size.width / (375 / 16)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // buildTopSide(),
              SizedBox(height: size.height / (812 / 32)),
              AutoSizeText('Enter your fullname',
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
                  model.justNotify();
                },
                controller: model.fullnameController,
                decoration: InputDecoration(
                  labelText: 'Fullname',
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
                    if (model.fullnameController.text.isNotEmpty) {
                      model.addFullname();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainWrapperView()));
                    }
                  },
                  color: model.fullnameController.text.isNotEmpty
                      ? kPrimaryColor
                      : kTextSecondaryColor,
                  size: size,
                  textColor: Colors.white,
                  title: '${kGeneralTranslates['apply'][LANGUAGE]}'),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => AddFullnameViewModel(),
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
