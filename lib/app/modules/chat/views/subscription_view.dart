import 'package:dgul_ai/app/modules/chat/controllers/chat_controller.dart';
import 'package:dgul_ai/app/modules/chat/views/subscription_detail_view.dart';
import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/app/utitls/rasset.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubscriptionView extends GetView<ChatController> {
  const SubscriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Pastikan controller sudah di-register, misal: Get.put(ChatController()) di halaman sebelumnya

    return Scaffold(
      body: Stack(
        children: [
          // Layer 1: Latar belakang biru solid
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
                // Header melengkung dengan tombol kembali
                SizedBox(
                  height: 160.h,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50.r),
                            bottomRight: Radius.circular(50.r),
                          ),
                          image: DecorationImage(
                            image: AssetImage(RAsset().bgSirkuitLight),
                            fit: BoxFit.cover,
                            opacity: 0.1,
                          ),
                        ),
                      ),
                      // Tombol Kembali
                      Positioned(
                        top: 40.h,
                        left: 10.w,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios_new,
                              color: RColor().primaryYellowColor),
                          onPressed: () => Get.back(),
                        ),
                      ),
                    ],
                  ),
                ),

                // Bagian konten utama
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 100.h),
                    child: Column(
                      children: [
                        Text(
                          "Choose Subscription",
                          style: subHeadline1TextStyle.copyWith(
                              color: RColor().primaryBlueColor,
                              fontSize: 32.sp),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "Unlock full access to smart features that help you prepare for your maritime career. Choose the plan that fits you best and level up with D'Gul AI — your Seafarer Smart Assistant.",
                          textAlign: TextAlign.center,
                          style: body2TextStyle.copyWith(
                              color: Colors.black.withOpacity(0.8)),
                        ),
                        SizedBox(height: 30.h),

                        // Pilihan Paket dibungkus dengan Obx agar reaktif
                        Obx(() => Column(
                              children: [
                                _buildSubscriptionCard(
                                  title: "1-Year",
                                  details:
                                      "Save 50% | Full Access | 8.000.000 Token",
                                  price: "Rp. 500.000,-",
                                  isSelected:
                                      controller.selectedPlan.value == "1-Year",
                                  onTap: () => controller.selectPlan("1-Year"),
                                ),
                                SizedBox(height: 20.h),
                                _buildSubscriptionCard(
                                  title: "6-Month",
                                  details:
                                      "Save 40% | Full Access | 3.000.000 Token",
                                  price: "Rp. 300.000,-",
                                  isSelected: controller.selectedPlan.value ==
                                      "6-Month",
                                  onTap: () => controller.selectPlan("6-Month"),
                                ),
                                SizedBox(height: 20.h),
                                _buildSubscriptionCard(
                                  title: "Monthly",
                                  details: "Full Access | 1.000.000 Token",
                                  price: "Rp. 100.000,-",
                                  isSelected: controller.selectedPlan.value ==
                                      "Monthly",
                                  onTap: () => controller.selectPlan("Monthly"),
                                ),
                              ],
                            )),
                        SizedBox(height: 40.h),

                        // Tombol Lanjutkan
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Logika untuk melanjutkan ke pembayaran
                              Get.to(() => SubscriptionDetailView());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: RColor().primaryBlueColor,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              side: const BorderSide(
                                  color: Colors.white, width: 2),
                            ),
                            child: Text("Continue to Purchase",
                                style: buttonTextStyle.copyWith(
                                    color: Colors.white)),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "Terms and Conditions / Privacy Policy",
                          style: body2TextStyle.copyWith(
                              fontSize: 12.sp,
                              color: Colors.white.withOpacity(0.7)),
                        ),
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

  // Widget terpisah untuk kartu langganan
  Widget _buildSubscriptionCard({
    required String title,
    required String details,
    required String price,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: RColor().primaryBlueColor,
          borderRadius: BorderRadius.circular(20.r),
          border: isSelected
              ? Border.all(color: RColor().primaryYellowColor, width: 3)
              // Gunakan warna yang lebih soft untuk border yang tidak dipilih
              : Border.all(color: Colors.white.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Column(
          children: [
            Text(title,
                style: subHeadline2TextStyle.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                details,
                textAlign: TextAlign.center,
                style: body2TextStyle.copyWith(
                    color: RColor().primaryBlueColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              price,
              style: subHeadline2TextStyle.copyWith(
                  color: RColor().primaryYellowColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
