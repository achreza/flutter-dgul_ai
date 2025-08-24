import 'package:dgul_ai/app/modules/chat/controllers/chat_controller.dart';
import 'package:dgul_ai/app/modules/chat/views/subscription_detail_view.dart';
import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/app/utitls/rasset.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HelpAndSupportView extends GetView<ChatController> {
  const HelpAndSupportView({Key? key}) : super(key: key);

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
                          "Help & Support",
                          style: subHeadline1TextStyle.copyWith(
                              color: RColor().primaryBlueColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 40.sp),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "Need assistance? We're here to help!",
                          style: body1TextStyle.copyWith(
                              color: RColor().secondaryGreyColor),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Common Questions:",
                          style: body1TextStyle.copyWith(
                              color: RColor().primaryBlueColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20.h),

                        // Daftar Pertanyaan dan Jawaban (FAQ)
                        _buildFaqItem(
                          question: "1. How do I subscribe?",
                          answer:
                              "Choose your preferred plan, tap \"Continue to Purchase,\" and complete the payment process.",
                        ),
                        _buildFaqItem(
                          question: "2. What are tokens used for?",
                          answer:
                              "Tokens are used to access AI-powered features and tools available in the app.",
                        ),
                        _buildFaqItem(
                          question: "3. Can I upgrade my plan later?",
                          answer:
                              "Yes! You can upgrade anytime by selecting a higher plan.",
                        ),
                        _buildFaqItem(
                          question:
                              "4. What happens if my subscription expires?",
                          answer:
                              "Your access to premium features and remaining tokens will be paused until you renew your plan.",
                        ),
                        _buildFaqItem(
                          question: "5. Who can I contact for support?",
                          answer:
                              "Email us at: support@dgulai.com\nWhatsApp: +62 8XXXXXXXXXX (if available)",
                        ),

                        SizedBox(height: 20.h),

                        // Ikon Headset
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: RColor().primaryYellowColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: RColor()
                                      .primaryYellowColor
                                      .withOpacity(0.5),
                                  blurRadius: 15,
                                  spreadRadius: 3,
                                )
                              ],
                            ),
                            child: Icon(
                              Icons.headset_mic,
                              color: RColor().primaryBlueColor,
                              size: 100.sp,
                            ),
                          ),
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
