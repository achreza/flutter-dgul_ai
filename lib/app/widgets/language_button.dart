import 'package:dgul_ai/app/modules/chat/controllers/chat_controller.dart';
import 'package:dgul_ai/app/utitls/rasset.dart';
import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

Widget buildLanguageButton(BuildContext context, String language,
    String langCode, RxString selectedLanguage) {
  final ChatController controller = Get.find<ChatController>();
  bool isSelected = selectedLanguage.value == langCode;
  return OutlinedButton.icon(
    onPressed: () {
      // 1. Tutup menu popup terlebih dahulu
      Navigator.pop(context);
      // 2. Tunda perubahan bahasa ke frame berikutnya
      Future.delayed(Duration.zero, () {
        controller.changeLanguage(langCode);
      });
    },
    icon: Image.asset(
      language == "Indonesia" ? RAsset().flagIndonesia : RAsset().flagUK,
      width: 14.w,
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
      side: isSelected
          ? BorderSide(color: RColor().secondaryGreyColor, width: 1.w)
          : BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
    ),
  );
}
