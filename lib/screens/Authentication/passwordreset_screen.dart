import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yokai_quiz_app/util/colors.dart';
import 'package:yokai_quiz_app/util/const.dart';

import '../../Widgets/new_button.dart';
import '../../Widgets/textfield.dart';
import '../../util/text_styles.dart';

class PasswordResetScreen extends StatefulWidget {
  PasswordResetScreen({super.key, required this.studentid});
  String studentid;

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  bool isShow = true;
  bool isShowConiform = true;

  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double screenHeight = mediaQueryData.size.height;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth / 3,
                      right: screenWidth / 3.5,
                      top: screenHeight / 8),
                  child: Container(
                    // width: 150,
                    width: screenWidth / 1.6,
                    // height: 95,
                    height: screenHeight / 8.1,
                    // decoration: const BoxDecoration(
                    //   image: DecorationImage(
                    //     image: AssetImage('images/appLogo_small.png'),
                    //     // fit: BoxFit.cover,
                    //   ),
                    //
                    // ),
                    child: Image.asset('images/appLogo_yokai.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Text(
                  'Reset Your Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: headingOrange,
                    fontSize: 28,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'New Password',
                style: AppTextStyle.normalRegular14.copyWith(color: labelColor),
              ),
              0.5.ph,
              TextFeildStyle(
                onChanged: (value) {
                  _validatePassword(value);
                },
                obscureText: isShow,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isShow = !isShow;
                    });
                  },
                  icon: SvgPicture.asset(
                    isShow
                        ? "icons/closepasswordeye_icon.svg"
                        : "icons/password.svg",
                    color: primaryColor,
                  ),
                ),
                controller: PasswordController,
                height: 50,
                textAlignVertical: TextAlignVertical.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: greyborder),
                ),
                hintText: 'New password',
                hintStyle:
                    AppTextStyle.normalRegular10.copyWith(color: hintText),
                border: InputBorder.none,
              ),
              if (_errorText != null)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 3,
                  ),
                  child: Text(
                    _errorText!,
                    style: TextStyle(
                        color: Colors.red, fontSize: 10, fontFamily: "Raleway"),
                  ),
                ),
              2.ph,
              Text(
                'Confirm Password',
                style: AppTextStyle.normalRegular14.copyWith(color: labelColor),
              ),
              0.5.ph,
              TextFeildStyle(
                onChanged: (p0) {
                  validateConfirmPass(p0);
                },
                obscureText: isShowConiform,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isShowConiform = !isShowConiform;
                    });
                  },
                  icon: SvgPicture.asset(
                    isShowConiform
                        ? "icons/closepasswordeye_icon.svg"
                        : "icons/password.svg",
                    color: primaryColor,
                  ),
                ),
                controller: confirmPasswordController,
                height: 50,
                textAlignVertical: TextAlignVertical.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: greyborder),
                ),
                hintText: 'Confirm Password',
                hintStyle:
                    AppTextStyle.normalRegular10.copyWith(color: hintText),
                border: InputBorder.none,
              ),
              if (_errorTextconfirmpass != null)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 3,
                  ),
                  child: Text(
                    _errorTextconfirmpass!,
                    style: TextStyle(
                        color: Colors.red, fontSize: 10, fontFamily: "Raleway"),
                  ),
                ),
              25.ph,
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 5, top: 5),
                child: CustomButton(
                    // iconSvgPath: 'icons/forward_icon.svg',
                    text: "Go To Login",
                    onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _errorTextconfirmpass;
  String? _errorText;

  void _validatePassword(String value) {
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    var passNonNullValue = value ?? "";
    if (passNonNullValue.isEmpty) {
      setState(() {
        _errorText = "Password is required";
      });
    } else if (!regex.hasMatch(passNonNullValue)) {
      setState(() {
        _errorText =
            "Password should contain at least one uppercase letter,\none digit, and one special character";
      });
    } else if (passNonNullValue.length < 8) {
      setState(() {
        _errorText = "Password must be at least 8 characters long";
      });
    } else {
      setState(() {
        _errorText = null;
      });
    }
  }

  void validateConfirmPass(String value) {
    var passNonNullValue = value ?? "";
    if (passNonNullValue.isEmpty) {
      setState(() {
        _errorTextconfirmpass = "Please enter re-password";
      });
    } else if (PasswordController.value.text !=
        confirmPasswordController.value.text) {
      setState(() {
        _errorTextconfirmpass = "Password Do not match";
      });
    } else {
      setState(() {
        _errorTextconfirmpass = null;
      });
    }
  }
}
