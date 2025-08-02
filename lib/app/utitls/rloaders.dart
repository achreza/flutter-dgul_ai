import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Enum untuk menentukan tipe dialog yang akan ditampilkan
enum DialogStatus { success, warning, failed }

class RLoaders {
  // Fungsi utama untuk menampilkan dialog
  static void showStatusDialog({
    required BuildContext context,
    required DialogStatus status,
    required String title,
    required String message,
    VoidCallback? onConfirm,
  }) {
    Get.dialog(
      _StatusDialogWidget(
        status: status,
        title: title,
        message: message,
        onConfirm: onConfirm ??
            () => Get.back(), // Tutup dialog jika tidak ada aksi lain
      ),
      barrierDismissible: false, // Pengguna harus menekan tombol OK
    );
  }
}

// Widget privat yang membangun UI dialog
class _StatusDialogWidget extends StatelessWidget {
  final DialogStatus status;
  final String title;
  final String message;
  final VoidCallback onConfirm;

  const _StatusDialogWidget({
    required this.status,
    required this.title,
    required this.message,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Konfigurasi ikon dan warna berdasarkan status
    final Map<DialogStatus, Map<String, dynamic>> statusConfig = {
      DialogStatus.success: {
        'icon': Icons.check_circle_outline,
        'gradient': const LinearGradient(
          colors: [Color(0xFF66BB6A), Color(0xFF4CAF50)], // Hijau
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      },
      DialogStatus.warning: {
        'icon': Icons.warning_amber_rounded,
        'gradient': const LinearGradient(
          colors: [Color(0xFFFFCA28), Color(0xFFFFB300)], // Kuning/Amber
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      },
      DialogStatus.failed: {
        'icon': Icons.highlight_off,
        'gradient': const LinearGradient(
          colors: [Color(0xFFEF5350), Color(0xFFE53935)], // Merah
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      },
    };

    final config = statusConfig[status]!;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lingkaran Ikon di Atas
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: config['gradient'],
                boxShadow: [
                  BoxShadow(
                    color: (config['gradient'] as LinearGradient)
                        .colors
                        .first
                        .withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Icon(
                config['icon'],
                color: Colors.white,
                size: 45.sp,
              ),
            ),
            SizedBox(height: 20.h),

            // Judul
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),

            // Pesan
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            SizedBox(height: 25.h),

            // Tombol OK
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC107), // Kuning
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                child: Text(
                  "OK",
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0D47A1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
