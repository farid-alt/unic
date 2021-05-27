import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unic_app/components/back_with_title.dart';
import 'package:unic_app/components/colors.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width / (375 / 16),
            vertical: size.height / (812 / 60)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BackWithTitle(size: size, title: 'Contact us'),
            SizedBox(height: size.height / (812 / 32)),
            ContactUsContainer(
              size: size,
              title: 'unikazerbaijan@gmail.com',
              containerColor: kPrimaryColor,
              iconAdress: 'assets/Message.svg',
            ),
            SizedBox(height: size.height / (812 / 16)),
            ContactUsContainer(
              size: size,
              title: 'Facebook',
              containerColor: Color(0xff3381F7),
              iconAdress: 'assets/fb.svg',
            ),
            SizedBox(height: size.height / (812 / 16)),
            ContactUsContainer(
              size: size,
              title: 'Instagram',
              containerColor: Color(0xffC53C75),
              iconAdress: 'assets/instagram.svg',
            ),
          ],
        ),
      ),
    );
  }
}

class ContactUsContainer extends StatelessWidget {
  const ContactUsContainer({
    Key key,
    @required this.size,
    @required this.iconAdress,
    @required this.containerColor,
    @required this.title,
  }) : super(key: key);

  final Size size;
  final String iconAdress;
  final Color containerColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / (812 / 60),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('$iconAdress',
                  height: size.height / (812 / 20),
                  width: size.width / (375 / 20)),
              SizedBox(width: size.width / (375 / 16)),
              AutoSizeText(
                '$title',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            size: 16,
            color: Colors.white,
          )
        ],
      ),
      padding: EdgeInsets.symmetric(
          vertical: size.height / (812 / 20),
          horizontal: size.width / (375 / 16)),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }
}
