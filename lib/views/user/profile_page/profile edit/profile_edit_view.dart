import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unic_app/components/colors.dart';
import 'package:unic_app/components/profile%20page/profile_edit_components.dart';
import 'package:unic_app/views/user/profile_page/profile_page_viewmodel.dart';
//import 'package:image_picker/image_picker.dart';

class UserProfileEditPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextEditingController _fullnameController = TextEditingController();
    //TextEditingController _phoneController = TextEditingController();
    TextEditingController _emailController = TextEditingController();

    // File _image;
    // final picker = ImagePicker();

    // Future getImage() async {
    //   final pickedFile = await picker.getImage(source: ImageSource.camera);

    //   if (pickedFile != null) {
    //     _image = File(pickedFile.path);
    //   } else {
    //     print('No image selected.');
    //   }
    // }

    return ViewModelBuilder<UserProfilePageViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              backgroundColor: kPrimaryColor,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
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
                                        if (_fullnameController
                                            .text.isNotEmpty) {
                                          model.userFullName =
                                              _fullnameController.text;
                                        }
                                        if (_emailController.text.isNotEmpty) {
                                          model.user.email =
                                              _emailController.text;
                                          //print(model.user.email);
                                        }
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
                                  SizedBox(height: size.height / (812 / 120)),
                                  EditTextField(
                                      controller: _fullnameController,
                                      size: size,
                                      hintTitle: 'Fullname',
                                      hintText: model.user.fullname),
                                  SizedBox(height: size.height / (812 / 24)),
                                  EditTextField(
                                      controller: _emailController,
                                      size: size,
                                      hintTitle: 'E-mail',
                                      hintText: model.user.email),
                                  SizedBox(height: size.height / (812 / 24)),
                                  EditTextField(
                                      //controller: _phoneController,
                                      isNumber: true,
                                      size: size,
                                      hintTitle: 'Phone',
                                      hintText: model.user.phone),
                                ],
                              ),
                              width: double.infinity,
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width / (375 / 16)),
                            ))
                      ],
                    ),
                  ),
                  Positioned(
                      top: size.height / (812 / 146),
                      left: size.width / (375 / 132),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                              radius: size.width / (375 / 56),
                              backgroundImage: NetworkImage(
                                  '${model.user.profilePicAdress}')),
                          SizedBox(height: size.height / (812 / 20)),
                          GestureDetector(
                            // onTap: () async {
                            //   await getImage();
                            // }, TODO: implement image picker
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
        viewModelBuilder: () => UserProfilePageViewModel());
  }
}
