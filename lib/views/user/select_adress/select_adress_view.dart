import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/views/user/select_adress/select_adress_viewmodel.dart';

class SelectAdressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<SelectAdressViewModel>.reactive(
        builder: (
          context,
          model,
          child,
        ) {
          return Scaffold(
            backgroundColor: kPrimaryColor,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: size.height / (815 / 30)),
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height / (815 / 220),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width / (375 / 16)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: size.width / (375 / 25),
                                  ),
                                  AutoSizeText(
                                    'Back',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  )
                                ]),
                                AutoSizeText('Select location',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white)),
                                AutoSizeText('Cancel',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.transparent))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height / (815 / 24),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: size.width / (375 / 19)),
                            child: Row(
                              children: [
                                Column(
                                  children: [],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: size.width / (375 / 281),
                                      height: size.height / (815 / 45),
                                      decoration: BoxDecoration(
                                        color: Color(0xff37A9FF),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: TextField(
                                        controller: model.firstAdressController,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                            suffixIcon: SvgPicture.asset(
                                                'assets/map_page/'),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        viewModelBuilder: () => SelectAdressViewModel());
  }
}
