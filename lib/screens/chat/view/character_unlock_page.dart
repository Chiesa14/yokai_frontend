import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:yokai_quiz_app/Widgets/progressHud.dart';
import 'package:yokai_quiz_app/global.dart';
import 'package:yokai_quiz_app/util/colors.dart';
import 'package:yokai_quiz_app/util/const.dart';

import '../../../Widgets/second_custom_button.dart';
import '../../../api/database_api.dart';
import '../../../util/text_styles.dart';
import '../../read/controller/read_controller.dart';
import '../../read/view/congratulation_page.dart';
import '../controller/chat_controller.dart';
import 'messaging_page.dart';

class CharacterUnlockPage extends StatefulWidget {
  String characterName;
  String characterImage;
  String characterId;
  String? score;
  String length;

  CharacterUnlockPage(
      {super.key,
      required this.characterName,
      required this.characterImage,
      required this.length,
       this.score,
      required this.characterId});

  @override
  State<CharacterUnlockPage> createState() => _CharacterUnlockPageState();
}

class _CharacterUnlockPageState extends State<CharacterUnlockPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading(true);
    fetchCharactersNyIdData();
  }

  fetchCharactersNyIdData() async {
    await ChatController.getCharactersById(widget.characterId).then(
      (value) {
        final body={
          "character_id": widget.characterId
        };
        ReadController.updateCharacterUnlock(context, body).then((value) {
          isLoading(false);

        },);
      },
    );
  }

  RxBool isLoading = false.obs;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Obx(() {
      return ProgressHUD(
        isLoading: isLoading.value,
        child: Scaffold(
          backgroundColor: colorWhite,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 20, left: 20, bottom: 16, top: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  3.ph,
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Get.back();
                          nextPageOff(
                              context,
                              CongratulationPage(
                                length: widget.length,
                                score: widget.score,
                              ));
                        },
                        child: SvgPicture.asset(
                          'icons/arrowLeft.svg',
                          height: 35,
                          width: 35,
                        ),
                      ),
                      1.pw,
                      Text(
                        // 'Healthy Coping Mechanisms Quiz',
                        'Character Unlocked',
                        style:
                            AppTextStyle.normalBold16.copyWith(color: coral500),
                      ),
                    ],
                  ),
                  // Center(
                  //   child: Text(
                  //     'Healthy Coping Mechanisms Quiz',
                  //     style: AppTextStyle.normalBold16.copyWith(color: coral500),
                  //   ),
                  // ),
                  5.ph,
                  Stack(
                    children: [
                      Positioned(
                        child: Lottie.asset('assets/rightansanimation.json'),
                      ),
                      Center(
                        child: Column(
                          children: [
                            // Image.asset(
                            //   'icons/gemma2.png',
                            //   height: 200,
                            //   width: 200,
                            // ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(150),
                              // half of the height/width
                              child: CachedNetworkImage(
                                imageUrl:
                                    "${DatabaseApi.mainUrlImage}${widget.characterImage}",
                                placeholder: (context, url) => const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(),
                                  ],
                                ),
                                errorWidget: (context, url, error) => Container(
                                  decoration:
                                      const BoxDecoration(color: AppColors.red),
                                  child: const Icon(
                                    Icons.error_outline,
                                    color: AppColors.black,
                                  ),
                                ),
                                height: 200,
                                width: 200,
                                fit: BoxFit.fill,
                              ),
                            ),
                            // SvgPicture.asset('icons/cong.svg', height: 160, width: 160),
                            4.ph,
                            Text(
                              "${widget.characterName}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: "Montserrat",
                                fontSize: 20,
                                color: headingColour,
                              ),
                            ),
                            6.ph,
                            Text(
                              // "Hey there!\n'm ${widget.characterName}, your AI buddy who's always up for a chat,\na laugh, or a good dose of motivation.",
                              "Introduction : ${ChatController.getCharactersByIdModel.value.data?.introducation.toString() ?? ''}",
                              style: AppTextStyle.normalRegular12
                                  .copyWith(color: grey2),
                            ),
                            // 4.ph,
                            // Text(
                            //   // "I'm like your best friend who's always learning\n(and let's be honest, sometimes messing up ), but hey,\nthat's how we grow, right?\nSo, what's on your mind today?",
                            //   ChatController
                            //       .getCharactersByIdModel.value.data?.requirements
                            //       .toString() ??
                            //       '',
                            //   style: AppTextStyle.normalRegular12
                            //       .copyWith(color: grey2),
                            // ),
                            10.ph,
                            SecondCustomButton(
                              onPressed: () {
                                ChatController.isBrowseOrChats(false);
                                nextPage(MessagingPage(
                                  image: widget.characterImage,
                                  name: widget.characterName,
                                  characterId: widget.characterId,
                                ));
                              },
                              width: screenSize.width / 2,
                              iconSvgPath: 'icons/arrowRight.svg',
                              text: "Start Chat",
                              textSize: 14,
                            ),

                            ///
                            // 3.ph,
                            // (ReadController.chapterIdIndexForNextPage.value == 0)
                            //     ? SecondCustomButton(
                            //   onPressed: () async {
                            //     nextPageOff(
                            //         context,
                            //         NavigationPage(
                            //           index: 1,
                            //         ));
                            //   },
                            //   width: screenSize.width / 2,
                            //   iconSvgPath: 'icons/arrowRight.svg',
                            //   text: "Read Another Story",
                            //   textSize: 14,
                            // )
                            //     : SecondCustomButton(
                            //   onPressed: () async {
                            //     // print('chapterIdIndexForNextPage : minus');
                            //     // final int? index;
                            //     // if (ReadController.chapterIdIndexForNextPage.value +
                            //     //         1 >=
                            //     //     (ReadController.getChapterByStoryId.value
                            //     //             .data?[0].chapterData!.length ??
                            //     //         0)) {
                            //     //   // index = ReadController
                            //     //   //         .chapterIdIndexForNextPage.value -
                            //     //   //     1;
                            //     //   index = 0;
                            //     //   ReadController.chapterIdIndexForNextPage(0);
                            //     //   // ReadController.chapterIdIndexForNextPage(ReadController.chapterIdIndexForNextPage.value+1);
                            //     //   customPrint('chapterIdIndexForNextPage : minus');
                            //     //   customPrint(
                            //     //       'chapterIdIndexForNextPage : ${ReadController.chapterIdIndexForNextPage.value}');
                            //     //   customPrint(
                            //     //       'chapterIdIndexForNextPage : ${ReadController.getChapterByStoryId.value.data?[0].chapterData!.length}');
                            //     // } else {
                            //     //   index = ReadController
                            //     //           .chapterIdIndexForNextPage.value +
                            //     //       1;
                            //     //   ReadController.chapterIdIndexForNextPage(
                            //     //       ReadController
                            //     //               .chapterIdIndexForNextPage.value +
                            //     //           1);
                            //     //   customPrint('chapterIdIndexForNextPage : plus');
                            //     //   customPrint(
                            //     //       'chapterIdIndexForNextPage : ${ReadController.chapterIdIndexForNextPage.value}');
                            //     //   customPrint(
                            //     //       'chapterIdIndexForNextPage : ${ReadController.getChapterByStoryId.value.data?[0].chapterData!.length}');
                            //     // }
                            //     // nextPage(ReadStoriesPage(
                            //     //   // chapter: ReadController.chapter[index]['chapter'],
                            //     //
                            //     //   chapterId: ReadController.getChapterByStoryId
                            //     //           .value.data?[0].chapterData?[index].id
                            //     //           .toString() ??
                            //     //       '',
                            //     //   storyName: ReadController.getChapterByStoryId
                            //     //           .value.data?[0].chapterData?[index].name
                            //     //           .toString() ??
                            //     //       '',
                            //     // ));
                            //     customPrint(
                            //         'chapterIdIndexForNextPage og :: ${ReadController.chapterIdIndexForNextPage.value}');
                            //     customPrint(
                            //         'getChapterByStoryId length :: ${ReadController.getChapterByStoryId.value.data?.chapterData!.length}');
                            //
                            //     ///new update code
                            //     final int? index;
                            //     if (ReadController.chapterIdIndexForNextPage.value +
                            //         1 >=
                            //         (ReadController.getChapterByStoryId.value
                            //             .data?.chapterData!.length ??
                            //             0)) {
                            //       index = ReadController
                            //           .chapterIdIndexForNextPage.value +
                            //           1;
                            //       ReadController.chapterIdIndexForNextPage(
                            //           ReadController.chapterIdIndexForNextPage
                            //               .value +
                            //               1);
                            //       customPrint(
                            //           'chapterIdIndexForNextPage : plus');
                            //       customPrint(
                            //           'chapterIdIndexForNextPage : ${ReadController.chapterIdIndexForNextPage.value}');
                            //       customPrint(
                            //           'chapterIdIndexForNextPage : ${ReadController.getChapterByStoryId.value.data?.chapterData!.length}');
                            //
                            //       nextPage(ReadStoriesPage(
                            //         // chapter: ReadController.chapter[index]['chapter'],
                            //
                            //         chapterId: ReadController
                            //             .getChapterByStoryId
                            //             .value
                            //             .data
                            //             ?.chapterData?[index]
                            //             .id
                            //             .toString() ??
                            //             '',
                            //         storyName: ReadController
                            //             .getChapterByStoryId
                            //             .value
                            //             .data
                            //             ?.chapterData?[index]
                            //             .name
                            //             .toString() ??
                            //             '',
                            //       ));
                            //     } else {
                            //       index = ReadController
                            //           .chapterIdIndexForNextPage.value -
                            //           1;
                            //       ReadController.chapterIdIndexForNextPage(
                            //           ReadController.chapterIdIndexForNextPage
                            //               .value -
                            //               1);
                            //       customPrint(
                            //           'chapterIdIndexForNextPage : minus');
                            //       customPrint(
                            //           'chapterIdIndexForNextPage : ${ReadController.chapterIdIndexForNextPage.value}');
                            //       customPrint(
                            //           'chapterIdIndexForNextPage : ${ReadController.getChapterByStoryId.value.data?.chapterData!.length}');
                            //
                            //       nextPage(ReadStoriesPage(
                            //         // chapter: ReadController.chapter[index]['chapter'],
                            //
                            //         chapterId: ReadController.getChapterByStoryId
                            //             .value
                            //             .data
                            //             ?.chapterData?[index]
                            //             .id
                            //             .toString() ??
                            //             '',
                            //         storyName: ReadController
                            //             .getChapterByStoryId
                            //             .value
                            //             .data
                            //             ?.chapterData?[index]
                            //             .name
                            //             .toString() ??
                            //             '',
                            //       ));
                            //     }
                            //   },
                            //   width: screenSize.width / 2,
                            //   iconSvgPath: 'icons/arrowRight.svg',
                            //   text: "Next Chapter",
                            //   textSize: 14,
                            // ),
                            ///
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ),
    );
    });
  }
}
