import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yokai_quiz_app/screens/badges/controller/badge_controller.dart';
import 'package:yokai_quiz_app/util/colors.dart';
import 'package:yokai_quiz_app/util/const.dart';
import 'package:yokai_quiz_app/util/text_styles.dart';

class BadgeScreen extends StatefulWidget {
  const BadgeScreen({super.key});

  @override
  State<BadgeScreen> createState() => _BadgeScreenState();
}

class _BadgeScreenState extends State<BadgeScreen> {
  @override
  void initState() {
    super.initState();
    isLoading(true);
    fetchData();
  }

  fetchData() async {
    await BadgeController.fetchAllBadges().then((value) {
      isLoading(false);
    });
  }

  RxBool isLoading = false.obs;

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
                      "Badges",
                      style:
                          AppTextStyle.normalBold20.copyWith(color: coral500),
                    ),
                  ],
                ),
              ),
              3.ph,
              buildBadgeCategory(
                title: "Share the app with your friends:",
                category: "share",
              ),
              3.ph,
              buildBadgeCategory(
                title: "Chat regularly:",
                category: "chat",
              ),
              3.ph,
              buildBadgeCategory(
                title: "Engage with Mental Health Activities:",
                category: "mentality",
              ),
              3.ph,
              buildBadgeCategory(
                title: "Complete Story Arcs:",
                category: "arcs",
              ),
              3.ph,
              buildBadgeCategory(
                title: "Just show up on Yokaizen:",
                category: "showup",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBadgeCategory({required String title, required String category}) {
    final badges = BadgeController.badges
        .where((badge) => badge['type'] == category)
        .toList();

    if (badges.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.normalBold16,
        ),
        2.ph,
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.9,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: badges.length,
          itemBuilder: (context, index) {
            final badge = badges[index];
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    badge['icon'],
                    width: 70, // Set a fixed width for the icon
                    height: 70,
                  ),
                ),
                1.ph,
                Text(
                  badge['name'],
                  style: AppTextStyle.normalBold14.copyWith(
                    fontSize: 12,
                    color: indigo700,
                  ),
                  overflow: TextOverflow.ellipsis, // Truncate if too long
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
