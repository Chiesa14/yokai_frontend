import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:yokai_quiz_app/Widgets/progressHud.dart';
import 'package:yokai_quiz_app/global.dart';
import 'package:yokai_quiz_app/screens/Authentication/controller/auth_screen_controller.dart';
import 'package:yokai_quiz_app/screens/Settings/view/setting_screen.dart';
import 'package:yokai_quiz_app/screens/badges/controller/badge_controller.dart';
import 'package:yokai_quiz_app/screens/badges/view/badge_screen.dart';
import 'package:yokai_quiz_app/screens/mood%20tracker/controller/mood_controller.dart';
import 'package:yokai_quiz_app/screens/mood%20tracker/view/mood_tracker_screen.dart';
import 'package:yokai_quiz_app/screens/profile/controller/profile_controller.dart';
import 'package:yokai_quiz_app/screens/stamps/view/stamps_screen.dart';
import 'package:yokai_quiz_app/util/colors.dart';
import 'package:yokai_quiz_app/util/const.dart';
import 'package:yokai_quiz_app/util/text_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedEmojiIndex = 2;
  final List<String> emojiGifs = [
    'images/angry.gif',
    'images/sad.gif',
    'images/neutral.gif',
    'images/good.gif',
    'images/awesome.gif',
  ];
  final List<String> emotions = ['Angry', 'Sad', 'Neutral', 'Good', 'Awesome'];

  @override
  void initState() {
    super.initState();
    ProfileController.isLoading(true);
    fetchInfoData();
  }

  fetchInfoData() async {
    AuthScreenController.fetchData().then((value) async {
      ProfileController.userName(
          AuthScreenController.getProfileModel.value.user?.name ?? "");
      ProfileController.userId(
          AuthScreenController.getProfileModel.value.user?.userId ?? 1);
      await BadgeController.fetchAllBadges()
          .then((value) => {ProfileController.isLoading(false)});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ProgressHUD(
        isLoading: ProfileController.isLoading.value,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: 200,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/bgProfile.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Profile',
                        style: AppTextStyle.normalBold20
                            .copyWith(color: indigo950),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFBAF3D), Color(0xFFFFF372)],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: Text(
                          'Upgrade',
                          style: AppTextStyle.normalBold12
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(top: 200),
                    color: Colors.white,
                    child: Column(
                      children: [
                        10.ph,
                        Text(
                          ProfileController.userName.value,
                          style: AppTextStyle.normalBold16
                              .copyWith(color: textDarkGrey),
                        ),
                        4.ph,
                        Text(
                          'Hey, how are you feeling today!',
                          style: AppTextStyle.normalBold16
                              .copyWith(color: indigo700),
                        ),
                        2.ph,
                        SizedBox(
                          height: 90,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: emojiGifs.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedEmojiIndex = index;
                                  });
                                  final body = {
                                    "user_id": ProfileController.userId.value
                                        .toString(),
                                    "mood_level": "0.8",
                                    "mood_gif": index
                                  };
                                  MoodController.addOrUpdateMood(context, body);
                                },
                                child: Container(
                                  width: 90,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        emojiGifs[index],
                                        height: 60,
                                        width: 60,
                                      ),
                                      if (index == selectedEmojiIndex)
                                        Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          height: 4,
                                          width: 4,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Colors.purple,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Text(
                          emotions[selectedEmojiIndex],
                          style: AppTextStyle.normalBold18.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        3.ph,
                        OptionItem(
                          iconPath: 'icons/mood.png',
                          title: 'Mood Tracker',
                          handleTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MoodTrackerScreen(),
                              ),
                            );
                          },
                        ),
                        OptionItem(
                          iconPath: 'icons/insights.png',
                          title: 'Personality Insights',
                          handleTap: () {},
                        ),
                        OptionItem(
                          iconPath: 'icons/badges.png',
                          title: 'Badges',
                          handleTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BadgeScreen(),
                              ),
                            );
                          },
                        ),
                        OptionItem(
                          iconPath: 'icons/stamps.png',
                          title: 'Stamps',
                          handleTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const StampScreen()));
                          },
                        ),
                        OptionItem(
                          iconPath: 'icons/settings.png',
                          title: 'Settings',
                          handleTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingScreen(),
                              ),
                            );
                          },
                        ),
                        3.ph,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: Text(
                                  'Privacy Policy',
                                  style: AppTextStyle.normalBold12.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Text(
                                  'Terms & Conditions',
                                  style: AppTextStyle.normalBold12.copyWith(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        3.ph,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  left: MediaQuery.of(context).size.width / 2 -
                      60, // Center horizontally
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 1,
                          spreadRadius: 10,
                          color: coral100,
                        ),
                      ],
                      color: Colors.white,
                      border: Border.all(color: coral500),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('images/profile.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class OptionItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final Function handleTap;

  const OptionItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.handleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: GestureDetector(
        onTap: () => handleTap(),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 252, 245, 255),
            border: Border.all(color: indigo300),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Image.asset(
              iconPath,
              height: 40,
              width: 40,
            ),
            title: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            trailing: SvgPicture.asset('icons/arrow3.svg'),
          ),
        ),
      ),
    );
  }
}
