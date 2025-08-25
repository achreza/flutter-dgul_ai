import 'package:dgul_ai/app/modules/chat/controllers/chat_controller.dart';
import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WorkTypeDialog {
  static void showWorkTypeDialog(BuildContext context, Function onAgree) {
    Get.dialog(
      _WorkTypeDialogWidget(onAgree: onAgree),
      barrierDismissible: false,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      backgroundColor: Colors.transparent,
      child: Container(
        width: 340.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: RColor().primaryBlueColor.withOpacity(0.5),
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
                // --- PERUBAHAN DI SINI ---
                // Menggunakan SingleChildScrollView yang membungkus Column
                child: SingleChildScrollView(
                  child: _buildTncContent(),
                ),
              ),
            ],
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
        return ListTile(
          title: Text(
            workType,
            style: body1TextStyle.copyWith(
                color: Colors.white, fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
          onTap: () {
            controller.selectWorkType(workType);
            Get.back();
          },
        );
      }).toList(),
    );
  }
}
