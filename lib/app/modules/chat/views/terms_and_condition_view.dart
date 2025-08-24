import 'package:dgul_ai/app/modules/chat/controllers/chat_controller.dart';
import 'package:dgul_ai/app/modules/chat/views/subscription_detail_view.dart';
import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/app/utitls/rasset.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TermsAndConditionView extends GetView<ChatController> {
  const TermsAndConditionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(RAsset().bgRounded),
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
              ),
            ),
          ),

          // Layer 2: Konten utama
          SafeArea(
            child: Column(
              children: [
                // Header dengan tombol kembali

                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new,
                            color: RColor().primaryYellowColor),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ),
                // Konten yang bisa di-scroll
                SizedBox(
                  height: 110.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        Text(
                          "Terms and Conditions",
                          style: subHeadline1TextStyle.copyWith(
                              color: RColor().primaryBlueColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 36.sp),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "By subscribing to D'Gul AI, you agree to the following:",
                          style: body1TextStyle.copyWith(
                              color: RColor().secondaryGreyColor),
                        ),
                        SizedBox(height: 8.h),

                        // Daftar Pertanyaan dan Jawaban (FAQ)
                        _buildFaqItem(
                          question: "1. Subscription Access",
                          answer:
                              "You will receive full access to D'Gul AI features for the duration of your chosen plan (30, 180, or 360 days)",
                        ),
                        _buildFaqItem(
                          question: "2. Token Usage",
                          answer:
                              "Each plan includes a specific number of tokens. Token balance is non-transferable and valid only during the active subscription period.",
                        ),
                        _buildFaqItem(
                          question: "3. Payments & Refunds",
                          answer:
                              "All payments are final. No refunds will be issued once access is granted.",
                        ),
                        _buildFaqItem(
                          question: "4. Account Responsibility",
                          answer:
                              "You are responsible for keeping your login credentials secure. Misuse may result in account suspension.",
                        ),
                        _buildFaqItem(
                          question: "5. Service Availability",
                          answer:
                              "We strive for uninterrupted service but do not guarantee 100% uptime due to possible maintenance or system issues.",
                        ),
                        _buildFaqItem(
                          question: "6. Changes to Terms",
                          answer:
                              "We reserve the right to update these terms at any time. Continued use implies acceptance of the new terms",
                        ),

                        SizedBox(height: 40.h),
                        Center(
                          child: Text(
                            "Terms and Conditions / Privacy Policy",
                            style: body2TextStyle.copyWith(
                                fontSize: 12.sp,
                                color: RColor().secondaryGreyColor),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem({required String question, required String answer}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: body1TextStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: RColor().primaryBlueColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            answer,
            style: body2TextStyle.copyWith(color: RColor().secondaryGreyColor),
          ),
        ],
      ),
    );
  }
}
