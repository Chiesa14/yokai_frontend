import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart'; // Ensure to import this for date formatting
import 'package:yokai_quiz_app/Widgets/progressHud.dart';
import 'package:yokai_quiz_app/global.dart';
import 'package:yokai_quiz_app/screens/mood%20tracker/controller/mood_controller.dart';
import 'package:yokai_quiz_app/util/colors.dart';
import 'package:yokai_quiz_app/util/const.dart';
import 'package:yokai_quiz_app/util/text_styles.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({Key? key}) : super(key: key);

  @override
  State<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  // Store the dates for the 7-day period
  List<DateTime> dates = [];
  DateTime selectedDate =
      DateTime.now(); // Add a variable to track the selected date

  @override
  void initState() {
    super.initState();
    MoodController.isLoading(true);
    _generateDateRange();
    fetchMoods();
    MoodController.isLoading(false);
  }

  fetchMoods() async {
    await MoodController.fetchGifsByUserId().then((value) => {
          MoodController.isLoading(false),
        });
  }

  void _generateDateRange() {
    final now = DateTime.now();
    for (int i = -3; i <= 3; i++) {
      dates.add(now.add(Duration(days: i)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      isLoading: MoodController.isLoading.value,
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    SvgPicture.asset('icons/arrowLeft.svg'),
                    Text(
                      "Mood Tracker",
                      style:
                          AppTextStyle.normalBold20.copyWith(color: coral500),
                    ),
                  ],
                ),
              ),
              4.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(dates.length, (index) {
                  // Get day name and date
                  final day = DateFormat('EEE').format(dates[index]);
                  final date = dates[index].day;

                  return _buildDayButton(
                    day,
                    date,
                    dates[index] == selectedDate,
                  );
                }),
              ),
              4.ph,
              const Text(
                "Today's check-in",
                style: AppTextStyle.normalBold18,
              ),
              2.ph,
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFADDE7),
                      borderRadius: BorderRadius.circular(30)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            child: Image.asset(
                              'icons/celebrate.png',
                            ),
                          ),
                          1.pw,
                          const Text(
                            "Check-in",
                            style: AppTextStyle.normalBold14,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'icons/checkin.png',
                            height: 30,
                            width: 30,
                          ),
                          1.pw,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              3.ph,
              _buildMoodChart(),
              3.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Connect with nature",
                    style: AppTextStyle.normalBold16,
                  ),
                  GestureDetector(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset('icons/hint.svg'),
                        Text(
                          'Tip',
                          style: AppTextStyle.normalBold14.copyWith(
                              fontWeight: FontWeight.normal,
                              color: const Color(0xFFE8B50E)),
                        )
                      ],
                    ),
                  )
                ],
              ),
              2.ph,
              const Text(
                "Spend time outdoors, surrounded by greenery and fresh air.",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayButton(String day, int date, bool isSelected) {
    Map<int, String> gifMap = {
      0: "images/angry.gif",
      1: "images/sad.gif",
      2: "images/neutral.gif",
      3: "images/sad.gif",
      4: "images/awesome.gif",
    };
    var moodDataForDate = MoodController.moodList.firstWhere(
      (mood) {
        DateTime moodDate = DateTime.parse(mood['date']);
        final moodDay = DateFormat('EEE').format(moodDate);
        return moodDay == day;
      },
      orElse: () => {},
    );
    String gifPath = "";
    if (moodDataForDate.isNotEmpty) {
      gifPath = gifMap[moodDataForDate['mood_gif']] ?? "";
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 2),
          height: 50,
          width: 40,
          decoration: BoxDecoration(
            color: isSelected ? indigo700 : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: indigo100, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                day,
                style: AppTextStyle.normalBold10
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              Container(
                width: double.infinity,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 211, 192, 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  date.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.white : coral500,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (gifPath != "")
          Image.asset(
            gifPath,
            height: 30,
            width: 30,
          ),
      ],
    );
  }

  Widget _buildMoodChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blueAccent.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Mood Chart",
                style: AppTextStyle.normalBold18,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black54,
                    size: 12,
                  ),
                  .5.pw,
                  Text(
                    'Last 5 days',
                    style: AppTextStyle.normalBold12
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  .5.pw,
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black54,
                    size: 12,
                  ),
                ],
              )
            ],
          ),
          2.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMoodBar(
                  0.8, "images/good.gif", Colors.green.withOpacity(.4), "Mon"),
              _buildMoodBar(
                  0.2, "images/good.gif", Colors.red.withOpacity(.4), "Tue"),
              _buildMoodBar(
                  0.6, "images/good.gif", Colors.blue.withOpacity(.4), "Wed"),
              _buildMoodBar(
                  0.4, "images/good.gif", Colors.orange.withOpacity(.4), "Thu"),
              _buildMoodBar(
                  0.2, "images/good.gif", Colors.red.withOpacity(.4), "Fri"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMoodBar(double value, String gifPath, Color color, String day) {
    return Column(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 200 * value, // Adjust the height based on mood value
                width: 30,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      gifPath,
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        1.ph,
        Text(
          day,
          style: AppTextStyle.normalBold12
              .copyWith(fontWeight: FontWeight.normal, color: Colors.black54),
        ),
      ],
    );
  }
}
