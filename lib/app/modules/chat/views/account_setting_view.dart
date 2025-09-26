import 'dart:io';

import 'package:dgul_ai/app/modules/chat/controllers/chat_controller.dart';
import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/app/utitls/rasset.dart';
import 'package:dgul_ai/app/utitls/rdatecounter.dart';
import 'package:dgul_ai/app/utitls/rformatter.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AccountSettingView extends GetView<ChatController> {
  const AccountSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Latar belakang biru gelap
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
          Positioned(
            top: 200.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.r),
                  topRight: Radius.circular(50.r),
                ),
                image: DecorationImage(
                  image: AssetImage(RAsset().bgSirkuitLight),
                  fit: BoxFit.cover,
                  opacity: 0.1,
                ),
              ),
            ),
          ),

          // Konten Utama
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Obx(() => controller.isEditMode.value
                        ? _buildEditForm()
                        : _buildViewProfile()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk Header (Tombol Kembali dan Edit/Save)
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new,
                color: RColor().primaryYellowColor),
            onPressed: () => Get.back(),
          ),
          Obx(() => TextButton.icon(
                onPressed: controller.toggleEditMode,
                icon: Icon(
                  controller.isEditMode.value ? Icons.close : Icons.edit,
                  color: Colors.white,
                  size: 18.sp,
                ),
                label: Text(
                  controller.isEditMode.value ? "Cancel" : "Edit",
                  style: body2TextStyle.copyWith(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  // Widget untuk menampilkan profil (View Mode)
  Widget _buildViewProfile() {
    return Column(
      children: [
        _buildProfilePicture(),
        SizedBox(height: 10.h),
        Text("${controller.userController.getName()}",
            style: subHeadline1TextStyle.copyWith(
                color: RColor().primaryBlueColor)),
        SizedBox(height: 25.h),
        _buildInfoRow("Email",
            "${controller.userController.profileData.user?.email ?? 'Not Set'}"),
        _buildInfoRow("Telephone",
            "${controller.userController.profileData.user?.phone ?? 'Not Set'}"),
        _buildInfoRow(
            controller.selectedWorkType.value == "Seafarer"
                ? "Type of Department"
                : "Type of Company",
            "${controller.userController.profileData.user?.department ?? 'Not Set'}"),
        _buildInfoRow("Position",
            "${controller.userController.profileData.user?.position ?? 'Not Set'}"),
        _buildInfoRow("Subscription Status",
            "${calculateDateDifferenceInDays(DateTime.now(), controller.userController.profileData.user?.subscriptionUntil ?? '${DateTime.now().toString()}')} Days"),
        _buildInfoRow("Token",
            "${RFormatter.formatToken(controller.userController.profileData.user?.token) ?? 'Not Set'}"),
        SizedBox(height: 30.h),
        Row(
          children: [
            OutlinedButton(
              onPressed: () {
                //show dialog konfirmasi delete account
                Get.defaultDialog(
                  title: "Konfirmasi",
                  middleText: "Apakah Anda yakin ingin menghapus akun ini?",
                  onConfirm: () {
                    //double check with alert dialog

                    controller.deleteAccount();
                    Get.back();
                  },
                  onCancel: () {
                    Get.back();
                  },
                );
              },
              child: Text("Delete Account",
                  style: buttonTextStyle.copyWith(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r)),
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Logout",
                    style: buttonTextStyle.copyWith(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: RColor().primaryBlueColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r)),
                    padding: EdgeInsets.symmetric(vertical: 12.h)),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  // Widget untuk mengedit profil (Edit Mode)
  Widget _buildEditForm() {
    return Column(
      children: [
        _buildProfilePicture(isEdit: true),
        SizedBox(height: 10.h),
        //create text field for name with controller nameController from chat controller
        TextFormField(
          controller: controller.nameController,
          textAlign: TextAlign.center,
          style: subHeadline1TextStyle.copyWith(
              color: RColor().primaryBlueColor, fontWeight: FontWeight.w600),
          decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 4.0)),
        ),
        SizedBox(height: 25.h),
        _buildInfoRow("Email",
            "${controller.userController.profileData.user?.email ?? ''}"),
        _buildEditableInfoRow(
            "Telephone",
            "${controller.userController.profileData.user?.phone ?? ''}",
            controller.phoneController),
        _buildEditableInfoRow(
            controller.selectedWorkType.value == "Seafarer"
                ? "Type of Department"
                : "Type of Company",
            "${controller.userController.profileData.user?.department ?? ''}",
            controller.departmentController),
        _buildEditableInfoRow(
            "Position",
            "${controller.userController.profileData.user?.position ?? ''}",
            controller.positionController),
        _buildInfoRow("Subscription Status",
            "${calculateDateDifferenceInDays(DateTime.now(), controller.userController.profileData.user?.subscriptionUntil ?? '${DateTime.now().toString()}')} Days"),
        _buildInfoRow("Token",
            "${RFormatter.formatToken(controller.userController.profileData.user?.token) ?? 'Not Set'}"),
        SizedBox(height: 30.h),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: controller.toggleEditMode, // Kembali ke view mode
                child: Text("Cancel",
                    style: buttonTextStyle.copyWith(
                        color: RColor().primaryBlueColor)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: RColor().primaryYellowColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r)),
                    padding: EdgeInsets.symmetric(vertical: 12.h)),
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  controller.updateProfile(); // Kembali ke view mode
                },
                child: Text("Save",
                    style: buttonTextStyle.copyWith(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: RColor().primaryBlueColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r)),
                    padding: EdgeInsets.symmetric(vertical: 12.h)),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  // Widget untuk foto profil
  Widget _buildProfilePicture({bool isEdit = false}) {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: RColor().primaryYellowColor,
            ),
            child: Obx(() => CircleAvatar(
                  radius: 100.r,
                  backgroundImage:
                      AssetImage(RAsset().bgSirkuitLight), // Placeholder
                  child: CircleAvatar(
                    radius: 95.r,
                    backgroundImage: controller
                            .selectedPhotoProfilePath.value.isNotEmpty
                        ? FileImage(
                            File(controller.selectedPhotoProfilePath.value))
                        : NetworkImage(
                            "${controller.userController.profileData.user?.profilePhotoUrl ?? 'https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTAxL3JtNjA5LXNvbGlkaWNvbi13LTAwMi1wLnBuZw.png'}"), // Placeholder
                  ),
                )),
          ),
          if (isEdit)
            Positioned(
              bottom: 5.h,
              right: 5.w,
              child: GestureDetector(
                onTap: () {
                  controller.selectProfilePhoto();
                },
                child: CircleAvatar(
                  radius: 18.r,
                  backgroundColor: RColor().primaryBlueColor,
                  child:
                      Icon(Icons.camera_alt, color: Colors.white, size: 20.sp),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Widget untuk baris info (View Mode)
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  body2TextStyle.copyWith(color: RColor().secondaryGreyColor)),
          Text(value,
              style: body1TextStyle.copyWith(
                  color: RColor().primaryBlueColor,
                  fontWeight: FontWeight.w600)),
          const Divider(),
        ],
      ),
    );
  }

  // Widget untuk baris info yang bisa diedit (Edit Mode)
  Widget _buildEditableInfoRow(
      String label, String initialValue, TextEditingController textController,
      {bool isEditable = true}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  body2TextStyle.copyWith(color: RColor().secondaryGreyColor)),
          isEditable
              ? TextFormField(
                  controller: textController,
                  style: body1TextStyle.copyWith(
                      color: RColor().primaryBlueColor,
                      fontWeight: FontWeight.w600),
                  decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 4.0)),
                )
              : Text(initialValue,
                  style: body1TextStyle.copyWith(
                      color: RColor().primaryBlueColor,
                      fontWeight: FontWeight.w600)),
          if (!isEditable) const Divider(),
        ],
      ),
    );
  }
}
