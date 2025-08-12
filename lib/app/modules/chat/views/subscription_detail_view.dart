import 'package:dgul_ai/app/modules/chat/controllers/chat_controller.dart';
import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/app/utitls/rasset.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubscriptionDetailView extends GetView<ChatController> {
  const SubscriptionDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data untuk metode pembayaran
    final List<String> paymentMethods = [
      RAsset().mandiri,
      RAsset().bca,
      RAsset().bni,
      RAsset().bri,
      RAsset().permata,
      RAsset().btn,
      RAsset().ovo,
      RAsset().gopay,
      RAsset().qris,
    ];

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Latar belakang biru
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

          // Latar belakang sirkuit putih dari bawah

          // Konten Utama
          SafeArea(
            child: Column(
              children: [
                // Header dengan tombol kembali
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 55.h),
                  child: Row(
                    children: [
                      IconButton(
                        icon:
                            Icon(Icons.arrow_back_ios_new, color: Colors.white),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ),
                // Konten yang bisa di-scroll
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Confirm Your Subscription",
                            style: subHeadline2TextStyle.copyWith(
                                color: RColor().primaryBlueColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        _buildSelectedPlanCard(),
                        SizedBox(height: 24.h),
                        Text("Description Plan",
                            style: body1TextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        SizedBox(height: 8.h),
                        Text("You're Almost There!",
                            style: subHeadline2TextStyle.copyWith(
                                color: Colors.black)),
                        Text("You're about to subscribe to the 1-Year Plan.",
                            style:
                                body2TextStyle.copyWith(color: Colors.black)),
                        SizedBox(height: 12.h),
                        _buildBenefitItem("Save 50%"),
                        _buildBenefitItem("Full Access for 365 days"),
                        _buildBenefitItem("Includes 8,000,000 Tokens"),
                        SizedBox(height: 16.h),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total:",
                                style: body1TextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            Text("Rp. 500.000,-",
                                style: body1TextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ],
                        ),
                        const Divider(),
                        SizedBox(height: 12.h),
                        Text(
                            "Tap \"Continue to Payment\" to activate your subscription and unlock all features.",
                            style: body2TextStyle.copyWith(
                                color: RColor().secondaryGreyColor)),
                        SizedBox(height: 24.h),
                        Text("Choose Your Payment Metod",
                            style: body1TextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: RColor().primaryBlueColor)),
                        SizedBox(height: 16.h),
                        _buildPaymentMethodsGrid(paymentMethods),
                        SizedBox(height: 30.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: RColor().primaryBlueColor,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                            ),
                            child: Text("Continue to Payment",
                                style: buttonTextStyle.copyWith(
                                    color: Colors.white)),
                          ),
                        ),
                        SizedBox(height: 20.h),
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

  Widget _buildSelectedPlanCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: RColor().primaryBlueColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.check, color: Colors.green),
              ),
              SizedBox(width: 12.w),
              Text("1-Year Plan",
                  style: subHeadline2TextStyle.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              "Save 50% | Full Access | 8.000.000 Token",
              textAlign: TextAlign.center,
              style: body2TextStyle.copyWith(
                  color: RColor().primaryBlueColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Rp. 500.000,-",
            style: subHeadline2TextStyle.copyWith(
                color: RColor().primaryYellowColor,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          const Icon(Icons.check_box, color: Colors.green),
          SizedBox(width: 8.w),
          Text(text,
              style: body2TextStyle.copyWith(
                  color: Colors.black, fontSize: 14.sp)),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodsGrid(List<String> paymentMethods) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 2.5,
      ),
      itemCount: paymentMethods.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Image.asset(
            paymentMethods[index],
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}
