import 'dart:ui';

import 'package:dgul_ai/app/modules/chat/controllers/chat_controller.dart';
import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TncDialogHelper {
  static void showTncDialog(BuildContext context, Function onAgree) {
    Get.dialog(
      Material(
        type: MaterialType.transparency,
        child: _TncDialogWidget(onAgree: onAgree),
      ),
      barrierColor: Colors.black.withOpacity(0.1),
      barrierDismissible: true,
    );
  }
}

class _TncDialogWidget extends StatefulWidget {
  const _TncDialogWidget({Key? key, required this.onAgree}) : super(key: key);

  final Function onAgree;

  @override
  State<_TncDialogWidget> createState() => _TncDialogWidgetState();
}

class _TncDialogWidgetState extends State<_TncDialogWidget> {
  final RxBool isAgreed = false.obs;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
        backgroundColor: RColor().primaryBlueColor.withOpacity(0.85),
        child: SizedBox(
          width: 340.w,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Terms and Conditions",
                  style: subHeadline1TextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 28.sp,
                  ),
                ),
                SizedBox(height: 15.h),
                Container(
                  height: 550.h,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: SingleChildScrollView(
                    child: _buildTncContent(),
                  ),
                ),
                SizedBox(height: 15.h),
                _buildAgreementCheckbox(),
                SizedBox(height: 15.h),
                _buildAgreeButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- KONTEN BARU DARI DOKUMEN ---
  Widget _buildTncContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Terakhir Diperbarui: 8 September 2025",
          style: body2TextStyle.copyWith(
              color: RColor().secondaryGreyColor, fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 12.h),
        Text(
          "Dengan mengunduh, mendaftar, atau menggunakan Layanan kami, Anda menyatakan telah membaca, memahami, dan menyetujui untuk terikat pada seluruh Ketentuan ini serta Kebijakan Privasi kami.",
          style: body2TextStyle.copyWith(color: Colors.black),
        ),
        SizedBox(height: 20.h),
        _buildSectionTitle("Pasal 1: Definisi"),
        _buildSectionContent(
            "Aplikasi: Perangkat lunak “D’Gul Maritime AI” beserta situs dan layanan terkait.\nPengguna: Setiap orang atau badan hukum yang menggunakan Aplikasi.\nLayanan: Fitur utama Aplikasi seperti Informasi, Edukasi, dan Komunikasi."),
        _buildSectionTitle("Pasal 2: Kelayakan dan Akun Pengguna"),
        _buildSectionContent(
            "Anda menjamin bahwa informasi pendaftaran benar dan Anda cakap secara hukum (minimal 18 tahun). Anda bertanggung jawab penuh atas keamanan akun Anda."),
        _buildSectionTitle("Pasal 3: Hak Kekayaan Intelektual"),
        _buildSectionContent(
            "Seluruh hak atas Aplikasi adalah milik PT. Ruang Pelaut Indonesia. Dengan mengunggah konten, Anda memberikan kami lisensi untuk menggunakan konten tersebut dalam rangka penyediaan Layanan."),
        _buildSectionTitle("Pasal 4: Perilaku Pengguna"),
        _buildSectionContent(
            "Anda dilarang mengunggah konten yang melanggar hukum, SARA, pornografi, ujaran kebencian, atau mengandung malware."),
        _buildSectionTitle("Pasal 5: SANGGAHAN PENTING TERKAIT KONTEN AI"),
        _buildSectionContent(
            "Konten yang dihasilkan AI HANYA UNTUK TUJUAN INFORMASI UMUM dan BUKAN NASIHAT PROFESIONAL. VERIFIKASI MANDIRI terhadap sumber resmi adalah WAJIB sebelum mengambil tindakan."),
        _buildSectionTitle("Pasal 6: Layanan Berbayar"),
        _buildSectionContent(
            "Aplikasi mungkin menawarkan fitur premium berbayar. Pembayaran diproses melalui pihak ketiga dan langganan dapat diperpanjang secara otomatis."),
        _buildSectionTitle("Pasal 7: Privasi dan Pelindungan Data"),
        _buildSectionContent(
            "Penggunaan Layanan tunduk pada Kebijakan Privasi kami. Kami berkomitmen melindungi data Anda sesuai UU No. 27 Tahun 2022 tentang Pelindungan Data Pribadi (UU PDP)."),
        _buildSectionTitle("Pasal 8: Batasan Tanggung Jawab"),
        _buildSectionContent(
            "Layanan disediakan \"sebagaimana adanya\". Kami tidak bertanggung jawab atas kerugian tidak langsung yang timbul dari penggunaan atau ketidakmampuan menggunakan Layanan."),
        _buildSectionTitle("Pasal 9: Perubahan Ketentuan"),
        _buildSectionContent(
            "Kami berhak mengubah Ketentuan ini dari waktu ke waktu. Penggunaan berkelanjutan setelah perubahan merupakan bentuk persetujuan Anda."),
        _buildSectionTitle("Pasal 10: Hukum yang Berlaku"),
        _buildSectionContent(
            "Ketentuan ini diatur oleh hukum yang berlaku di Republik Indonesia. Sengketa akan diselesaikan melalui musyawarah, dan jika gagal, melalui Pengadilan Negeri yang kompeten."),
        _buildSectionTitle("Pasal 11: Kontak Kami"),
        _buildSectionContent(
            "Jika ada pertanyaan, silakan hubungi kami melalui email ke: legal@ruangpelaut.co.id"),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h, top: 10.h),
      child: Text(
        title,
        style: body1TextStyle.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: body2TextStyle.copyWith(color: Colors.black),
    );
  }

  Widget _buildAgreementCheckbox() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 24.w,
            height: 24.h,
            child: Obx(() => Checkbox(
                  value: isAgreed.value,
                  onChanged: (value) {
                    isAgreed.value = value ?? false;
                  },
                  activeColor: Colors.white,
                  checkColor: RColor().primaryBlueColor,
                  side: BorderSide(color: Colors.white),
                )),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              "By checking this box, you agree to the Terms and Conditions",
              style:
                  body2TextStyle.copyWith(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgreeButton() {
    return Obx(() => ElevatedButton(
          onPressed: () {
            if (isAgreed.value) {
              Get.back();
              widget.onAgree();
            } else {
              Get.snackbar(
                "Terms and Conditions",
                "Please agree to the Terms and Conditions to proceed.",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.redAccent,
                colorText: Colors.white,
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isAgreed.value ? RColor().primaryYellowColor : Colors.grey,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    color: RColor().primaryBlueColor,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  "Agree",
                  style: buttonTextStyle.copyWith(
                      color: RColor().primaryBlueColor, fontSize: 22.sp),
                ),
              ],
            ),
          ),
        ));
  }
}
