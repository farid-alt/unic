import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:unic_app/components/back_with_title.dart';
import 'package:unic_app/components/colors.dart';

class PrivacyPage extends KFDrawerContent {
  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / (375 / 16)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height / (812 / 60)),
              BackWithTitle(size: size, title: 'Privacy & Policy'),
              SizedBox(height: size.height / (812 / 32)),
              Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      'UNIK (“we,” “our,” or “us”) is committed to protecting your privacy. This Privacy Policy explains how your personal information is collected, used, and disclosed by UNIK.\n\nThis Privacy Policy applies to our website, and its associated subdomains (collectively, our “Service”) alongside our application, UNIK. By accessing or using our Service, you signify that you have read, understood, and agree to our collection, storage, use, and disclosure of your personal information as described in this Privacy Policy and our Terms of Service.',
                      style: TextStyle(
                          color: Color(
                            0xff5D6A75,
                          ),
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: size.height / (812 / 16)),
                    AutoSizeText(
                      'Definitions and key terms',
                      style: TextStyle(
                          color: kTextPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: size.height / (812 / 16)),
                    AutoSizeText(
                      'To help explain things as clearly as possible in this Privacy Policy, every time any of these terms are referenced, are strictly defined as:\n-Cookie: small amount of data generated by a website and saved by your web browser. It is used to identify your browser, provide analytics, remember information about you such as your language preference or login information.\n-Company: when this policy mentions “Company,” “we,” “us,” or “our,” it refers to UNIK, that is responsible for your information under this Privacy Policy.\n-Country: where UNIK or the owners/founders of UNIK are based, in this case is Azerbaijan\n-Customer: refers to the company, organization or person that signs up to use the UNIK Service to manage the relationships with your consumers or service users.\n-Device: any internet connected device such as a phone, tablet, computer or any other device that can be used to visit UNIK and use the services.\n-IP address: Every device connected to the Internet is assigned a number known as an Internet protocol (IP) address. These numbers are usually assigned in geographic blocks. An IP address can often be used to identify the location from which a device is connecting to the Internet.\n-Personnel: refers to those individuals who are employed by UNIK or are under contract to perform a service on behalf of one of the parties.\n-Personal Data: any information that directly, indirectly, or in connection with other information – including a personal identification number – allows for the identification or identifiability of a natural person.\n-Service: refers to the service provided by UNIK as described in the relative terms (if available) and on this platform.\n-Third-party service: refers to advertisers, contest sponsors, promotional and marketing partners, and others who provide our content or whose products or services we think may interest you.\n-Website: UNIK."’s" site, which can be accessed via this URL : \n- You: a person or entity that is registered with UNIK to use theServices.',
                      style: TextStyle(
                          color: Color(
                            0xff5D6A75,
                          ),
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: size.width / (375 / 16),
                    vertical: size.height / (812 / 16)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Color(0xffE9F5FF)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
