import 'package:dgul_ai/app/modules/auth/views/login_view.dart';
import 'package:dgul_ai/app/modules/auth/views/register_view.dart';
import 'package:dgul_ai/app/utitls/rasset.dart';
import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  AuthView({Key? key}) : super(key: key);
  var controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Layer 1: Latar Belakang Biru Gelap Solid (untuk menutupi seluruh layar)
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(RAsset().bgStart),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Column(
            children: [
              // Bagian Atas dengan Logo dan Latar Belakang Berpola
              Expanded(
                flex: 6, // Memberi lebih banyak ruang untuk bagian atas
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(RAsset().bgStart),
                      fit: BoxFit.cover,
                      // Rata atas agar bagian atas gambar tidak terpotong
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          RAsset().logoDgulAi,
                          width: 250.w,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bagian Bawah dengan Kartu Putih
              Expanded(
                flex: 4, // Porsi lebih kecil untuk kartu putih
                child: Container(
                  width: double.infinity,
                  child: _buildAuthCard(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget untuk konten di dalam kartu putih
  Widget _buildAuthCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40.h),
          Text(
            "Maritime\nSmart Assistant",
            textAlign: TextAlign.center,
            style: subHeadline1TextStyle.copyWith(
              color: RColor().primaryBlueColor,
              fontWeight: FontWeight.w400,
              height: 1.0,
            ),
          ),
          SizedBox(height: 30.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tombol Register
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => RegisterView());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RColor().primaryBlueColor, // Biru tua
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              // Tombol Login
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => LoginView());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107), // Kuning
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h),
          // Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Help", style: _footerTextStyle()),
              Text("About Us", style: _footerTextStyle()),
              Text("Version 1.0", style: _footerTextStyle()),
            ],
          )
        ],
      ),
    );
  }

  // Style untuk teks footer
  TextStyle _footerTextStyle() {
    return TextStyle(
      fontSize: 14.sp,
      color: Colors.grey[600],
    );
  }
}
