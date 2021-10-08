import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/profile%20page/profile_edit_components.dart';
import 'package:unic_app/services/image_picker.dart';
import 'package:unic_app/views/user/profile_page/profile_page_viewmodel.dart';
//import 'package:image_picker/image_picker.dart';

class UserProfileEditPageView extends StatefulWidget {
  UserProfilePageViewModel model;
  UserProfileEditPageView({this.model});

  @override
  State<UserProfileEditPageView> createState() =>
      _UserProfileEditPageViewState();
}

class _UserProfileEditPageViewState extends State<UserProfileEditPageView> {
  TextEditingController _fullnameController = TextEditingController();
  //TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  @override
  void initState() {
    if (widget.model.user.fullname != null) {
      print('yes');
      _fullnameController.text = widget.model.user.fullname;
    }
    print(_fullnameController.text);
    if (widget.model.user.email != null) {
      _emailController.text = widget.model.user.email;
    }
    if (widget.model.user.phone != null) {
      _phoneController.text = widget.model.user.phone;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      body: Container(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                left: size.width / (375 / 16),
                                right: size.width / (375 / 16),
                                bottom: size.height / (812 / 66),
                                top: size.height / (812 / 60)),
                            child: TopCancelSaveRow(
                              onTap: () {
                                if (_fullnameController.text.isNotEmpty) {
                                  widget.model.user.fullname =
                                      _fullnameController.text;
                                  widget.model.addFullname();
                                }
                                if (_emailController.text.isNotEmpty) {
                                  widget.model.user.email =
                                      _emailController.text;
                                  widget.model.sendUserData();
                                  //print(model.user.email);
                                }
                                Navigator.pop(context);
                              },
                            )),
                      ],
                    )),
                Flexible(
                    flex: 3,
                    child: Container(
                      //height: 300
                      child: Column(
                        children: [
                          SizedBox(height: size.height / (812 / 140)),
                          EditTextField(
                              controller: _fullnameController,
                              size: size,
                              hintTitle: 'Fullname',
                              hintText: widget.model.user.fullname),
                          SizedBox(height: size.height / (812 / 24)),
                          EditTextField(
                              controller: _emailController,
                              size: size,
                              hintTitle: 'E-mail',
                              hintText: widget.model.user.email),
                          SizedBox(height: size.height / (812 / 24)),
                          EditTextField(
                              controller: _phoneController,
                              isNumber: true,
                              enabled: false,
                              size: size,
                              hintTitle: 'Phone',
                              hintText: widget.model.user.phone),
                        ],
                      ),
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width / (375 / 16)),
                    ))
              ],
            ),
            Positioned(
                top: size.height / (812 / 146),
                left: size.width / (375 / 132),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        radius: size.width / (375 / 56),
                        backgroundImage: widget.model.localFile != null
                            ? AssetImage(widget.model.localFile.path)
                            : NetworkImage(
                                'https://unikeco.az${widget.model.user.profilePicAdress}')),
                    SizedBox(height: size.height / (812 / 20)),
                    GestureDetector(
                      onTap: () async {
                        try {
                          final resultOfImagePicker = await getImage();
                          if (resultOfImagePicker.runtimeType !=
                              'No selected image') {
                            widget.model.localFile = resultOfImagePicker;
                            await widget.model.sendUserImage();
                            setState(() {});
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: AutoSizeText(
                        'Edit image',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: kTextSecondaryColor),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
