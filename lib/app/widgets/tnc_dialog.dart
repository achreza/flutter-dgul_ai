import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TncDialogHelper {
  static void showTncDialog(BuildContext context) {
    Get.dialog(
      const _TncDialogWidget(),
      barrierDismissible: false,
    );
  }
}

class _TncDialogWidget extends StatelessWidget {
  const _TncDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      backgroundColor: Colors.transparent,
      child: Container(
        height: 550.h, // Atur tinggi dialog
        child: Stack(
          children: [
            // Layer 2: Konten Putih di bawah
            Container(
              margin: EdgeInsets.only(top: 40.h), // Beri ruang untuk header
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  SizedBox(height: 50.h), // Jarak dari atas konten ke teks
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: _buildTncContent(),
                    ),
                  ),
                  _buildAcceptButton(),
                ],
              ),
            ),
            // Layer 1: Header Biru di atas
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80.h,
                decoration: BoxDecoration(
                  color: RColor().primaryBlueColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Text(
                    "Term and Conditions",
                    style: subHeadline1TextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 28.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTncContent() {
    // Ganti tanggal ini sesuai kebutuhan
    String effectiveDate = "4 Agustus 2025";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "D'Gul AI – Maritime Artificial Intelligence\nEffective Date: [$effectiveDate]",
          style: body2TextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Text(
          "Welcome to D'Gul AI! By accessing or using this application, you agree to the following terms and conditions. Please read them carefully.",
          style: body2TextStyle,
        ),
        SizedBox(height: 16.h),
        _buildSectionTitle("1. General Use"),
        Text(
          "D'Gul AI is an AI-based maritime assistant designed to support seafarers in preparing for their careers. Users must be at least 17 years old or have parental consent.",
          style: body2TextStyle,
        ),
        SizedBox(height: 16.h),
        _buildSectionTitle("2. Account Registration"),
        Text(
          "To use premium features, users must register and provide accurate information. You are responsible for maintaining the confidentiality of your account credentials.",
          style: body2TextStyle,
        ),
        SizedBox(height: 16.h),
        _buildSectionTitle("3. Subscription and Payment"),
        _buildListItem(
            "Subscription plans are available monthly, semi-annually, or annually."),
        _buildListItem(
            "Payment is required upfront and is non-refundable once activated."),
        _buildListItem("Access includes token allocations that vary per plan."),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Text(
        title,
        style: body1TextStyle.copyWith(fontWeight: FontWeight.bold),
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
          Expanded(child: Text(text, style: body2TextStyle)),
        ],
      ),
    );
  }

  Widget _buildAcceptButton() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => Get.back(),
          style: ElevatedButton.styleFrom(
            backgroundColor: RColor().primaryYellowColor,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.r),
            ),
          ),
          child: Text("Accept",
              style:
                  buttonTextStyle.copyWith(color: RColor().primaryBlueColor)),
        ),
      ),
    );
  }
}
