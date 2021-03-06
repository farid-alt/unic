import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/models/adress.dart';
import 'package:unic_app/translates.dart';
import 'package:unic_app/views/user/map_page/map_page_viewmodel.dart';
import 'package:unic_app/views/user/select_adress/select_adress_viewmodel.dart';

class SelectAdressView extends StatefulWidget {
  // MapPageViewModel model;
  SelectAdressView({this.firstAdress});
  Adress firstAdress;

  @override
  State<SelectAdressView> createState() => _SelectAdressViewState();
}

class _SelectAdressViewState extends State<SelectAdressView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<SelectAdressViewModel>.reactive(
        builder: (context, model, child) {
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
                              minHeight: size.height / (815 / 175)),
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
                                      onTap: () =>
                                          Navigator.pop(context, 'CANCEL'),
                                      child: Row(children: [
                                        Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                          size: size.width / (375 / 25),
                                        ),
                                        AutoSizeText(
                                          "${kGeneralTranslates['back'][LANGUAGE]}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        )
                                      ]),
                                    ),
                                    AutoSizeText(
                                        "${kMapPageTranslates['select_location'][LANGUAGE]}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white)),
                                    InkWell(
                                      onTap: () {
                                        print(model.firstAdress.nameOfPlace);
                                        if (model.firstAdress.nameOfPlace !=
                                                null &&
                                            model.adresses[0].nameOfPlace !=
                                                null) {
                                          Navigator.pop(
                                            context,
                                            [
                                              'OK',
                                              model.firstAdress,
                                              model.adresses
                                            ],
                                          );
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Choose at least two adresses",
                                              gravity: ToastGravity.CENTER,
                                              backgroundColor: Colors.red);
                                        }
                                      },
                                      child: AutoSizeText(
                                          "${kGeneralTranslates['done'][LANGUAGE]}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                    )
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ElementSelectAdress(
                                          color: Colors.white,
                                          size: size,
                                        ),
                                        for (var i = 0;
                                            i < model.adresses.length;
                                            i++)
                                          ElementSelectAdress2(
                                              color: Colors.white,
                                              size: size,
                                              last: i !=
                                                  model.adresses.length - 1)
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
                                            icon:
                                                'assets/map_page/Location.svg',
                                            controller:
                                                model.textEditingController1,
                                            callBack: (value) {
                                              model.firstAdress.nameOfPlace =
                                                  value;
                                              model.getSuggestion(value);
                                              model.activeTextfield = 0;
                                            },
                                            value:
                                                model.firstAdress.nameOfPlace,
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
                                                                controller: model
                                                                    .controllers[i],
                                                                size: size,
                                                                icon:
                                                                    'assets/map_page/close_square.svg',
                                                                callBack:
                                                                    (value) {
                                                                  model
                                                                      .adresses[
                                                                          i]
                                                                      .nameOfPlace = value;
                                                                  model.getSuggestion(
                                                                      value);
                                                                  model.activeTextfield =
                                                                      i + 1;
                                                                },
                                                                value: model
                                                                    .adresses[i]
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
                                                          opacity:
                                                              i == 2 ? 0 : 1,
                                                          child: InkWell(
                                                            onTap: () {
                                                              if (i != 2) {
                                                                if ((i != 0 &&
                                                                            model.adresses.length !=
                                                                                1 ||
                                                                        model.adresses.length ==
                                                                            1) &&
                                                                    model.adresses
                                                                            .length !=
                                                                        3) {
                                                                  model
                                                                      .addAdress();
                                                                  model
                                                                      .controllers
                                                                      .add(
                                                                          TextEditingController());
                                                                } else {
                                                                  model
                                                                      .deleteAdress(
                                                                          i);
                                                                  model
                                                                      .controllers
                                                                      .removeLast();
                                                                }
                                                                HapticFeedback
                                                                    .mediumImpact();
                                                              }
                                                            },
                                                            child: Container(
                                                              width: size
                                                                      .width /
                                                                  (375 / 21),
                                                              height: size
                                                                      .width /
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
                                                                    : 'assets/map_page/close_square.svg'),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: size.height /
                                                        (815 / 12),
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
                                  onTap: () {
                                    if (model.activeTextfield == 0) {
                                      model.firstAdress = Adress(
                                        nameOfPlace: model
                                            .suggestedAdresses[index]
                                            .nameOfPlace,
                                      );
                                      model.textEditingController1.text = model
                                          .suggestedAdresses[index].nameOfPlace;
                                    } else {
                                      model.adresses[
                                          model.activeTextfield - 1] = Adress(
                                        nameOfPlace: model
                                            .suggestedAdresses[index]
                                            .nameOfPlace,
                                      );
                                      model
                                              .controllers[
                                                  model.activeTextfield - 1]
                                              .text =
                                          model.suggestedAdresses[index]
                                              .nameOfPlace;
                                    }
                                    print(model.firstAdress.nameOfPlace);
                                    // model.clearAdresses();
                                    SystemChannels.textInput
                                        .invokeMethod('TextInput.hide');
                                    // setState(() {});
                                  },
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
                            "${kMapPageTranslates['choose_on_map'][LANGUAGE]}",
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
        viewModelBuilder: () =>
            SelectAdressViewModel(firstAdress: widget.firstAdress));
  }
}

