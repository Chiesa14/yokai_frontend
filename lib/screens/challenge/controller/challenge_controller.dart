import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:yokai_quiz_app/api/database_api.dart';
import 'package:http/http.dart' as http;
import 'package:yokai_quiz_app/global.dart';
import 'package:yokai_quiz_app/screens/Authentication/controller/auth_screen_controller.dart';
import 'package:yokai_quiz_app/util/colors.dart';

class ChallengeController {
  static RxBool backToChallenge = false.obs;

  static RxList<Map> challenges = <Map>[
    {
      "image": "icons/books.png",
      "heading": "Complete 2 Quizes",
      "badge": "Kodama",
      "isActive": 0,
      "isCompleted": 5
    },
    {
      "image": "icons/books.png",
      "heading": "Complete 2 Quizes",
      "badge": "Kodama",
      "isActive": 0,
      "isCompleted": 5
    },
    {
      "image": "icons/books.png",
      "heading": "Complete 2 Quizes",
      "badge": "Kodama",
      "isActive": 0,
      "isCompleted": 5
    },
    {
      "image": "icons/books.png",
      "heading": "Complete 2 Quizes",
      "badge": "Kodama",
      "isActive": 0,
      "isCompleted": 3
    },
    {
      "image": "icons/books.png",
      "heading": "Complete 2 Quizes",
      "badge": "Kodama",
      "isActive": 1,
      "isCompleted": 3
    },
    {
      "image": "icons/books.png",
      "heading": "Complete 2 Quizes",
      "badge": "Kodama",
      "isActive": 2,
      "isCompleted": 4
    },
    {
      "image": "icons/books.png",
      "heading": "Complete 3 Quizes",
      "badge": "Kodama",
      "isActive": 1,
      "isCompleted": 3
    },
    {
      "image": "icons/books.png",
      "heading": "Complete 3 Quizes",
      "badge": "Kodama",
      "isActive": 3,
      "isCompleted": 3
    },
    {
      "image": "icons/books.png",
      "heading": "Complete 3 Quizes",
      "badge": "Kodama",
      "isActive": 3,
      "isCompleted": 3
    },
  ].obs;

  static RxBool isChallengeOrComplaint = true.obs;
  static RxBool isReceivedOrSent = false.obs;

  static RxList<Map> complaints = <Map>[
    {
      "image": "images/stamp1.png",
      "badge": "Kodama (Tree Spirit)",
      "isSent": false,
    },
    {
      "image": "images/stamp1.png",
      "badge": "Tengu (Mountain Spirit)",
      "isSent": true,
    },
    {
      "image": "images/stamp1.png",
      "badge": "Kodama (Tree Spirit)",
      "isSent": false,
    },
    {
      "image": "images/stamp1.png",
      "badge": "Kodama (Tree Spirit)",
      "isSent": true,
    },
    {
      "image": "images/stamp1.png",
      "badge": "Zashiki-warashi (House Spirit)",
      "isSent": false,
    },
    {
      "image": "images/stamp1.png",
      "badge": "Kodama (Tree Spirit)",
      "isSent": true,
    },
    {
      "image": "images/stamp1.png",
      "badge": "Zashiki-warashi (House Spirit)",
      "isSent": false,
    },
    {
      "image": "images/stamp1.png",
      "badge": "Kodama (Tree Spirit)",
      "isSent": true,
    },
    {
      "image": "images/stamp1.png",
      "badge": "Zashiki-warashi (House Spirit)",
      "isSent": false,
    },
    {
      "image": "images/stamp1.png",
      "badge": "Kodama (Tree Spirit)",
      "isSent": true,
    },
    {
      "image": "images/stamp1.png",
      "badge": "Tengu (Mountain Spirit)",
      "isSent": false,
    },
    {
      "image": "images/stamp1.png",
      "badge": "Zashiki-warashi (House Spirit)",
      "isSent": true,
    },
    {
      "image": "images/stamp1.png",
      "badge": "Kodama (Tree Spirit)",
      "isSent": false,
    },
    {
      "image": "images/stamp1.png",
      "badge": "Zashiki-warashi (House Spirit)",
      "isSent": true,
    },
  ].obs;

  static Future<bool> fetchChallenges() async {
    final headers = {
      "Content-Type": "application/json",
    };

    try {
      String url = DatabaseApi.getChallenges;

      final response = await http.get(Uri.parse(url), headers: headers);
      final jsonData = jsonDecode(response.body);

      String userLogs =
          "${DatabaseApi.getUserLogs}${AuthScreenController.userId}";

      if (jsonData["status"].toString() != "true") {
        customPrint("fetchAllChallenges response :: ${response.body}");
        customPrint("fetchAllChallenges message::${jsonData["message"]}");
        return false;
      } else {
        final inviteResponse =
            await http.get(Uri.parse(userLogs), headers: headers);
        final inviteJsonData = jsonDecode(inviteResponse.body);

        List<dynamic> challengesData = jsonData["data"];
        List<dynamic> inviteData = inviteJsonData["data"];
        int loginCount = inviteData[0]["login_count"] ?? 0;

        List<dynamic> filteredChallenges = challengesData.where((task) {
          return task['badge_type'] != 'invite' ||
              task['badge_type'] != 'share';
        }).toList();

        customPrint("fetchAllChallenges:::${filteredChallenges.toString()}");
        customPrint("Count::$loginCount");

        if (filteredChallenges.isNotEmpty) {
          challenges.clear();
          for (var challenge in filteredChallenges) {
            challenges.add({
              'image': challenge['badge_image_path'],
              'badge': challenge['badge_name'],
              'heading': challenge['name'],
              'isCompleted': challenge['badge_step_count'],
              'isActive': challenge['badge_type'] == 'login' ? loginCount : 0,
            });
          }
        }
        return true;
      }
    } on Exception catch (e) {
      customPrint("Error :: $e");
      showErrorMessage("Failed to fetch mood data.", colorError);
      return false;
    }
  }

  static Future<bool> fetchComplaints() async {
    final headers = {
      "Content-Type": "application/json",
    };

    try {
      String url = DatabaseApi.getComplaints;

      final response = await http.get(Uri.parse(url), headers: headers);
      final jsonData = jsonDecode(response.body);

      if (jsonData["status"].toString() != "true") {
        customPrint("fetchAllComplaints response :: ${response.body}");
        customPrint("fetchAllComplaints message::${jsonData["message"]}");
        return false;
      } else {
        customPrint("fetchAllComplaints:::${jsonData.toString()}");
        List<dynamic> complaintsData = jsonData["data"];
        if (complaintsData.isNotEmpty) {
          complaints.clear();
          for (var complaint in complaintsData) {
            complaints.add({
              'image': complaint['yokai_image'],
              'badge': complaint['title'],
              'isSent': false,
            });
          }
        }
        return true;
      }
    } on Exception catch (e) {
      customPrint("Error :: $e");
      showErrorMessage("Failed to fetch mood data.", colorError);
      return false;
    }
  }
}
