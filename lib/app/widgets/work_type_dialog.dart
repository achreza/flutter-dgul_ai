import 'dart:ui';

import 'package:dgul_ai/app/modules/chat/controllers/chat_controller.dart';
import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class WorkTypeDialog {
  static void showWorkTypeDialog(BuildContext context, Function onAgree) {
    Get.dialog(
      _WorkTypeDialogWidget(onAgree: onAgree),
      barrierDismissible: true,
    );
  }
}

// Mengubah menjadi StatefulWidget untuk mengelola state checkbox
class _WorkTypeDialogWidget extends StatefulWidget {
  const _WorkTypeDialogWidget({Key? key, required this.onAgree})
      : super(key: key);

  final Function onAgree;

  @override
  State<_WorkTypeDialogWidget> createState() => _WorkTypeDialogWidgetState();
}

class _WorkTypeDialogWidgetState extends State<_WorkTypeDialogWidget> {
  // State untuk melacak status checkbox
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      backgroundColor: HexColor("#12356BB2").withOpacity(0.7),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 5, sigmaY: 5), // 🔑 blur hanya area dialog
          child: Container(
            width: 340.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: HexColor("#12356BB2")
                  .withOpacity(0.15), // semi transparan biar blur kelihatan
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Konten T&C dalam container terpisah
                  Container(
                    height: 600.h,
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding: EdgeInsets.all(10.w),
                    child: SingleChildScrollView(
                      child: _buildTncContent(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- FUNGSI INI DIPERBARUI ---
  Widget _buildTncContent() {
    ChatController controller = Get.find<ChatController>();
    // Menggunakan Column karena parent-nya sudah SingleChildScrollView
    return Column(
      children: controller.maritimeWorkTypes.map((workType) {
        return GestureDetector(
            onTap: () {
              controller.selectWorkType(workType);
              Get.back();
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // supaya tinggi row ikut teks
                children: [
                  Container(
                    height: 23.h,
                    width: 23.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.selectedWorkType.value == workType
                          ? RColor().primaryBlueColor
                          : Colors.grey,
                      border: Border.all(color: Colors.white, width: 2.w),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    // 🔑 supaya teks bisa wrap
                    child: Text(
                      workType,
                      style: body1TextStyle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                      textAlign: TextAlign.start,
                      softWrap: true,
                      maxLines: null,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ));
      }).toList(),
    );
  }
}