class SuggestedAdress extends StatelessWidget {
  Size size;
  Adress adress;
  Function onTap;
  SuggestedAdress({this.adress, this.size, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
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
                Container(
                  width: size.width / (375 / 280),
                  child: AutoSizeText(
                    '${adress.nameOfPlace}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: kTextPrimary),
                  ),
                ),
                SizedBox(
                  height: size.height / (815 / 3),
                ),
                Container(
                  width: size.width / (375 / 280),
                  child: AutoSizeText(
                    '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: kTextSecondaryColor),
                  ),
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
  Color color;
  ElementSelectAdress({this.size, @required this.color});
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
            color: color,
          ),
          SizedBox(
            height: size.height / (815 / 14),
          ),
          SvgPicture.asset('assets/ride_history/Line 7.svg', color: color),
          SizedBox(
            height: size.height / (815 / 14),
          ),
          SvgPicture.asset(
            'assets/map_page/OtherAdress.svg',
            width: size.width / (375 / 11),
            height: size.height / (815 / 15),
            color: color,
          ),
        ],
      ),
    );
  }
}

class ElementSelectAdressSmall extends StatelessWidget {
  Size size;
  Color color;
  ElementSelectAdressSmall({this.size, @required this.color});
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
            color: color,
          ),
          SizedBox(
            height: size.height / (815 / 5),
          ),
          SvgPicture.asset('assets/ride_history/Line 7.svg', color: color),
          SizedBox(
            height: size.height / (815 / 5),
          ),
          SvgPicture.asset(
            'assets/map_page/OtherAdress.svg',
            width: size.width / (375 / 11),
            height: size.height / (815 / 15),
            color: color,
          ),
        ],
      ),
    );
  }
}

class ElementSelectAdress2 extends StatelessWidget {
  Size size;
  Color color;
  bool last;
  ElementSelectAdress2({this.size, this.last, @required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.height / (815 / 0)),
      child: Column(
        children: [
          SizedBox(
            height: size.height / (815 / 14),
          ),
          if (last)
            Column(
              children: [
                SvgPicture.asset('assets/ride_history/Line 7.svg',
                    color: color),
                SizedBox(
                  height: size.height / (815 / 14),
                ),
                SvgPicture.asset(
                  'assets/map_page/OtherAdress.svg',
                  width: size.width / (375 / 11),
                  height: size.height / (815 / 15),
                  color: color,
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
  final TextEditingController controller;
  final String icon;
  final String value;
  final bool firstAdress;
  // final Function suffixFuntion;

  const TextfieldWithSuffixIcon(
      {Key key,
      this.callBack,
      @required this.size,
      @required this.controller,
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
  void initState() {
    widget.controller.addListener(() {
      widget.callBack(widget.controller.text);
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
        onChanged: (value) {
          widget.callBack(value);
        },
        controller: widget.controller,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
        decoration: InputDecoration(
            hintText: "${kMapPageTranslates['search_location'][LANGUAGE]}",
            hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xffB6DFFF),
            ),
            contentPadding: EdgeInsets.only(
                top: widget.controller.text.length == 0 && !widget.firstAdress
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
                : widget.controller.text.length != 0
                    ? InkWell(
                        onTap: () => widget.controller.text = '',
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
