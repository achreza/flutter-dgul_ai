import 'dart:ui';

import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

final String apiBaseUrlLawas = 'https://dgulai.linkantara.com/api';
final String apiBaseUrl = 'https://dgul-ai.ruangpelaut.com/api';

var headlineTextStyle = GoogleFonts.jaldi(
  fontSize: 55.sp,
  fontWeight: FontWeight.bold,
  color: RColor().primaryBlueColor,
);

var subHeadline1TextStyle = GoogleFonts.jaldi(
    fontSize: 45.sp, fontWeight: FontWeight.w600, height: 1.0);

var subHeadline2TextStyle = GoogleFonts.jaldi(
  fontSize: 30.sp,
  fontWeight: FontWeight.w500,
);

var subHeadline3TextStyle = GoogleFonts.jaldi(
  fontSize: 25.sp,
  fontWeight: FontWeight.w400,
);

var buttonTextStyle = GoogleFonts.jaldi(
  fontSize: 24.sp,
  fontWeight: FontWeight.w500,
);

var body1TextStyle = GoogleFonts.jaldi(
  fontSize: 20.sp,
  fontWeight: FontWeight.w400,
);

var body2TextStyle = GoogleFonts.jaldi(
  fontSize: 18.sp,
  fontWeight: FontWeight.w400,
);
