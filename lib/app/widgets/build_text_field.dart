import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTextField(
    {required String label,
    bool isObscure = false,
    TextEditingController? controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: body1TextStyle.copyWith(color: RColor().primaryBlueColor)),
      SizedBox(height: 5.h),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15), // Warna bayangan
              spreadRadius: 1, // Seberapa jauh bayangan menyebar
              blurRadius: 5, // Tingkat keburaman bayangan
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          obscureText: isObscure,
          style: body1TextStyle.copyWith(
            color: RColor().primaryBlueColor,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,

            // Padding untuk teks di dalam field
            contentPadding:
                EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),

            // Anda juga bisa menambahkan hintText di sini
            // hintText: "Masukkan Password...",
          ),
        ),
      )
    ],
  );
}
