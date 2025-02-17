import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../api/database_api.dart';
import '../../../api/local_storage.dart';
import '../../../global.dart';
import '../../../main.dart';
import '../../../models/get_activty_by_chapter_id.dart';
import '../../../models/get_all_stories.dart';
import '../../../models/get_chapter_by_chapter_id.dart';
import '../../../models/get_chapter_by_story_id.dart';
import '../../../models/get_story_by_id.dart';
import '../../../util/colors.dart';

class ReadController {
  static RxBool backToStories = false.obs;
  // static RxBool isStampImageAndAudio = false.obs;
  // static RxBool isStampAudio = false.obs;
  static RxInt isStampShow = 1.obs;
  static RxString chapterName = ''.obs;
  static RxString chapterId = ''.obs;
  static final TextEditingController searchStoriesController = TextEditingController();


  static RxList<Map> read = <Map>[
    {"image": "icons/trending", "heading": "Mary’s Adventure"},
    {"image": "icons/trending", "heading": "Mary’s Adventure"},
    {"image": "icons/trending", "heading": "Mary’s Adventure"},
    {"image": "icons/trending", "heading": "Mary’s Adventure"},
    {"image": "icons/trending", "heading": "Mary’s Adventure"},
    {"image": "icons/trending", "heading": "Mary’s Adventure"},
    {"image": "icons/trending", "heading": "Mary’s Adventure"},
    {"image": "icons/trending", "heading": "Mary’s Adventure"},
    {"image": "icons/trending", "heading": "Mary’s Adventure"},
    {"image": "icons/trending", "heading": "Mary’s Adventure"},
    {"image": "icons/trending", "heading": "Mary’s Adventure"},
    {"image": "icons/trending", "heading": "Mary’s Adventure"},
    {"image": "icons/trending", "heading": "Mary’s Adventure"},
    {"image": "icons/trending", "heading": "Mary’s Adventure"},
    {"image": "icons/trending", "heading": "Mary’s Adventure"},
    {"image": "icons/trending", "heading": "Mary’s Adventure"},
  ].obs;
  static RxList<Map> chapter = <Map>[
    {
      "chapter": "1",
      "date": "Coming Soon!",
      "title": "",
      "image": "icons/arrowRight",
    },
    {
      "chapter": "2",
      "date": "22 Mar 2024",
      "title": "",
      "image": "icons/arrowRight",
    },
    {
      "chapter": "3",
      "date": "22 Mar 2024",
      "title": "",
      "image": "icons/arrowRight",
    },
    {
      "chapter": "4",
      "date": "22 Mar 2024",
      "title": "Side Story 2",
      "image": "icons/arrowRight",
    },
    {
      "chapter": "5",
      "date": "22 Mar 2024",
      "title": "Side Story 1",
      "image": "icons/arrowRight",
    },
    {
      "chapter": "6",
      "date": "22 Mar 2024",
      "title": "The Great Threat",
      "image": "icons/chapterRead",
    },
    {
      "chapter": "7",
      "date": "22 Mar 2024",
      "title": "",
      "image": "icons/arrowRight",
    },
    {
      "chapter": "8",
      "date": "22 Mar 2024",
      "title": "",
      "image": "icons/chapterRead",
    },
    {
      "chapter": "9",
      "date": "22 Mar 2024",
      "title": "",
      "image": "icons/chapterRead",
    },
    {
      "chapter": "10",
      "date": "22 Mar 2024",
      "title": "",
      "image": "icons/chapterRead",
    },
    {
      "chapter": "11",
      "date": "22 Mar 2024",
      "title": "",
      "image": "icons/chapterRead",
    },
    {
      "chapter": "12",
      "date": "Coming Soon!",
      "title": "",
      "image": "icons/arrowRight",
    },
    {
      "chapter": "13",
      "date": "22 Mar 2024",
      "title": "",
      "image": "icons/arrowRight",
    },
    {
      "chapter": "14",
      "date": "22 Mar 2024",
      "title": "",
      "image": "icons/arrowRight",
    },
    {
      "chapter": "15",
      "date": "22 Mar 2024",
      "title": "Side Story 2",
      "image": "icons/arrowRight",
    },
    {
      "chapter": "16",
      "date": "22 Mar 2024",
      "title": "Side Story 1",
      "image": "icons/arrowRight",
    },
    {
      "chapter": "17",
      "date": "22 Mar 2024",
      "title": "The Great Threat",
      "image": "icons/chapterRead",
    },
    {
      "chapter": "18",
      "date": "22 Mar 2024",
      "title": "",
      "image": "icons/arrowRight",
    },
    {
      "chapter": "19",
      "date": "22 Mar 2024",
      "title": "",
      "image": "icons/chapterRead",
    },
    {
      "chapter": "20",
      "date": "22 Mar 2024",
      "title": "",
      "image": "icons/chapterRead",
    },
    {
      "chapter": "21",
      "date": "22 Mar 2024",
      "title": "",
      "image": "icons/chapterRead",
    },
    {
      "chapter": "22",
      "date": "22 Mar 2024",
      "title": "",
      "image": "icons/chapterRead",
    },
  ].obs;

