import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/models/adress.dart';
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
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        width: size.width,
                        constraints: BoxConstraints(
                            minHeight: size.height / (815 / 220)),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width / (375 / 16)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: Row(children: [
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
                                  ),
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
                              padding: EdgeInsets.only(
                                  left: size.width / (375 / 19)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ElementSelectAdress(
                                        size: size,
                                      ),
                                      for (var i = 0;
                                          i < model.adresses.length;
                                          i++)
                                        ElementSelectAdress2(
                                            size: size,
                                            last:
                                                i != model.adresses.length - 1)
                                    ],
                                  ),
                                  SizedBox(
                                    width: size.width / (375 / 14),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextfieldWithSuffixIcon(
                                          size: size,
                                          icon: 'assets/map_page/Location.svg',
                                          callBack: (value) {
                                            model.firstAdress.nameOfPlace =
                                                value;
                                          },
                                          value: model.firstAdress.nameOfPlace,
                                          firstAdress: true),
                                      SizedBox(
                                        height: size.height / (815 / 12),
                                      ),
                                      Column(
                                        children: [
                                          for (var i = 0;
                                              i < model.adresses.length;
                                              i++)
                                            Column(
                                              children: [
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            child:
                                                                TextfieldWithSuffixIcon(
                                                              size: size,
                                                              icon:
                                                                  'assets/map_page/deleteSquare.svg',
                                                              callBack:
                                                                  (value) {
                                                                model
                                                                    .adresses[i]
                                                                    .nameOfPlace = value;
                                                              },
                                                              value: model
                                                                  .firstAdress
                                                                  .nameOfPlace,
                                                              firstAdress:
                                                                  false,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: size.width /
                                                            (375 / 11),
                                                      ),
                                                      Opacity(
                                                        opacity: i == 2 ? 0 : 1,
                                                        child: InkWell(
                                                          onTap: () {
                                                            if (i != 2) {
                                                              if ((i != 0 &&
                                                                          model.adresses.length !=
                                                                              1 ||
                                                                      model.adresses
                                                                              .length ==
                                                                          1) &&
                                                                  model.adresses
                                                                          .length !=
                                                                      3) {
                                                                model
                                                                    .addAdress();
                                                              } else {
                                                                model
                                                                    .deleteAdress(
                                                                        i);
                                                              }
                                                              HapticFeedback
                                                                  .mediumImpact();
                                                            }
                                                          },
                                                          child: Container(
                                                            width: size.width /
                                                                (375 / 21),
                                                            height: size.width /
                                                                (375 / 21),
                                                            child: Center(
                                                              child: SvgPicture.asset((i ==
                                                                              0 &&
                                                                          model.adresses.length ==
                                                                              1) ||
                                                                      (i == 1 &&
                                                                          model.adresses.length ==
                                                                              2)
                                                                  ? 'assets/map_page/Plus.svg'
                                                                  : 'assets/map_page/deleteSquare.svg'),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      size.height / (815 / 12),
                                                ),
                                              ],
                                            ),
                                        ],
                                      )
                                      // return Text('a');
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        color: Colors.white,
                        child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: size.width / (375 / 60),
                                  right: size.width / (375 / 16),
                                ),
                                child: Container(
                                    height: 1,
                                    width: size.width,
                                    color: Color(0xffEBEDEE)),
                              );
                            },
                            itemCount: model.suggestedAdresses.length,
                            itemBuilder: (context, index) {
                              return SuggestedAdress(
                                size: size,
                                adress: model.suggestedAdresses[index],
                              );
                            }),
                      )),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: size.width,
                      height: size.height / (815 / 55),
                      color: Color(0xffF1F3F5),
                      child: Center(
                        child: AutoSizeText(
                          'Choose on map',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => SelectAdressViewModel(),
    );
  }
}

