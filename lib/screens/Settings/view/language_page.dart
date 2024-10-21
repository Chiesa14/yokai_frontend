import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yokai_quiz_app/screens/Settings/controller/setting_controller.dart';
import 'package:yokai_quiz_app/util/colors.dart';
import 'package:yokai_quiz_app/util/const.dart';
import 'package:yokai_quiz_app/util/text_styles.dart';

class LanguageSetting extends StatefulWidget {
  const LanguageSetting({super.key});

  @override
  State<LanguageSetting> createState() => _LanguageSettingState();
}

class _LanguageSettingState extends State<LanguageSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Replaced with SingleChildScrollView for scrolling behavior
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
                      "Language",
                      style:
                          AppTextStyle.normalBold20.copyWith(color: coral500),
                    ),
                  ],
                ),
              ),
              3.ph,
              const Text('Suggested', style: AppTextStyle.normalBold16),
              2.ph,
              Obx(
                () => Column(
                  children: List.generate(
                    SettingController.suggestedLanguages.length,
                    (index) {
                      final language =
                          SettingController.suggestedLanguages[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            language,
                            style: AppTextStyle.normalBold14
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                SettingController.prilmaryLanguage.value =
                                    language;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: indigo700,
                                  width: SettingController
                                              .prilmaryLanguage.value ==
                                          language
                                      ? 4.0
                                      : 1.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
