// import 'package:flutter/material.dart';
// import 'package:stepcom/Widgets/back_button.dart';
// import 'package:stepcom/util/colors.dart';
// import 'package:stepcom/util/constants.dart';
// import 'package:stepcom/util/text_styles.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewPage extends StatefulWidget {
//   WebViewPage(this.webLink, {Key? key, required this.title}) : super(key: key);
//
//   @override
//   _WebViewPageState createState() => _WebViewPageState();
//
//   final String webLink;
//   final String title;
// }
//
// class _WebViewPageState extends State<WebViewPage> {
//   bool loading = true;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           const Center(child: CircularProgressIndicator()),
//           AnimatedOpacity(
//             duration: const Duration(milliseconds: 1000),
//             opacity: loading ? 0 : 1,
//             child: Column(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   color: colorDark,
//                   padding: EdgeInsets.only(
//                       top: constants.defaultPadding * 3,
//                       left: constants.defaultPadding,
//                       bottom: constants.defaultPadding,
//                       right: constants.defaultPadding),
//                   child: Row(
//                     children: [
//                       MyBackButton(
//                         color: colorWhite,
//                         padding: EdgeInsets.zero,
//                       ),
//                       SizedBox(
//                         width: constants.defaultPadding,
//                       ),
//                       Text(
//                         widget.title,
//                         style: textStyle.heading.copyWith(color: colorWhite),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Flexible(
//                 //   child: WebView(
//                 //     onWebViewCreated: (value) {
//                 //       setState(() {
//                 //         loading = false;
//                 //       });
//                 //     },
//                 //     initialUrl: widget.webLink,
//                 //     javascriptMode: JavascriptMode.unrestricted,
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> loadingTime() async {
//     await Future.delayed(const Duration(milliseconds: 500), () {
//       setState(() {
//         loading = false;
//       });
//     });
//   }
// }
