import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yokai_quiz_app/Widgets/progressHud.dart';
import 'package:yokai_quiz_app/global.dart';
import 'package:yokai_quiz_app/screens/home/view/home_screen.dart';
import 'package:yokai_quiz_app/screens/navigation/view/navigation.dart';
import 'package:yokai_quiz_app/screens/read/view/chapter_page.dart';
import 'package:yokai_quiz_app/util/colors.dart';
import 'package:yokai_quiz_app/util/const.dart';
import 'package:yokai_quiz_app/util/constants.dart';

import '../../../Widgets/second_custom_button.dart';
import '../../../api/database_api.dart';
import '../../../util/text_styles.dart';
import '../../chat/controller/chat_controller.dart';
import '../../home/controller/home_controller.dart';
import '../controller/read_controller.dart';

class OpenStoryPage extends StatefulWidget {
  String storyId;

  OpenStoryPage({super.key, required this.storyId});

  @override
  State<OpenStoryPage> createState() => _OpenStoryPageState();
}

class _OpenStoryPageState extends State<OpenStoryPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RxBool isLoadingStoryOpen = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customPrint('storyId :: ${widget.storyId}');
    HomeController.backToHomeChapter(false);
    isLoadingStoryOpen(true);
    ReadController.getStoryByStoriesId(widget.storyId).then((value) {
      isLoadingStoryOpen(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NavigationPage(index: 1)));
        return false;
      },
      child: Obx(() {
        return ProgressHUD(
          isLoading: isLoadingStoryOpen.value,
          child: Scaffold(
            backgroundColor: colorWhite,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        height: screenSize.height / 1.2,
                        width: screenSize.width,
                        child: Column(
                          children: [
                            // Image.network(
                            //   // 'icons/storyCover.png',
                            //   '${DatabaseApi.mainUrlImage}${ReadController.getStoriesById.value.data?.storiesImage.toString() ?? ''}',
                            //   fit: BoxFit.fill,
                            //   // fit: BoxFit.cover,
                            //   height: screenSize.height / 1.5,
                            //   width: double.infinity,
                            // ),
                            CachedNetworkImage(
                              imageUrl:
                                  "${DatabaseApi.mainUrlImage}${ReadController.getStoriesById.value.data?.storiesImage.toString() ?? ''}",
                              // placeholder: (context, url) => CircularProgressIndicator(),
                              placeholder: (context, url) => const Padding(
                                padding: EdgeInsets.all(
                                    constants.defaultPadding * 2),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(),
                                  ],
                                ),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: AppColors.black,
                              ),
                              fit: BoxFit.fill,
                              // fit: BoxFit.cover,
                              height: screenSize.height / 1.5,
                              width: double.infinity,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // height: screenSize.height / 3,
                        width: screenSize.width,
                        decoration: const BoxDecoration(
                          color: colorWhite,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              2.ph,
                              Text(
                                ReadController.getStoriesById.value.data?.name
                                        .toString() ??
                                    '',
                                style: AppTextStyle.normalBold16
                                    .copyWith(color: coral500),
                              ),
                              2.ph,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${ReadController.getStoriesById.value.data?.chapterCount.toString() ?? ''} Chapters',
                                    style: AppTextStyle.normalBold10
                                        .copyWith(color: greyCh),
                                  ),
                                  Text(
                                    '${ReadController.getStoriesById.value.data?.activityCount.toString() ?? ''} Activities',
                                    style: AppTextStyle.normalBold10
                                        .copyWith(color: greyCh),
                                  ),
                                  Text(
                                    'Unlock Character',
                                    style: AppTextStyle.normalBold10
                                        .copyWith(color: greyCh),
                                  ),
                                ],
                              ),
                              2.ph,
                              Text(
                                // 'Mary, a seemingly ordinary girl, stumbles upon a hidden portal in her attic. Thrown into a realm of fantastical creatures and whispered legends, Mary discovers a hidden magic within herself. Now, she must navigate this wondrous yet perilous world, unravel the secrets of her own power, and find a way back home!',
                                ReadController
                                        .getStoriesById.value.data?.discription
                                        .toString() ??
                                    '',
                                style: AppTextStyle.normalBold12
                                    .copyWith(color: grey2),
                              ),
                              3.ph,
                              SecondCustomButton(
                                  width: screenSize.width / 2,
                                  iconSvgPath: 'icons/readNow.svg',
                                  text: "Read Now",
                                  onPressed: () {
                                    nextPageFade(ChapterPage(
                                      storyId: widget.storyId,
                                      storyName: ReadController
                                              .getStoriesById.value.data?.name
                                              .toString() ??
                                          '',
                                    ));
                                  }),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 15,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NavigationPage(index: 0)));
                          },
                          child: SvgPicture.asset(
                            'icons/arrowLeft1.svg',
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
