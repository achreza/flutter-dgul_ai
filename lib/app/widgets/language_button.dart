import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

Widget buildLanguageButton(String language, RxString selectedLanguage) {
  bool isSelected = selectedLanguage.value == language;
  return OutlinedButton.icon(
    onPressed: () => selectedLanguage.value = language,
    icon: Image.asset(
      language == "Indonesia"
          ? "assets/images/flag_indonesia.png"
          : "assets/images/flag_uk.png",
      width: 12.w,
    ),
    label: Text(language,
        style: body2TextStyle.copyWith(
          fontSize: 14.sp,
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