  // static RxList<Map> questionexam = <Map>[
  //   {
  //     "Que":
  //         'Which TWO diseases is Kevin at risk of developing if he does not make some healthier choices',
  //     "image": 'icons/bear',
  //   },
  //   {
  //     "Que":
  //         'Which of the following sounds would be an appropriate example for 40 dB?',
  //     "image": '',
  //   },
  //   {
  //     "Que":
  //         'Which TWO steps should be included in the experiment to ensure it is a fair test?',
  //     "image": 'icons/bear',
  //   },
  //   {
  //     "Que": 'Which of the materials tested were opaque?',
  //     "image": '',
  //   },
  //   {
  //     "Que": 'Which of the following statements could be TRUE?',
  //     "image": 'icons/bear',
  //   },
  //   {
  //     "Que":
  //         'In which diagram are the mirrors arranged to direct the beam from the light source onto the ball?',
  //     "image": 'icons/bear',
  //   },
  //   {
  //     "Que": 'In which area is soil degradation LEAST likely to take place?',
  //     "image": 'icons/bear',
  //   },
  //   {
  //     "Que": 'Which of the following is NOT a result of climate change?',
  //     "image": '',
  //   },
  //   {
  //     "Que":
  //         'Which of the following actions is NOT a way of reducing your carbon emissions?',
  //     "image": 'icons/bear',
  //   },
  //   {
  //     "Que":
  //         'After the people have finished their picnic, what should they do?',
  //     "image": '',
  //   }
  // ].obs;
  //
  // static RxList<List<String>> option = <List<String>>[
  //   ['malnutrition', 'obesity', 'asthma', 'diabetes'],
  //   [
  //     'Leave their trash in neat piles for the beach attendant to collect.Leave their trash in neat piles for the beach attendant to collect.Leave their trash in neat piles for the beach attendant to collect.Leave their trash in neat piles for the beach attendant to collect.',
  //     'a quiet library',
  //     'leaves rustling',
  //     'a running shower'
  //   ],
  //   [
  //     'The materials should all be of the same thickness',
  //     'The materials should all be of different thicknesses',
  //     'The flashlight should be shone from different distances',
  //     'The flashlight should be shone from the same distance'
  //   ],
  //   [
  //     'material A and material C',
  //     'material D and material E',
  //     'material B and material C',
  //     'material A and material D'
  //   ],
  //   [
  //     'Material A was clear glass and reflected the light.',
  //     'Material D was transparent and cast no shadow.',
  //     'Material C was translucent and cast a faint shadow.',
  //     'Material E was a mirror and reflected the light.'
  //   ],
  //   ['diagram I', 'diagram II.', 'diagram III.', 'diagram IV.'],
  //   ['area I.', 'area II.', 'area III.', 'area IV.'],
  //   [
  //     'increased average temperatures in countries around the world',
  //     'stronger hurricanes, like Hurricane Gilbert in Jamaica',
  //     'only 23,000 lions remaining in the wild',
  //     'melting glaciers, shrinking wildlife habitats and increased flooding'
  //   ],
  //   [
  //     'walking, cycling and using public transportation',
  //     'eating organic meat',
  //     'reusing and recycling waste',
  //     'turning off electric lights and appliances',
  //   ],
  //   [
  //     'Leave their trash in neat piles for the beach attendant to collect.Leave their trash in neat piles for the beach attendant to collect.Leave their trash in neat piles for the beach attendant to collect.Leave their trash in neat piles for the beach attendant to collect.',
  //     'Put their trash in the bushes as they leave the beach.',
  //     'Take their trash home to reuse containers, recycle.',
  //     'Drop their trash into the sea so it can float away'
  //   ],
  // ].obs;

