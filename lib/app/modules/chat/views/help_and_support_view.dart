import 'package:dgul_ai/app/modules/chat/controllers/chat_controller.dart';
import 'package:dgul_ai/app/modules/chat/views/subscription_detail_view.dart';
import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/app/utitls/rasset.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupportView extends GetView<ChatController> {
  const HelpAndSupportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Latar belakang utama
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
          // Konten utama dengan SafeArea
          SafeArea(
            child: Column(
              children: [
                // Header custom
                _buildHeader(),
                // Konten yang bisa di-scroll
                SizedBox(height: 100.h),
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                    child: _buildContentBody(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk header
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new,
                color: RColor().primaryYellowColor),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

  // Widget untuk seluruh konten di bawah header
  Widget _buildContentBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Help & Support",
          style: subHeadline1TextStyle.copyWith(
            color: RColor().primaryBlueColor,
            fontWeight: FontWeight.normal,
            fontSize: 40.sp,
          ),
        ),
        SizedBox(height: 24.h),

        // --- KONTEN DARI DOKUMEN DIMULAI DI SINI ---
        _buildSectionTitle("A. Gambaran Umum"),
        _buildParagraph(
            "D'Gul Maritime AI merupakan platform teknologi pintar yang didedikasikan khusus untuk melayani komunitas maritim Indonesia dan internasional. Platform ini dirancang untuk memenuhi kebutuhan berbagai kalangan maritim, mulai dari para pelaut berpengalaman, taruna akademi pelayaran, tenaga kerja berbasis darat, hingga perusahaan pelayaran."),
        SizedBox(height: 12.h),

        _buildSectionTitle("B. Panduan Memulai"),
        _buildNumberedItem("1. Unduh dan Daftarkan Akun:",
            "Pastikan Anda mengisi data registrasi dengan informasi yang akurat dan lengkap untuk memastikan layanan yang optimal."),
        _buildNumberedItem("2. Lengkapi Profil Pengguna:",
            "Semakin detail profil yang Anda berikan, semakin relevan rekomendasi konten dan peluang karier yang akan Anda terima dari sistem AI kami."),
        _buildNumberedItem("3. Jelajahi Berbagai Fitur:",
            "Luangkan waktu untuk memahami setiap fitur yang tersedia agar Anda dapat memanfaatkan platform secara maksimal."),
        _buildNumberedItem("4. Pahami Ketentuan dan Kebijakan:",
            "Kami sangat menyarankan Anda untuk membaca dan memahami Ketentuan Penggunaan serta Kebijakan Privasi sebelum mulai menggunakan layanan kami."),
        SizedBox(height: 12.h),

        _buildSectionTitle("E. Peringatan Penting Mengenai Konten AI"),
        _buildParagraph(
            "Semua informasi yang disediakan oleh sistem AI dalam platform ini ditujukan untuk keperluan informasional dan edukatif semata. Konten tersebut tidak boleh dijadikan sebagai pengganti nasihat navigasi, teknis, atau hukum yang profesional."),
        SizedBox(height: 12.h),

        _buildSectionTitle("J. Pertanyaan yang Sering Diajukan (FAQ)"),
        _buildFaqItem(
            question:
                "1. Apakah konten platform ini dapat dijadikan nasihat profesional?",
            answer:
                "Tidak. Seluruh konten dalam platform ini bersifat informatif dan edukatif. Anda tetap perlu melakukan verifikasi mandiri dan berkonsultasi dengan ahli profesional yang bersertifikat untuk keputusan penting."),
        _buildFaqItem(
            question:
                "2. Siapa yang memiliki hak atas konten yang saya unggah?",
            answer:
                "Anda tetap menjadi pemilik penuh atas konten yang Anda unggah. Namun, dengan mengunggah konten, Anda memberikan lisensi terbatas kepada kami untuk menggunakan konten tersebut dalam rangka penyediaan layanan platform."),
        _buildFaqItem(
            question: "3. Bagaimana keamanan data pribadi saya dijamin?",
            answer:
                "Kami menerapkan berbagai kontrol keamanan yang memenuhi standar industri dan melakukan peninjauan berkala terhadap praktik keamanan data untuk memastikan perlindungan optimal bagi informasi pribadi Anda."),
        SizedBox(height: 12.h),

        GestureDetector(
          onTap: () async {
            //open wa.me
            final Uri whatsappUri = Uri.parse(
                "https://wa.me/+6281533331179?text=Halo,%20Saya%2C%20Butuh%20bantuan%20dengan%20aplikasi%20Dgul%20AI");
            await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
          },
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: RColor().primaryYellowColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: RColor().primaryYellowColor.withOpacity(0.5),
                    blurRadius: 15,
                    spreadRadius: 3,
                  )
                ],
              ),
              child: Icon(
                Icons.headset_mic,
                color: RColor().primaryBlueColor,
                size: 100.sp,
              ),
            ),
          ),
        ),

        SizedBox(height: 40.h),
        Center(
          child: Text(
            "Terms and Conditions / Privacy Policy",
            style: body2TextStyle.copyWith(
              fontSize: 12.sp,
              color: RColor().secondaryGreyColor,
            ),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  // Helper widget untuk judul setiap bagian
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
      child: Text(
        title,
        style: subHeadline3TextStyle.copyWith(
          color: RColor().primaryBlueColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper widget untuk paragraf biasa
  Widget _buildParagraph(String text) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: body2TextStyle.copyWith(color: RColor().secondaryGreyColor),
    );
  }

  // Helper widget untuk item bernomor
  Widget _buildNumberedItem(String number, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$number ",
            style: body2TextStyle.copyWith(
              color: RColor().primaryBlueColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            content,
            textAlign: TextAlign.justify,
            style: body2TextStyle.copyWith(color: RColor().secondaryGreyColor),
          ),
        ],
      ),
    );
  }

  // Helper widget untuk item FAQ
  Widget _buildFaqItem({required String question, required String answer}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: body1TextStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: RColor().primaryBlueColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            answer,
            style: body2TextStyle.copyWith(color: RColor().secondaryGreyColor),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(
      {required IconData icon,
      required String contact,
      required VoidCallback onTap}) {
    return Row(
      children: [
        Icon(icon, color: RColor().primaryBlueColor, size: 20.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            contact,
            style: body2TextStyle.copyWith(color: RColor().secondaryGreyColor),
          ),
        ),
        IconButton(
          icon: Icon(Icons.copy, size: 18.sp, color: RColor().primaryBlueColor),
          onPressed: onTap,
        ),
      ],
    );
  }
}
