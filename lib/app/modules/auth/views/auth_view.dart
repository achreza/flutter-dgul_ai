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
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Layer 1: Latar Belakang Biru Gelap Solid (untuk menutupi seluruh layar)
          Container(
            color: const Color(0xFF0A183E),
          ),

          // Layer 2: Konten Utama
          Column(
            children: [
              // Bagian Atas dengan Logo dan Latar Belakang Berpola
              Expanded(
                flex: 6, // Memberi lebih banyak ruang untuk bagian atas
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(RAsset().bgDgulBlue),
                      fit: BoxFit.cover,
                      // Rata atas agar bagian atas gambar tidak terpotong
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Beri sedikit ruang dari status bar
                      SizedBox(height: 60.h),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/chat');
                        },
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // Radius yang lebih besar untuk kurva yang lebih dalam
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100.r),
                      topRight: Radius.circular(100.r),
                    ),
                    image: DecorationImage(
                      image: AssetImage(RAsset().bgSirkuitLight),
                      fit: BoxFit.cover,
                      opacity: 0.2, // Membuat pola sirkuit transparan
                    ),
                  ),
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
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                    backgroundColor: const Color(0xFF0D47A1), // Biru tua
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 16.sp,
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
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0D47A1),
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
              Text("Version 1.0 Beta", style: _footerTextStyle()),
            ],
          )
        ],
      ),
    );
  }

  // Style untuk teks footer
  TextStyle _footerTextStyle() {
    return TextStyle(
      fontSize: 12.sp,
      color: Colors.grey[600],
    );
  }
}
