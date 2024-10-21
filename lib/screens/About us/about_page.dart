import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yokai_quiz_app/util/colors.dart';
import 'package:yokai_quiz_app/util/const.dart';
import 'package:yokai_quiz_app/util/text_styles.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          Container(
            height: 500,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/about.png'),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('icons/arrowLeft.svg'),
                          const SizedBox(width: 8),
                          const Text(
                            "About us",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: coral500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: Center(
                  child: Column(
                children: [
                  Image.asset(
                    'images/appLogo_yokai.png',
                    height: 100,
                    width: 100,
                  ),
                  3.ph,
                  Text(
                    "At Yokai, we are committed to provide you best customer service experience. Also, we look forward to your suggestions and feedbacks.",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.normalSemiBold12.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  3.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('icons/email2.svg'),
                      const SizedBox(width: 5),
                      Text(
                        'Email',
                        style: AppTextStyle.normalBold12
                            .copyWith(color: indigo700),
                      ),
                    ],
                  ),
                  2.ph,
                  Text(
                    'care@yokai.com',
                    style: AppTextStyle.normalSemiBold12.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(color: lightgrey, width: 1))),
                    child: Column(
                      children: [
                        const Text(
                          'Enjoying the app?',
                          style: TextStyle(color: coral500, fontSize: 16),
                        ),
                        const Text(
                          'Would you mind rating us??',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.normal,
                              fontSize: 12),
                        ),
                        1.5.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0), // Space between stars
                              child: SvgPicture.asset('icons/star.svg'),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
