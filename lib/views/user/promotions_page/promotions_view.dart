import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/back_with_title.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/promotions/promotion_related.dart';
import 'package:unic_app/models/user/promotion.dart';
import 'package:unic_app/views/user/get_rides/get_rides_view.dart';
import 'package:unic_app/views/user/promotions_page/promotions_viewmodel.dart';

class PromotionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ViewModelBuilder<PromotionsViewModel>.nonReactive(
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: size.height / (812 / 28),
                      horizontal: size.width / (375 / 16)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height / (812 / (60 - 28))),
                      BackWithTitle(size: size),
                      SizedBox(height: size.height / (812 / 32)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GetRidesView()));
                        },
                        child: PromotionPageRows(
                          size: size,
                          title: 'Get free rides',
                          iconAdress: 'assets/promotions/starredticket.svg',
                        ),
                      ),
                      SizedBox(height: size.height / (375 / 16)),
                      Container(
                        color: kTextSecondaryColor,
                        height: 0.3,
                        width: double.infinity,
                      ),
                      SizedBox(height: size.height / (375 / 16)),
                      PromotionPageRows(
                        size: size,
                        title: 'Enter promo code',
                        iconAdress: 'assets/promotions/Discount.svg',
                      ),
                      SizedBox(height: size.height / (375 / 24)),
                      Center(
                        child: AutoSizeText('You have 2 free rides',
                            style: TextStyle(
                                color: kTextPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                      ),
                      // AutoSizeText('List of promo codes',
                      //     style: TextStyle(
                      //         color: kTextPrimary,
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.w700)),

                      // for (int i = 0; i < 10; i++) Text('321'),
                      // if (model.promotions.length > 0)
                      //   buildPromoCodes(size, model)
                      // else
                      //   NoPromoCodesWidget(size: size)
                    ],
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => PromotionsViewModel());
  }

  Container buildPromoCodes(Size size, PromotionsViewModel model) {
    return Container(
      padding: EdgeInsets.only(top: size.height / (812 / 24)),
      child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: model.promotions.length,
          itemBuilder: (context, index) => Column(
                children: [
                  PromoCodeRow(
                      size: size,
                      promoCode: model.promotions[index].promoCode,
                      number: index + 1,
                      isUsed: model.promotions[index].isUsed),
                  if (index != model.promotions.length - 1)
                    Container(
                      margin: EdgeInsets.only(
                          bottom: size.height / (812 / 16),
                          top: size.height / (812 / 16)),
                      color: kTextSecondaryColor,
                      height: 0.3,
                      width: double.infinity,
                    ),
                ],
              )),
    );
  }
}
