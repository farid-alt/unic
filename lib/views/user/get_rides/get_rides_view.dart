import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/get%20free%20rides/free_rides_related.dart';
import 'package:unic_app/views/user/get_rides/get_rides_viewmodel.dart';

class GetRidesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<GetRidesViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              backgroundColor: kPrimaryColor,
              body: FutureBuilder(
                  future: model.profileFuture,
                  builder: (context, snapshot) {
                    print(snapshot.error);
                    return Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: PrimaryColorBox(size: size),
                        ),
                        Expanded(
                          flex: 2,
                          child: WhiteBox(size: size),
                        )
                      ],
                    );
                  }),
            ),
        viewModelBuilder: () => GetRidesViewModel());
  }
}
