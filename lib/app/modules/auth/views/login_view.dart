import 'package:dgul_ai/app/modules/auth/controllers/auth_controller.dart';
import 'package:dgul_ai/app/modules/chat/views/chat_view.dart';
import 'package:dgul_ai/app/utitls/rasset.dart';
import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/app/widgets/build_button.dart';
import 'package:dgul_ai/app/widgets/build_text_field.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Asumsi file ini berisi semua variabel yang Anda berikan

class LoginView extends GetView<AuthController> {
  LoginView({Key? key}) : super(key: key);
  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    // Controller sederhana untuk state UI
    final RxString selectedRole = 'Seafarer'.obs;
    final RxString selectedLanguage = 'Indonesia'.obs;

    return Scaffold(
      body: Stack(
        children: [
          // Layer 1: Latar Belakang Biru
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(RAsset().bgRounded),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          // Layer 2: Konten Utama
          Column(
            children: [
              // Bagian Atas dengan Logo
              SizedBox(
                height: 260.h,
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: Image.asset(
                      RAsset().logoDgulAi,
                      width: 220.w,
                    ),
                  ),
                ),
              ),
              // Bagian Bawah dengan Form
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25.h),
                      Center(
                        child: Text(
                          "Login",
                          style: subHeadline1TextStyle.copyWith(
                              color: RColor().primaryBlueColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 40.sp),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      BuildTextField(
                          label: "Email Address",
                          controller: controller.emailController),
                      SizedBox(height: 15.h),
                      BuildTextField(
                          label: "Password",
                          isObscure: true,
                          controller: controller.passwordController),
                      SizedBox(height: 20.h),
                      SizedBox(height: 30.h),
                      buildButton(
                        label: "Login",
                        onPressed: () {
                          controller.login();
                        },
                      ),
                      SizedBox(height: 15.h),
                      // _buildGoogleLoginrButton(),
                      Spacer(),
                      _buildFooter(),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRadioOption(
      {required String title,
      required String value,
      required RxString groupValue}) {
    return Container(
      height: 50.h,
      child: RadioListTile<String>(
        title: Text(title,
            style: body2TextStyle.copyWith(
              color: RColor().primaryBlueColor,
              fontWeight: FontWeight.bold,
            )),
        value: value,
        groupValue: groupValue.value,
        onChanged: (val) {
          if (val != null) {
            groupValue.value = val;
          }
        },
        activeColor: RColor().primaryBlueColor,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildLanguageButton(String language, RxString selectedLanguage) {
    bool isSelected = selectedLanguage.value == language;
    return OutlinedButton.icon(
      onPressed: () => selectedLanguage.value = language,
      icon: Image.asset(
        language == "Indonesia"
            ? "assets/images/flag_indonesia.png"
            : "assets/images/flag_uk.png",
        width: 24.w,
      ),
      label: Text(language,
          style: body2TextStyle.copyWith(
            color: isSelected
                ? RColor().primaryBlueColor
                : RColor().secondaryGreyColor,
          )),
      style: OutlinedButton.styleFrom(
        foregroundColor: RColor().primaryBlueColor,
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: RColor().primaryBlueColor,
          width: isSelected ? 2 : 0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
    );
  }

  Widget _buildGoogleLoginrButton() {
    final AuthController controller = Get.find<AuthController>();
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          controller.signInWithGoogle();
        },
        icon: Image.asset("assets/images/google_logo.png", height: 20.h),
        label: Text("Login With Google",
            style: buttonTextStyle.copyWith(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: RColor().primaryBlueColor,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Help",
            style: body2TextStyle.copyWith(color: RColor().secondaryGreyColor)),
        Text("About Us",
            style: body2TextStyle.copyWith(color: RColor().secondaryGreyColor)),
        Text("Version 1.0 Beta",
            style: body2TextStyle.copyWith(color: RColor().secondaryGreyColor)),
      ],
    );
  }
}
