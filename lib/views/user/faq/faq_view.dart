import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/back_with_title.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/endpoints.dart';
import 'package:unic_app/translates.dart';
import 'package:unic_app/views/user/faq/faq_viewmodel.dart';

class FaqView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ViewModelBuilder<FaqViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            child: FutureBuilder(
                future: model.faqFuture,
                builder: (context, snapshot) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BackWithTitle(
                          size: size,
                          title: '${kMenuTranslates['faq'][LANGUAGE]}'
                              .toUpperCase()),
                      SizedBox(height: size.height / (812 / 32)),
                      Expanded(
                        child: ListView.builder(
                            itemCount: model.faqs.length,
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () => model.toogleFaqWidget(index),
                                  child: FaqWidget(
                                      size: size,
                                      title: model.faqs[index].title,
                                      content: model.faqs[index].content,
                                      enabled: model.faqs[index].enabled),
                                )),
                      ),
                    ],
                  );
                }),
            padding: EdgeInsets.symmetric(
                vertical: size.height / (812 / 60),
                horizontal: size.width / (375 / 16)),
          )),
      viewModelBuilder: () => FaqViewModel(),
    );
  }
}

class FaqWidget extends StatelessWidget {
  const FaqWidget({
    Key key,
    @required this.size,
    @required this.title,
    @required this.content,
    @required this.enabled,
  }) : super(key: key);

  final Size size;
  final String title;
  final String content;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText('${title}',
                  style: TextStyle(
                      color: kTextPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              SvgPicture.asset(
                  enabled ? 'assets/up_arrow.svg' : 'assets/down_arrow.svg',
                  height: size.height / (812 / 10),
                  width: size.width / (375 / 8))
            ],
          ),
          if (enabled)
            Padding(
              padding: EdgeInsets.only(top: size.height / (812 / 16)),
              child: AutoSizeText(
                '${content}',
                style: TextStyle(
                    color: kTextSecondaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
            )
        ],
      ),
      //height: size.height / (812 / (enabled ? 191 : 60)),
      padding: EdgeInsets.symmetric(
          vertical: size.height / (812 / 16),
          horizontal: size.width / (375 / 16)),
      decoration: BoxDecoration(
          color: Color(0xffE9F5FF), borderRadius: BorderRadius.circular(15)),
    );
  }
}
