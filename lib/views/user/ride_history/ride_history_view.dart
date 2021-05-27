import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/back_with_title.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/primary_button.dart';
import 'package:unic_app/components/ride%20history/ride_container.dart';
import 'package:unic_app/components/ride%20history/start2end_icon.dart';
import 'package:unic_app/views/user/ride_history/ride_history_viewmodel.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RideHistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<RideHistoryViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width / (375 / 16)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: size.height / (812 / 60)),
              BackWithTitle(
                size: size,
                title: 'Ride history',
              ),
              SizedBox(height: size.height / (812 / 12)),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) => RideHistoryContainer(
                        size: size,
                        endAdress: '${model.rides[index].endAdress}',
                        startAdress: '${model.rides[index].startAdress}',
                        rideDate:
                            '${DateFormat('dd.MM.yyyy').format(model.rides[index].rideDate)}',
                        ridePrice: model.rides[index].ridePrice,
                        rideRating: model.rides[index].rideRating),
                    separatorBuilder: (context, _) => SizedBox(
                          height: size.height / (812 / 12),
                        ),
                    itemCount: model.rides.length),
              )
              // RideHistoryContainer(size: size, index: 0)
            ],
          ),
        ),
      ),
      viewModelBuilder: () => RideHistoryViewModel(),
    );
  }
}