  static RxDouble progress = 0.0.obs;
  static RxInt pdfPageNumber = 0.obs;
  static RxList chapterIdForNextPage = [].obs;
  static RxInt chapterIdIndexForNextPage = 0.obs;
  static RxString storyId = ''.obs;

  static final ScrollController controller = ScrollController();

  static void scrollToTop() {
    controller.animateTo(
      0.0, // Scroll to the top position (0.0)
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  // static RxBool singleChild = true.obs;

  ///api
  static Rx<GetStoryById> getStoriesById = GetStoryById().obs;
  static Rx<GetAllStory> getAllStoriesBy = GetAllStory().obs;

  static Future<bool> getStoryByStoriesId(String storiesId) async {
    final headers = {
      "Content-Type": "application/json",
      "UserToken": prefs.getString(LocalStorage.token).toString()
    };
    final String url =
        '${DatabaseApi.getStoriesByStoryId}$storiesId';
    customPrint("getStoryByStoryId url :: $url");
    try {
      return await http
          .get(Uri.parse(url), headers: headers)
          .then((value) async {
        print("getStoryByStoryId :: ${value.body}");
        final jsonData = jsonDecode(value.body);
        if (jsonData["status"].toString() != "true") {
          showErrorMessage(jsonData["message"].toString(), colorError);
          return false;
        }
        //showSnackbar("Subscription PlanPrice Details Added Successfully", colorSuccess);
        getStoriesById(getStoryByIdFromJson(value.body));
        return true;
      });
    } on Exception catch (e) {
      print("getStoryByStoryId:: $e");
      // showSnackbar("Some unknown error has occur, try again after some time!", colorError);
      return false;
    }
  }

  static Future<bool> getAllStory(String search) async {
    final headers = {
      "Content-Type": "application/json",
      "UserToken": '${prefs.getString(LocalStorage.token).toString()}'
    };
    final String url = '${DatabaseApi.getStories}?search=$search';
    customPrint("getAllStory url :: $url");
    try {
      return await http
          .get(Uri.parse(url), headers: headers)
          .then((value) async {
        print("getAllStory :: ${value.body}");
        final jsonData = jsonDecode(value.body);
        if (jsonData["status"].toString() != "true") {
          showErrorMessage(jsonData["message"].toString(), colorError);
          return false;
        }
        //showSnackbar("Subscription PlanPrice Details Added Successfully", colorSuccess);
        getAllStoriesBy(getAllStoryFromJson(value.body));
        return true;
      });
    } on Exception catch (e) {
      print("getAllStory:: $e");
      // showSnackbar("Some unknown error has occur, try again after some time!", colorError);
      return false;
    }
  }

  static Future getAllStoriesData(String search) async {
    await getAllStory(search).then((value) {
    });
  }
  static Future getStoriesDataById(String storyId) async {

  }



  /// chapter read unread changes in api
  // static Rx<GetChapterByStoryId> getChapterByStoryId =
  //     GetChapterByStoryId().obs;
  //
  // static Future<bool> getAllChapterByStoryId(String storyId) async {
  //   final headers = {
  //     "Content-Type": "application/json",
  //     "UserToken": '${prefs.getString(LocalStorage.token).toString()}'
  //   };
  //   final String url = '${DatabaseApi.getAllChapterByStoryId}?stories_id=$storyId';
  //   customPrint("getAllChapterByStoryId url :: $url");
  //   try {
  //     return await http
  //         .get(Uri.parse(url), headers: headers)
  //         .then((value) async {
  //       print("getAllChapterByStoryId :: ${value.body}");
  //       final jsonData = jsonDecode(value.body);
  //       if (jsonData["status"].toString() != "true") {
  //         showErrorMessage(jsonData["message"].toString(), colorError);
  //         return false;
  //       }
  //       //showSnackbar("Subscription PlanPrice Details Added Successfully", colorSuccess);
  //       getChapterByStoryId(getChapterByStoryIdFromJson(value.body));
  //       return true;
  //     });
  //   } on Exception catch (e) {
  //     print("getAllChapterByStoryId:: $e");
  //     // showSnackbar("Some unknown error has occur, try again after some time!", colorError);
  //     return false;
  //   }
  // }
  static Rx<GetChapterByStoryId> getChapterByStoryId =
      GetChapterByStoryId().obs;

  static Future<bool> getAllChapterByStoryId(String storyId) async {
    final headers = {
      "Content-Type": "application/json",
      "UserToken": '${prefs.getString(LocalStorage.token).toString()}'
    };
    final String url = '${DatabaseApi.getAllChapterByStoryId}?stories_id=$storyId';
    customPrint("getAllChapterByStoryId url :: $url");
    try {
      return await http
          .get(Uri.parse(url), headers: headers)
          .then((value) async {
        print("getAllChapterByStoryId :: ${value.body}");
        final jsonData = jsonDecode(value.body);
        if (jsonData["status"].toString() != "true") {
          showErrorMessage(jsonData["message"].toString(), colorError);
          return false;
        }
        //showSnackbar("Subscription PlanPrice Details Added Successfully", colorSuccess);
        getChapterByStoryId(getChapterByStoryIdFromJson(value.body));
        return true;
      });
    } on Exception catch (e) {
      print("getAllChapterByStoryId:: $e");
      // showSnackbar("Some unknown error has occur, try again after some time!", colorError);
      return false;
    }
  }

  static Future<bool> updateChapterReadStatus(
      BuildContext context, String chapterId, body) async {
    final String url = "${DatabaseApi.updateChapterReadStatus}$chapterId";
    final headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "UserToken": '${prefs.getString(LocalStorage.token).toString()}'
    };
    customPrint("updateChapterReadStatus Url::$url");
    customPrint("updateChapterReadStatus body::${jsonEncode(body)}");
    try {
      return await http
          .put(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: headers,
      )
          .then((value) async {
        final jsonData = jsonDecode(value.body);
        if (jsonData["status"].toString() != "true") {
          // showErrorMessage(jsonData["message"], colorError);
          customPrint("updateChapterReadStatus response :: ${value.body}");
          customPrint("updateChapterReadStatus message::${jsonData["message"]}");
          return false;
        } else {
          // showSucessMessage(jsonData["message"], colorSuccess);
        }
        customPrint("updateChapterReadStatus::${value.body}");
        return true;
      });
    } on Exception catch (e) {
      customPrint("Error :: $e");
      // showSnackbar(
      //     context,
      //     "Some unknown error has occur, try again after some time",
      //     colorError);
      return false;
    }
  }
  ///

  static Rx<GetChapterByChapterId> getChapterByChapterId =
      GetChapterByChapterId().obs;

  static Future<bool> getAllChapterByChapterId(String chapterId) async {
    final headers = {
      "Content-Type": "application/json",
      "UserToken": '${prefs?.getString(LocalStorage.token).toString()}'
    };
    final String url = '${DatabaseApi.getAllChapterByChapterId}$chapterId';
    customPrint("getAllChapterByChapterId url :: $url");
    try {
      return await http
          .get(Uri.parse(url), headers: headers)
          .then((value) async {
        print("getAllChapterByChapterId :: ${value.body}");
        final jsonData = jsonDecode(value.body);
        if (jsonData["status"].toString() != "true") {
          showErrorMessage(jsonData["message"].toString(), colorError);
          return false;
        }
        //showSnackbar("Subscription PlanPrice Details Added Successfully", colorSuccess);
        getChapterByChapterId(getChapterByChapterIdFromJson(value.body));
        return true;
      });
    } on Exception catch (e) {
      print("getAllChapterByChapterId:: $e");
      // showSnackbar("Some unknown error has occur, try again after some time!", colorError);
      return false;
    }
  }

  static Rx<GetActivityByChapterId> getActivityByChapterId =
      GetActivityByChapterId().obs;
static RxBool isActivityAvailable = false.obs;
  static Future<bool> getActivityDetailsByChapterId(String chapterId) async {
    final headers = {
      "Content-Type": "application/json",
      "UserToken": prefs.getString(LocalStorage.token).toString()
    };
    final String url = '${DatabaseApi.getActivityByChapterId}$chapterId';
    customPrint("getActivityDetailsByChapterId url :: $url");
    try {
      return await http
          .get(Uri.parse(url), headers: headers)
          .then((value) async {
        print("getActivityDetailsByChapterId :: ${value.body}");
        final jsonData = jsonDecode(value.body);
        if (jsonData["status"].toString() != "true") {
          if (jsonData["message"].toString() ==
              "No activities found for the given chapter ID") {
            showErrorMessage(
                // "We’re working on it or “Soon you will have a Story here",
                "We’re working on it or “Soon you will have a Activity here",
                colorError);
          } else {
            showErrorMessage(jsonData["message"].toString(), colorError);
          }
          isActivityAvailable(false);
          return false;
        }
        //showSnackbar("Subscription PlanPrice Details Added Successfully", colorSuccess);
        isActivityAvailable(true);
        getActivityByChapterId(getActivityByChapterIdFromJson(value.body));
        return true;
      });
    } on Exception catch (e) {
      print("getActivityDetailsByChapterId:: $e");
      isActivityAvailable(false);

      // showSnackbar("Some unknown error has occur, try again after some time!", colorError);
      return false;
    }
  }
  static Future<bool> updateCharacterUnlock(
      BuildContext context, body) async {
    final String url = "${DatabaseApi.updateChapterReadStatus}";
    final headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "UserToken": '${prefs.getString(LocalStorage.token).toString()}'
    };
    customPrint("updateCharacterUnlock Url::$url");
    customPrint("updateCharacterUnlock body::${jsonEncode(body)}");
    try {
      return await http
          .post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: headers,
      )
          .then((value) async {
        final jsonData = jsonDecode(value.body);
        if (jsonData["status"].toString() != "true") {
          // showErrorMessage(jsonData["message"], colorError);
          customPrint("updateCharacterUnlock response :: ${value.body}");
          customPrint("updateCharacterUnlock message::${jsonData["message"]}");
          return false;
        } else {
          // showSucessMessage(jsonData["message"], colorSuccess);
        }
        customPrint("updateCharacterUnlock::${value.body}");
        return true;
      });
    } on Exception catch (e) {
      customPrint("Error :: $e");
      // showSnackbar(
      //     context,
      //     "Some unknown error has occur, try again after some time",
      //     colorError);
      return false;
    }
  }
  /// data encode decode
  static String encodeApiString({required String inputString}) {
    List<int> encoded = utf8.encode(inputString);
    return encoded.toString();
  }
  static String decodeApiString({required String hexString}) {
    customPrint('decoded List before :: $hexString');
    try {
      List<int> hexValues = hexString
          .replaceAll('[', '')
          .replaceAll(']', '')
          .split(',')
          .map((e) => int.parse(e.trim()))
          .toList();
      customPrint('decoded List after:: $hexValues');

      String decoded = utf8.decode(hexValues);
      customPrint('decoded testing :: $decoded');
      return decoded;
    } catch (e) {
      print('Error decoding API string: $e');
      return 'Error decoding API string';
    }
  }
///
}
