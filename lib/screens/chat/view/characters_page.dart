import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yokai_quiz_app/Widgets/progressHud.dart';
import 'package:yokai_quiz_app/global.dart';
import 'package:yokai_quiz_app/screens/chat/view/characters_details_page.dart';
import 'package:yokai_quiz_app/util/colors.dart';
import 'package:yokai_quiz_app/util/const.dart';
import 'package:yokai_quiz_app/util/text_styles.dart';

import '../../../Widgets/searchbar.dart';
import '../../../api/database_api.dart';
import '../../home/controller/home_controller.dart';
import '../controller/chat_controller.dart';
import 'messaging_page.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading(true);
    fetchCharactersData();
  }

  fetchCharactersData() async {
    await ChatController.getAllCharacters('').then(
      (value) async {
        await ChatController.getUnlockCharacters('').then(
          (value) {
            isLoading(false);
          },
        );
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
          body: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Characters',
                  style:
                      AppTextStyle.normalBold20.copyWith(color: headingColour),
                ),
                2.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          ChatController.isBrowseOrChats(true);
                          ChatController.charactersSearch.clear();
                          isLoading(true);
                          await ChatController.getAllCharacters('').then(
                            (value) async {
                              isLoading(false);
                            },
                          );
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: (ChatController.isBrowseOrChats.isTrue)
                                ? indigo700
                                : colorWhite,
                            boxShadow: [
                              if (ChatController.isBrowseOrChats.isTrue)
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                            ],
                            border: Border.all(color: indigo700),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              bottomLeft: Radius.circular(40),
                            ),
                          ),
                          child: Text(
                            'Browse',
                            style: AppTextStyle.normalBold14.copyWith(
                                color: (ChatController.isBrowseOrChats.isTrue)
                                    ? colorWhite
                                    : indigo700),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          ChatController.isBrowseOrChats(false);
                          ChatController.charactersSearch.clear();
                          isLoading(true);
                          await ChatController.getUnlockCharacters('').then(
                            (value) {
                              isLoading(false);
                            },
                          );
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: (ChatController.isBrowseOrChats.isFalse)
                                ? indigo700
                                : colorWhite,
                            boxShadow: [
                              if (ChatController.isBrowseOrChats.isFalse)
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                            ],
                            border: Border.all(color: indigo700),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                          ),
                          child: Text(
                            'My Chats',
                            style: AppTextStyle.normalBold14.copyWith(
                                color: (ChatController.isBrowseOrChats.isFalse)
                                    ? colorWhite
                                    : indigo700),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                3.ph,
                CustomSearchBar(
                    controller: ChatController.charactersSearch,
                    onTextChanged: (p0) async {
                      if (ChatController.isBrowseOrChats.isTrue) {
                        await ChatController.getAllCharacters(p0).then(
                          (value) {},
                        );
                      } else {
                        await ChatController.getUnlockCharacters(p0).then(
                          (value) {},
                        );
                      }
                    }),
                // if (ChatController.isBrowseOrChats.isTrue) 4.ph,
                if (ChatController.isBrowseOrChats.isTrue)
                  ((ChatController.getAllCharactersModel.value.data?.length ??
                              0) >
                          0)
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 0.9,
                            crossAxisSpacing: 0.1,
                            mainAxisSpacing: 5,
                            mainAxisExtent: 100,
                          ),
                          itemCount: ChatController
                              .getAllCharactersModel.value.data?.length,
                          itemBuilder: (context, index) {
                            print(
                                "getAllCharactersModel length :: ${ChatController.getAllCharactersModel.value.data?.length}");
                            return GestureDetector(
                              onTap: () {
                                ChatController
                                    .backToCharactersForCharactersDetails(true);
                                HomeController.backToHomeFromCharactersDetails(
                                    false);
                                nextPage(
                                  CharactersDetailsPage(
                                    characterId: ChatController
                                            .getAllCharactersModel
                                            .value
                                            .data?[index]
                                            .id
                                            .toString() ??
                                        '',
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(35),
                                        // half of the height/width
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "${DatabaseApi.mainUrlImage}${ChatController.getAllCharactersModel.value.data?[index].characterImage.toString() ?? ''}",
                                          placeholder: (context, url) =>
                                              const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CircularProgressIndicator(),
                                            ],
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            decoration: const BoxDecoration(
                                                color: AppColors.red),
                                            child: const Icon(
                                              Icons.error_outline,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          height: 70,
                                          width: 70,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SvgPicture.asset(
                                        'icons/lock.svg',
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    ChatController.getAllCharactersModel.value
                                            .data?[index].name
                                            .toString() ??
                                        '',
                                    style: AppTextStyle.normalBold10
                                        .copyWith(color: indigo700),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('No Data Found'),
                        ),
                if (ChatController.isBrowseOrChats.isFalse)
                  if (ChatController
                      .getUnlockCharactersModel.value.data!.isEmpty)
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          2.ph,
                          Text(
                            'Unlock a character to start chatting ! ',
                            style: AppTextStyle.normalSemiBold16
                                .copyWith(color: dateGrey),
                          ),
                          Image.asset(
                            'icons/unlock.png',
                            // width: screenSize.width,
                          ),
                        ],
                      ),
                    ),
                // if (ChatController.isBrowseOrChats.isFalse) 2.ph,
                if (ChatController.isBrowseOrChats.isFalse)
                  if ((ChatController
                              .getUnlockCharactersModel.value.data?.length ??
                          0) >
                      0)
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: ChatController
                            .getUnlockCharactersModel.value.data?.length,
                        itemBuilder: (context, index) {
                          ///
                          // // Parse the UTC time string into a DateTime object
                          // DateTime utcDateTime = DateTime.parse(ChatController
                          //             .getUnlockCharactersModel
                          //             .value
                          //             .data?[index]
                          //             .lastMessageTime
                          //             .toString() ??
                          //         '')
                          //     .toUtc();
                          //
                          // // Convert the DateTime from UTC to local time
                          // DateTime localDateTime = utcDateTime.toLocal();
                          //
                          // // Format the local DateTime
                          // String formattedTime =
                          //     DateFormat('h:mm a').format(localDateTime);

                          ///

                          return GestureDetector(
                            onTap: () {
                              // nextPage(const MessagingPage(
                              //   name: ChatController.chatList[index]['heading'],
                              //   image: ChatController.chatList[index]['image'],
                              // ));
                              ///
                              nextPage(MessagingPage(
                                name: ChatController.getUnlockCharactersModel
                                        .value.data?[index].name
                                        .toString() ??
                                    '',
                                image: ChatController.getUnlockCharactersModel
                                        .value.data?[index].characterImage
                                        .toString() ??
                                    '',
                                characterId: ChatController
                                        .getUnlockCharactersModel
                                        .value
                                        .data?[index]
                                        .id
                                        .toString() ??
                                    '',
                              ));
                              // nextPage(Testing());
                            },
                            child: Column(
                              children: [
                                if (index == 0)
                                  const Divider(
                                    color: primaryColorLite,
                                    thickness: 1,
                                  ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(35),
                                      // half of the height/width
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "${DatabaseApi.mainUrlImage}${ChatController.getUnlockCharactersModel.value.data?[index].characterImage.toString() ?? ''}",
                                        placeholder: (context, url) =>
                                            const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CircularProgressIndicator(),
                                          ],
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          decoration: const BoxDecoration(
                                              color: AppColors.red),
                                          child: const Icon(
                                            Icons.error_outline,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        height: 45,
                                        width: 45,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    // Image.asset(
                                    //     '${ChatController.chatList[index]['image']}.png'),
                                    1.pw,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                ChatController
                                                        .getUnlockCharactersModel
                                                        .value
                                                        .data?[index]
                                                        .name
                                                        .toString() ??
                                                    '',
                                                style: AppTextStyle
                                                    .normalSemiBold14
                                                    .copyWith(color: blueName),
                                              ),
                                              Text(
                                                // '12:29 PM',
                                                // "${((ChatController.getUnlockCharactersModel.value.data?[index].lastMessageTime.toString() ?? '') != 'null') ? formattedTime : ''}",
                                                ChatController
                                                            .getUnlockCharactersModel
                                                            .value
                                                            .data?[index]
                                                            .lastMessageTime !=
                                                        null
                                                    ? DateFormat('h:mm a')
                                                        .format(ChatController
                                                            .getUnlockCharactersModel
                                                            .value
                                                            .data![index]
                                                            .lastMessageTime!)
                                                    : '',
                                                style: AppTextStyle
                                                    .normalRegular12
                                                    .copyWith(
                                                        color: bordercolor),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            ((ChatController
                                                                .getUnlockCharactersModel
                                                                .value
                                                                .data?[index]
                                                                .latestMessage
                                                                .toString() ??
                                                            '')
                                                        .length >
                                                    33)
                                                ? '${((ChatController.getUnlockCharactersModel.value.data?[index].latestMessage) != null) ? "${((ChatController.getUnlockCharactersModel.value.data?[index].latestMessage.toString() ?? '').substring(0, 33))}..." : ''}'
                                                : ((ChatController
                                                                .getUnlockCharactersModel
                                                                .value
                                                                .data?[index]
                                                                .latestMessage
                                                                .toString() ??
                                                            '') !=
                                                        'null')
                                                    ? (ChatController
                                                            .getUnlockCharactersModel
                                                            .value
                                                            .data?[index]
                                                            .latestMessage
                                                            .toString() ??
                                                        '')
                                                    : '',
                                            // 'Last message text Last message last mess .....',
                                            style: AppTextStyle.normalRegular12
                                                .copyWith(color: bordercolor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: primaryColorLite,
                                  thickness: 1,
                                ),
                              ],
                            ),
                          );
                        },
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
