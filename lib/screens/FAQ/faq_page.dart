import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yokai_quiz_app/util/colors.dart';
import 'package:yokai_quiz_app/util/const.dart';
import 'package:yokai_quiz_app/util/text_styles.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    SvgPicture.asset('icons/arrowLeft.svg'),
                    Text(
                      "Account info",
                      style:
                          AppTextStyle.normalBold20.copyWith(color: coral500),
                    ),
                  ],
                ),
              ),
              3.ph,
              const Text(
                "Terms and Conditions",
                style: AppTextStyle.normalBold14,
              ),
              2.ph,
              Text(
                "Welcome to the Yokayzen app. By using this app, you agree to be bound by these terms and conditions.",
                style: AppTextStyle.normalBold12
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              3.ph,
              const Text(
                "1. Definitions",
                style: AppTextStyle.normalBold14,
              ),
              2.ph,
              Text(
                "\"App\" means the Yokayzen app. \"Customer\" means the person or entity who places an order for delivery through the App. \"Delivery Fee\" means the fee charged by the App for delivering an order. \"Order\" means a request by a Customer to purchase goods or services from a Merchant through the App. \"Merchant\" means the person or entity that sells goods or services through the App",
                style: AppTextStyle.normalBold12
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              3.ph,
              const Text(
                "2. Acceptance of Terms and Conditions",
                style: AppTextStyle.normalBold14,
              ),
              2.ph,
              Text(
                "By using the App, you agree to be bound by these terms and conditions. If you do not agree to these terms and conditions, you may not use the App.",
                style: AppTextStyle.normalBold12
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              3.ph,
              const Text(
                "3. Registration",
                style: AppTextStyle.normalBold14,
              ),
              2.ph,
              Text(
                "To use the App, you must create an account and provide certain information about yourself, such as your name, email address, and shipping address. You are responsible for maintaining the confidentiality of your account information and password. You are also responsible for all activity that occurs on your account.",
                style: AppTextStyle.normalBold12
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              3.ph,
              const Text(
                "4. Intellectual Property",
                style: AppTextStyle.normalBold14,
              ),
              2.ph,
              Text(
                "The App and all of its content, including but not limited to text, images, and software, are the property of the App's owner and are protected by copyright law. You may not copy, distribute, or modify any of the App's content without the express written permission of the App's owner.",
                style: AppTextStyle.normalBold12
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
