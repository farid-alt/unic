import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StartToEndIcon extends StatelessWidget {
  const StartToEndIcon({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/ride_history/Location.svg',
            height: size.height / (812 / 13), width: size.width / (375 / 11)),
        //for (int i = 0; i < 5; i++) Text('.'),
        SizedBox(height: size.height / (812 / 8)),
        SvgPicture.asset(
          'assets/ride_history/Line 7.svg',
          height: size.height / (812 / 32),
        ),
        SizedBox(height: size.height / (812 / 8)),
        SvgPicture.asset('assets/ride_history/plane.svg',
            height: size.height / (812 / 13), width: size.width / (375 / 13)),
      ],
    );
  }
}
