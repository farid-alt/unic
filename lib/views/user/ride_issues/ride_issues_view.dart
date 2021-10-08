import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/back_with_title.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/models/user/user.dart';
import 'package:unic_app/views/user/ride_issues/ride_issues_viewmodel.dart';

class RideIssuesView extends StatelessWidget {
  // final User customer;
  final String rideId;
  const RideIssuesView({Key key, @required this.rideId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ViewModelBuilder<RideIssuesViewModel>.nonReactive(
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
              BackWithTitle(size: size, title: 'Ride issues'),
              SizedBox(height: size.height / (812 / 32)),
              buildAutoSizeText(),
              Expanded(
                  child: ListView.builder(
                      itemCount: model.issues.length,
                      itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(
                                bottom: size.height / (812 / 16)),
                            child: GestureDetector(
                              onTap: () {
                                model.choosenIssue = model.issues[index];
                                showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                          backgroundColor: Colors.transparent,
                                          child: Container(
                                            width: double.infinity,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                AutoSizeText(model.choosenIssue,
                                                    style: TextStyle(
                                                        color: kTextPrimary,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                                SizedBox(
                                                    height: size.height /
                                                        (812 / 16)),
                                                Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.all(16),
                                                  height:
                                                      size.height / (812 / 200),
                                                  child: TextField(
                                                    onChanged: (val) {
                                                      model.choosenIssueDescription =
                                                          val;
                                                    },
                                                    maxLines: 5,
                                                    autocorrect: false,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            'Write what happenned here',
                                                        border:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        disabledBorder:
                                                            InputBorder.none),
                                                  ),
                                                  color: Color(0xffF8F9FA),
                                                ),
                                                SizedBox(
                                                    height: size.height /
                                                        (812 / 16)),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      //TODO: implement sending issue
                                                      if (model
                                                          .choosenIssueDescription
                                                          .isNotEmpty)
                                                        model.sendIssue(rideId);
                                                      Navigator.pop(context);
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'Your issue was successfully send');
                                                      // print(model
                                                      //     .choosenIssueDescription);
                                                    },
                                                    child: Text('Send'))
                                              ],
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    size.height / (812 / 16),
                                                horizontal:
                                                    size.width / (375 / 16)),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          ),
                                        ));
                              },
                              child: IssueTitleContainer(
                                  size: size, title: model.issues[index]),
                            ),
                          )))
            ],
          ),
        ),
      ),
      viewModelBuilder: () => RideIssuesViewModel(),
    );
  }

  AutoSizeText buildAutoSizeText() {
    return AutoSizeText.rich(
      TextSpan(
          text: 'Get in touch with ',
          style: TextStyle(
              color: kTextSecondaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w500),
          children: [
            TextSpan(
                text: 'Our Support Team ',
                style: TextStyle(
                    color: kTextSecondaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w700)),
            TextSpan(
                text: 'below.',
                style: TextStyle(
                    color: kTextSecondaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500))
          ]),
      textAlign: TextAlign.center,
    );
  }
}

class IssueTitleContainer extends StatelessWidget {
  const IssueTitleContainer({
    Key key,
    @required this.size,
    @required this.title,
  }) : super(key: key);

  final Size size;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: size.width / (375 / 16),
          vertical: size.height / (812 / 21)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText('$title',
              style: TextStyle(
                  color: kTextPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
          Icon(
            Icons.arrow_forward_ios,
            color: kTextSecondaryColor,
            size: size.width / (375 / 20),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: Color(0xffE9F5FF), borderRadius: BorderRadius.circular(14)),
    );
  }
}
