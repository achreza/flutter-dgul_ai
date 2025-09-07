import 'package:dgul_ai/app/modules/chat/controllers/chat_controller.dart';
import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/app/utitls/rasset.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class TermsAndConditionView extends GetView<ChatController> {
  const TermsAndConditionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new,
                            color: RColor().primaryYellowColor),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 110.h),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        Text(
                          "Terms and Conditions",
                          style: subHeadline1TextStyle.copyWith(
                              color: RColor().primaryBlueColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 36.sp),
                        ),
                        SizedBox(height: 16.h),

                        // --- KONTEN BARU DARI DOKUMEN ---
                        Text(
                          "Terakhir Diperbarui: 8 September 2025",
                          style: body2TextStyle.copyWith(
                              color: RColor().secondaryGreyColor,
                              fontStyle: FontStyle.italic),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "Dengan mengunduh, mendaftar, atau menggunakan Layanan kami, Anda menyatakan telah membaca, memahami, dan menyetujui untuk terikat pada seluruh Ketentuan ini serta Kebijakan Privasi kami.",
                          style: body2TextStyle.copyWith(
                              color: RColor().secondaryGreyColor),
                        ),
                        SizedBox(height: 20.h),

                        _buildSectionTitle("Pasal 1: Definisi"),
                        _buildSectionContent(
                            "Aplikasi: Perangkat lunak “D’Gul Maritime AI” beserta situs dan layanan terkait.\nPengguna: Setiap orang atau badan hukum yang menggunakan Aplikasi.\nLayanan: Fitur utama Aplikasi seperti Informasi, Edukasi, dan Komunikasi."),

                        _buildSectionTitle(
                            "Pasal 2: Kelayakan dan Akun Pengguna"),
                        _buildSectionContent(
                            "Anda menjamin bahwa informasi pendaftaran benar dan Anda cakap secara hukum (minimal 18 tahun). Anda bertanggung jawab penuh atas keamanan akun Anda."),

                        _buildSectionTitle("Pasal 3: Hak Kekayaan Intelektual"),
                        _buildSectionContent(
                            "Seluruh hak atas Aplikasi adalah milik PT. Ruang Pelaut Indonesia. Dengan mengunggah konten, Anda memberikan kami lisensi untuk menggunakan konten tersebut dalam rangka penyediaan Layanan."),

                        _buildSectionTitle("Pasal 4: Perilaku Pengguna"),
                        _buildSectionContent(
                            "Anda dilarang mengunggah konten yang melanggar hukum, SARA, pornografi, ujaran kebencian, atau mengandung malware."),

                        _buildSectionTitle(
                            "Pasal 5: SANGGAHAN PENTING TERKAIT KONTEN AI"),
                        _buildSectionContent(
                            "Konten yang dihasilkan AI HANYA UNTUK TUJUAN INFORMASI UMUM dan BUKAN NASIHAT PROFESIONAL. VERIFIKASI MANDIRI terhadap sumber resmi adalah WAJIB sebelum mengambil tindakan."),

                        _buildSectionTitle("Pasal 6: Layanan Berbayar"),
                        _buildSectionContent(
                            "Aplikasi mungkin menawarkan fitur premium berbayar. Pembayaran diproses melalui pihak ketiga dan langganan dapat diperpanjang secara otomatis."),

                        _buildSectionTitle(
                            "Pasal 7: Privasi dan Pelindungan Data"),
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
                        // --- AKHIR KONTEN BARU ---

                        SizedBox(height: 40.h),
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

  // Widget helper untuk judul setiap pasal
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h, top: 10.h),
      child: Text(
        title,
        style: body1TextStyle.copyWith(
          fontWeight: FontWeight.bold,
          color: RColor().primaryBlueColor,
        ),
      ),
    );
  }

  // Widget helper untuk isi setiap pasal
  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: body2TextStyle.copyWith(color: RColor().secondaryGreyColor),
    );
  }
}