class SuggestedAdress extends StatelessWidget {
  Size size;
  Adress adress;
  SuggestedAdress({this.adress, this.size});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: size.width,
        // height: size.height / (815 / 68),
        padding: EdgeInsets.symmetric(
          horizontal: size.width / (375 / 16),
          vertical: size.height / (815 / 16),
        ),
        child: Row(
          children: [
            CircleWithIcon(
              finishWidth: size.width / (375 / 32),
              icon: 'assets/map_page/Location.svg',
            ),
            SizedBox(
              width: size.width / (375 / 12),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  '${adress.nameOfPlace}',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: kTextPrimary),
                ),
                SizedBox(
                  height: size.height / (815 / 3),
                ),
                AutoSizeText(
                  '${adress.adress}',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: kTextSecondaryColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CircleWithIcon extends StatelessWidget {
  double finishWidth;
  String icon;
  CircleWithIcon({this.finishWidth, this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: finishWidth,
        height: finishWidth,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kPrimaryColor,
        ),
        child: Center(
          child: SvgPicture.asset('$icon'),
        ));
  }
}

class ElementSelectAdress extends StatelessWidget {
  Size size;
  ElementSelectAdress({this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: size.height / (815 / 17)),
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/map_page/Location.svg',
            width: size.width / (375 / 11),
            height: size.height / (815 / 15),
          ),
          SizedBox(
            height: size.height / (815 / 5),
          ),
          SvgPicture.asset('assets/ride_history/Line 7.svg',
              color: Colors.white),
          SizedBox(
            height: size.height / (815 / 5),
          ),
          SvgPicture.asset(
            'assets/map_page/OtherAdress.svg',
            width: size.width / (375 / 11),
            height: size.height / (815 / 15),
          ),
        ],
      ),
    );
  }
}

class ElementSelectAdress2 extends StatelessWidget {
  Size size;
  bool last;
  ElementSelectAdress2({this.size, this.last});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.height / (815 / 0)),
      child: Column(
        children: [
          SizedBox(
            height: size.height / (815 / 5),
          ),
          if (last)
            Column(
              children: [
                SvgPicture.asset('assets/ride_history/Line 7.svg',
                    color: Colors.white),
                SizedBox(
                  height: size.height / (815 / 5),
                ),
                SvgPicture.asset(
                  'assets/map_page/OtherAdress.svg',
                  width: size.width / (375 / 11),
                  height: size.height / (815 / 15),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class TextfieldWithSuffixIcon extends StatefulWidget {
  final Function callBack;
  final String icon;
  final String value;
  final bool firstAdress;
  // final Function suffixFuntion;

  const TextfieldWithSuffixIcon(
      {Key key,
      @required this.size,
      @required this.callBack,
      @required this.icon,
      this.value = '',
      this.firstAdress})
      : super(key: key);

  final Size size;

  @override
  _TextfieldWithSuffixIconState createState() =>
      _TextfieldWithSuffixIconState();
}

class _TextfieldWithSuffixIconState extends State<TextfieldWithSuffixIcon> {
  final TextEditingController textEditingController = TextEditingController();
  void initState() {
    textEditingController.text = widget.value;
    textEditingController.addListener(() {
      widget.callBack(textEditingController.text);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width / (375 / 281),
      height: widget.size.height / (815 / 47),
      decoration: BoxDecoration(
        color: Color(0xff37A9FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: textEditingController,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
        decoration: InputDecoration(
            hintText: 'Search location',
            hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xffB6DFFF),
            ),
            contentPadding: EdgeInsets.only(
                top: textEditingController.text.length == 0 &&
                        !widget.firstAdress
                    ? -widget.size.height / (815 / 10)
                    : widget.size.height / (815 / 10),
                left: widget.size.width / (375 / 16),
                right: widget.size.width / (375 / 16)),
            suffixIcon: widget.firstAdress
                ? Container(
                    width: widget.size.width / (375 / 16),
                    height: widget.size.width / (375 / 16),
                    child: Center(
                      child: SvgPicture.asset(
                        '${widget.icon}',
                        width: widget.size.width / (375 / 16),
                        height: widget.size.width / (375 / 16),
                      ),
                    ),
                  )
                : textEditingController.text.length != 0
                    ? InkWell(
                        onTap: () => textEditingController.text = '',
                        child: Container(
                          width: widget.size.width / (375 / 16),
                          height: widget.size.width / (375 / 16),
                          child: Center(
                            child: SvgPicture.asset(
                              '${widget.icon}',
                              width: widget.size.width / (375 / 16),
                              height: widget.size.width / (375 / 16),
                            ),
                          ),
                        ),
                      )
                    : null,
            border: InputBorder.none),
      ),
    );
  }
}
