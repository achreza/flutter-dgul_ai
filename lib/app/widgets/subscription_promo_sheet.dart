import 'package:dgul_ai/app/utitls/rasset.dart';
import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../modules/chat/views/subscription_view.dart';

class SubscriptionPromoSheet {
  static void show() {
    Get.bottomSheet(
      const _SubscriptionPromoSheetWidget(),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      isScrollControlled: true, // Penting agar bisa menyesuaikan tinggi
    );
  }
}

class _SubscriptionPromoSheetWidget extends StatelessWidget {
  const _SubscriptionPromoSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header dengan Judul dan Tombol Close
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 40), // Spacer agar judul di tengah
              Text(
                "Choose Subscription",
                style: subHeadline2TextStyle.copyWith(
                  color: RColor().primaryBlueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                  onTap: () => Get.back(), child: Image.asset(RAsset().silang))
            ],
          ),
          SizedBox(height: 20.h),

          // Kartu Paket Pilihan
          _buildSelectedPlanCard(),
          SizedBox(height: 8.h),

          // Tombol Lihat Semua Paket
          TextButton(
            onPressed: () {
              // Navigasi ke halaman semua paket
              Get.to(() => SubscriptionView());
            },
            child: Text(
              "Lihat Semua Paket Berlangganan",
              style: body2TextStyle.copyWith(
                color: RColor().primaryBlueColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          const Divider(),
          SizedBox(height: 20.h),

          // Bagian Free Trial
          Text(
            "Start Your Free Trial Now!",
            style: subHeadline2TextStyle.copyWith(
              color: RColor().primaryBlueColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Get 10,000 FREE Tokens and limited access to D'Gul AI features.",
            textAlign: TextAlign.center,
            style: body2TextStyle.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Text(
            "Try it first and see the power of smart assistance before subscribing fully!",
            textAlign: TextAlign.center,
            style: body2TextStyle.copyWith(
                color: Colors.black, fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 20.h),

          // Tombol Free Trial
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Logika untuk memulai free trial
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: RColor().primaryYellowColor,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Start Free Trial",
                    style: body2TextStyle.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text("— Get 10,000 Tokens!",
                      style: buttonTextStyle.copyWith(color: Colors.black)),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h),
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
              Image.asset(RAsset().centang),
              Spacer(),
              Text("1-Month",
                  style: subHeadline2TextStyle.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              Spacer(),
              CircleAvatar(
                backgroundColor: RColor().primaryBlueColor,
                child: Icon(
                  Icons.check,
                  color: RColor().primaryBlueColor,
                  size: 18.sp,
                ),
              ),
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
}
