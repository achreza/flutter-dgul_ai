import 'dart:ui';

import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TncDialogHelper {
  static void showTncDialog(BuildContext context, Function onAgree) {
    Get.dialog(
      Material(
        // 🔑 biar transparan tapi tetap bisa render blur
        type: MaterialType.transparency,
        child: _TncDialogWidget(onAgree: onAgree),
      ),
      barrierColor:
          Colors.black.withOpacity(0), // penting → jangan pakai warna solid
      barrierDismissible: true,
    );
  }
}

// Mengubah menjadi StatefulWidget untuk mengelola state checkbox
class _TncDialogWidget extends StatefulWidget {
  const _TncDialogWidget({Key? key, required this.onAgree}) : super(key: key);

  final Function onAgree;

  @override
  State<_TncDialogWidget> createState() => _TncDialogWidgetState();
}

class _TncDialogWidgetState extends State<_TncDialogWidget> {
  // State untuk melacak status checkbox
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 10), // 🔑 blur background
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
        backgroundColor: RColor().primaryBlueColor.withOpacity(0.7),
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Judul
                Text(
                  "Terms and Conditions",
                  style: subHeadline1TextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 28.sp,
                  ),
                ),
                SizedBox(height: 15.h),

                // Konten T&C dalam container terpisah
                Container(
                  height: 600.h,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: SingleChildScrollView(
                    child: _buildTncContent(),
                  ),
                ),
                SizedBox(height: 15.h),

                // Checkbox persetujuan
                _buildAgreementCheckbox(),
                SizedBox(height: 15.h),

                // Tombol Agree
                _buildAgreeButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTncContent() {
    String effectiveDate = "24 Agustus 2025";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "D'Gul AI – Maritime Artificial Intelligence\nEffective Date: [$effectiveDate]",
          style: body2TextStyle.copyWith(
              fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 8.h),
        Text(
          "Welcome to D'Gul AI! By accessing or using this application, you agree to the following terms and conditions. Please read them carefully.",
          style: body2TextStyle.copyWith(color: Colors.black),
        ),
        SizedBox(height: 16.h),
        _buildSectionTitle("1. General Use"),
        Text(
          "D'Gul AI is an AI-based maritime assistant designed to support seafarers in preparing for their careers. Users must be at least 17 years old or have parental consent.",
          style: body2TextStyle.copyWith(color: Colors.black),
        ),
        SizedBox(height: 16.h),
        _buildSectionTitle("2. Account Registration"),
        Text(
          "To use premium features, users must register and provide accurate information. You are responsible for maintaining the confidentiality of your account credentials.",
          style: body2TextStyle.copyWith(color: Colors.black),
        ),
        SizedBox(height: 16.h),
        _buildSectionTitle("3. Subscription and Payment"),
        _buildListItem(
            "Subscription plans are available monthly, semi-annually, or annually."),
        _buildListItem(
            "Payment is required upfront and is non-refundable once activated."),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Text(
        title,
        style: body1TextStyle.copyWith(
            fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ", style: body2TextStyle),
          Expanded(
              child: Text(text,
                  style: body2TextStyle.copyWith(color: Colors.black))),
        ],
      ),
    );
  }

  Widget _buildAgreementCheckbox() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Gunakan SizedBox untuk membuat Checkbox lebih kecil

          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              "By checking this box, you agree to the Terms and Conditions",
              textAlign: TextAlign.center,
              style:
                  body2TextStyle.copyWith(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgreeButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ElevatedButton(
        onPressed: () {
          // Tombol selalu aktif, tetapi hanya menutup jika checkbox dicentang

          Get.back();
          widget.onAgree();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: RColor().primaryYellowColor,
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Membuat Row seukuran isinya
          children: [
            Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.check,
                color: RColor().primaryBlueColor,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 16.w),
            // Teks "Agree"
            Text("Agree",
                style:
                    buttonTextStyle.copyWith(color: RColor().primaryBlueColor)),
            SizedBox(width: 12.w), // Beri sedikit ruang di kanan
          ],
        ),
      ),
    );
  }
}
