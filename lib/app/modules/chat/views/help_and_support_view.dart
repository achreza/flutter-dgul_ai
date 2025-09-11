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
        Text(
          "Terakhir Diperbarui: 8 September 2025",
          style: body2TextStyle.copyWith(
              color: RColor().secondaryGreyColor, fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 24.h),

        // --- KONTEN DARI DOKUMEN DIMULAI DI SINI ---
        _buildSectionTitle("A. Gambaran Umum"),
        _buildParagraph(
            "D'Gul Maritime AI merupakan platform teknologi pintar yang didedikasikan khusus untuk melayani komunitas maritim Indonesia dan internasional. Platform ini dirancang untuk memenuhi kebutuhan berbagai kalangan maritim, mulai dari para pelaut berpengalaman, taruna akademi pelayaran, tenaga kerja berbasis darat, hingga perusahaan pelayaran. Tujuan utama kami adalah menyediakan akses informasi yang akurat, fasilitas pembelajaran yang komprehensif, serta membangun jembatan konektivitas karier dalam industri maritim. (D'Gul Maritime AI is a smart technology platform specifically dedicated to serving the Indonesian and international maritime community. This platform is designed to meet the needs of various maritime stakeholders, from experienced seafarers, maritime academy cadets, shore-based workers, to shipping companies. Our main objective is to provide access to accurate information, comprehensive learning facilities, and build career connectivity bridges in the maritime industry.)"),
        SizedBox(height: 12.h),
        _buildParagraph(
            "Layanan utama yang kami tawarkan meliputi: •	Edukasi & Karier: Menyediakan materi pembelajaran yang terstruktur dan alat bantu pengembangan karier profesional (Core services we offer include:) •	(Learning & Career Tools: Providing structured learning materials and professional career development tools) •	Informasi Maritim: Menyajikan berita terkini, analisis mendalam, dan sumber daya penting lainnya (Maritime Information: Presenting the latest news, in-depth analysis, and other essential resources) •	Komunikasi & Jaringan: Memfasilitasi interaksi antar pengguna untuk berbagi pengalaman dan membangun jaringan profesional (Communication & Networking: Facilitating user interactions to share experiences and build professional networks)"),
        SizedBox(height: 12.h),

        _buildSectionTitle("B. Panduan Memulai"),
        _buildParagraph(
            "Untuk memaksimalkan pengalaman Anda menggunakan platform D'Gul Maritime AI, kami sarankan untuk mengikuti langkah-langkah berikut secara berurutan: (To maximize your experience using the D'Gul Maritime AI platform, we recommend following these steps in order:)"),
        _buildNumberedItem("1. Unduh dan Daftarkan Akun:",
            "Pastikan Anda mengisi data registrasi dengan informasi yang akurat dan lengkap untuk memastikan layanan yang optimal. (Download and Register Account: Ensure you fill in registration data with accurate and complete information to ensure optimal service.)"),
        _buildNumberedItem("2. Lengkapi Profil Pengguna:",
            "Semakin detail profil yang Anda berikan, semakin relevan rekomendasi konten dan peluang karier yang akan Anda terima dari sistem AI kami. (Complete User Profile: The more detailed profile you provide, the more relevant content recommendations and career opportunities you will receive from our AI system.)"),
        _buildNumberedItem("3. Jelajahi Berbagai Fitur:",
            "Luangkan waktu untuk memahami setiap fitur yang tersedia agar Anda dapat memanfaatkan platform secara maksimal. (Explore Various Features: Take time to understand each available feature so you can utilize the platform to its fullest potential.)"),
        _buildNumberedItem("4. Pahami Ketentuan dan Kebijakan:",
            "Kami sangat menyarankan Anda untuk membaca dan memahami Ketentuan Penggunaan serta Kebijakan Privasi sebelum mulai menggunakan layanan kami. (Understand Terms and Policies: We highly recommend that you read and understand the Terms of Use and Privacy Policy before starting to use our services"),
        SizedBox(height: 12.h),
        _buildSectionTitle("C. Cara Menggunakan Fitur Utama"),
        _buildParagraph(
            "Keamanan akun Anda merupakan prioritas utama bagi kami. Sebagai pengguna, Anda memiliki tanggung jawab penuh untuk menjaga kerahasiaan kredensial login Anda, termasuk email dan kata sandi. Setiap aktivitas yang terjadi dalam akun Anda akan menjadi tanggung jawab Anda sepenuhnya. (Your account security is our top priority. As a user, you have full responsibility for maintaining the confidentiality of your login credentials, including email and password. Any activity that occurs in your account will be entirely your responsibility.) "),
        _buildParagraph(
            "Apabila Anda menduga adanya akses tidak sah ke akun Anda, segera lakukan langkah-langkah berikut: ubah kata sandi Anda dengan segera dan hubungi tim dukungan kami untuk mendapatkan bantuan lebih lanjut. (If you suspect unauthorized access to your account, immediately take the following steps: change your password immediately and contact our support team for further assistance.) Persyaratan Usia: Platform ini diperuntukkan bagi pengguna yang berusia minimal 18 tahun atau memiliki status hukum yang setara sesuai dengan peraturan di wilayah masing-masing. (Age Requirement: This platform is intended for users who are at least 18 years old or have equivalent legal status in accordance with regulations in their respective regions.)"),
        SizedBox(height: 12.h),
        _buildSectionTitle("D. Fitur-Fitur Utama Platform"),
        _buildParagraph(
            "Bagian ini menyediakan berbagai materi pembelajaran yang telah dikurasi secara khusus untuk industri maritim, panduan persiapan karier, serta alat bantu profesional yang dapat membantu Anda mengembangkan kompetensi. Perlu diperhatikan bahwa seluruh konten yang dihasilkan oleh sistem AI kami bersifat informatif dan tidak dapat dijadikan sebagai pengganti nasihat profesional dari ahli yang bersertifikat. (This section provides various learning materials specifically curated for the maritime industry, career preparation guides, and professional tools that can help you develop competencies. Please note that all content generated by our AI system is informative in nature and cannot serve as a substitute for professional advice from certified experts.)"),
        _buildSectionTitle("E. Peringatan Penting Mengenai Konten AI"),
        _buildParagraph(
            "Kami ingin menekankan dengan jelas bahwa semua informasi yang disediakan oleh sistem AI dalam platform ini ditujukan untuk keperluan informasional dan edukatif semata. Konten tersebut tidak boleh dijadikan sebagai pengganti nasihat navigasi, teknis, atau hukum yang profesional. (We want to clearly emphasize that all information provided by the AI system in this platform is intended for informational and educational purposes only. This content should not serve as a substitute for professional navigation, technical, or legal advice.)"),
        _buildParagraph(
            "Sebagai profesional maritim, Anda wajib untuk selalu mematuhi dan mengacu pada: •	Sistem Manajemen Keselamatan (SMS) perusahaan tempat Anda bekerja •	Peraturan Flag State yang berlaku •	Standar dan regulasi Klas kapal •	Konvensi dan regulasi Organisasi Maritim Internasional (IMO) (As a maritime professional, you are required to always comply with and refer to:) •	(Safety Management System (SMS) of the company where you work) •	(Applicable Flag State regulations) •	(Ship Class standards and regulations) •	(International Maritime Organization (IMO) conventions and regulations) Verifikasi Wajib: Sebelum mengambil tindakan operasional atau keputusan penting, pastikan Anda selalu memverifikasi informasi dengan sumber-sumber resmi yang berwenang. (Mandatory Verification: Before taking operational actions or important decisions, ensure you always verify information with authorized official sources.)"),
        SizedBox(height: 12.h),
        _buildSectionTitle("F. Privasi dan Pelindungan Data Pribadi"),
        _buildParagraph(
            "Kami berkomitmen penuh untuk melindungi data pribadi Anda sesuai dengan peraturan perundang-undangan perlindungan data yang berlaku di Republik Indonesia. Dalam proses pengelolaan data Anda, kami menerapkan prinsip-prinsip transparansi yang mencakup: jenis data yang kami kumpulkan, tujuan pemrosesan data, dasar hukum yang kami gunakan, langkah-langkah keamanan yang kami terapkan (termasuk enkripsi data), serta hak-hak Anda sebagai subjek data (termasuk hak akses, perbaikan, dan penghapusan data). (We are fully committed to protecting your personal data in accordance with data protection laws and regulations applicable in the Republic of Indonesia. In managing your data, we apply transparency principles that include: types of data we collect, data processing purposes, legal bases we use, security measures we implement (including data encryption), and your rights as a data subject (including rights of access, rectification, and data deletion).) Untuk informasi yang lebih detail mengenai praktik pengelolaan data pribadi, silakan merujuk pada Kebijakan Privasi yang tersedia dalam aplikasi. (For more detailed information about personal data management practices, please refer to the Privacy Policy available in the application.)"),
        SizedBox(height: 12.h),
        _buildSectionTitle("G. Layanan Berbayar dan Sistem Pembayaran"),
        _buildParagraph(
            "Platform D'Gul Maritime AI menggunakan model freemium, yang berarti Anda dapat mengakses fitur-fitur dasar secara gratis, sementara fitur-fitur premium tersedia melalui sistem berlangganan bulanan/tahunan atau pembelian satu kali. (The D'Gul Maritime AI platform uses a freemium model, which means you can access basic features for free, while premium features are available through monthly/annual subscription systems or one-time purchases.) Mengatasi Masalah Pembayaran: Apabila Anda mengalami kegagalan dalam proses pembayaran, kami sarankan untuk mencoba menggunakan metode pembayaran alternatif. Jika masalah berlanjut, silakan kirimkan bukti transaksi yang valid kepada tim dukungan kami untuk penyelesaian lebih lanjut. (Resolving Payment Issues: If you experience payment process failures, we suggest trying alternative payment methods. If the problem persists, please send valid transaction proof to our support team for further resolution.)"),
        SizedBox(height: 12.h),
        _buildSectionTitle("H. Pedoman Pelaku dan Etika Pengguna"),
        _buildParagraph(
            "Untuk menjaga lingkungan yang aman, positif, dan produktif bagi seluruh komunitas maritime, kami menetapkan pedoman perilaku yang harus dipatuhi oleh semua pengguna: (To maintain a safe, positive, and productive environment for the entire maritime community, we establish conduct guidelines that must be followed by all users:) 	Konten yang Dilarang: •	Konten yang melanggar hukum atau melanggar hak kekayaan intelektual pihak ketiga •	Materi yang mengandung unsur SARA (Suku, Agama, Ras, dan Antargolongan), pornografi, atau ujaran kebencian •	Tindakan meniru atau menyamar sebagai identitas orang lain •	Penyisipan malware, virus, atau kode berbahaya lainnya 	(Prohibited Content:) •	(Content that violates laws or infringes third-party intellectual property rights) •	(Materials containing elements of ethnic, religious, racial discrimination, pornography, or hate speech) •	(Acts of impersonating or disguising as another person's identity) •	(Insertion of malware, viruses, or other malicious code) Konsekuensi Pelanggaran: Pelanggaran terhadap pedoman ini dapat mengakibatkan pembatasan akses fitur tertentu atau penghentian akses permanen terhadap platform, tergantung pada tingkat keparahan pelanggaran. (Violation Consequences: Violations of these guidelines may result in restricted access to certain features or permanent access termination to the platform, depending on the severity of the violation.)"),
        SizedBox(height: 12.h),
        _buildSectionTitle("I. Panduan Pemecahan Masalah Teknis"),
        _buildParagraph(
            "Masalah Login Jika Anda mengalami kesulitan untuk masuk ke akun, lakukan pemeriksaan berikut secara berurutan: pastikan alamat email dan kata sandi yang dimasukkan sudah benar, periksa stabilitas koneksi internet Anda, atau gunakan fitur reset kata sandi jika diperlukan. (If you have difficulty logging into your account, perform the following checks in order: ensure the email address and password entered are correct, check your internet connection stability, or use the password reset feature if necessary.)"),
        _buildParagraph(
            "Apabila aplikasi berjalan lambat atau mengalami bug, coba langkah-langkah berikut: tutup dan buka kembali aplikasi, pastikan Anda menggunakan versi terbaru aplikasi, atau kosongkan cache aplikasi melalui pengaturan perangkat. (If the application runs slowly or experiences bugs, try the following steps: close and reopen the application, ensure you are using the latest version of the application, or clear the application cache through device settings.)"),
        _buildParagraph(
            "Jika konten tidak muncul atau tidak dapat dimuat dengan baik, pastikan koneksi jaringan Anda stabil dan coba muat ulang halaman atau restart aplikasi. (If content does not appear or cannot load properly, ensure your network connection is stable and try reloading the page or restarting the application.)"),
        _buildParagraph(
            "Untuk masalah berlangganan yang tidak aktif, periksa status pembayaran terkini dan riwayat transaksi Anda melalui menu pengaturan akun. (For inactive subscription issues, check your current payment status and transaction history through the account settings menu.)"),
        _buildSectionTitle("J. Pertanyaan yang Sering Diajukan (FAQ)"),
        _buildFaqItem(
            question:
                "1. Apakah konten platform ini dapat dijadikan nasihat profesional?",
            answer:
                "Tidak. Seluruh konten dalam platform ini bersifat informatif dan edukatif. Anda tetap perlu melakukan verifikasi mandiri dan berkonsultasi dengan ahli profesional yang bersertifikat untuk keputusan penting. (Is the platform content considered professional advice? No. All content on this platform is informative and educational in nature. You still need to perform independent verification and consult with certified professional experts for important decisions.)"),
        _buildFaqItem(
            question:
                "2. Siapa yang memiliki hak atas konten yang saya unggah?",
            answer:
                "Anda tetap menjadi pemilik penuh atas konten yang Anda unggah. Namun, dengan mengunggah konten, Anda memberikan lisensi terbatas kepada kami untuk menggunakan konten tersebut dalam rangka penyediaan layanan platform. (Who owns the content I upload? You remain the full owner of the content you upload. However, by uploading content, you grant us a limited license to use that content for the purpose of providing platform services.)"),
        _buildFaqItem(
            question: "3. Bagaimana keamanan data pribadi saya dijamin?",
            answer:
                "Kami menerapkan berbagai kontrol keamanan yang memenuhi standar industri dan melakukan peninjauan berkala terhadap praktik keamanan data untuk memastikan perlindungan optimal bagi informasi pribadi Anda. (How is my personal data security guaranteed? We implement various security controls that meet industry standards and conduct regular reviews of data security practices to ensure optimal protection for your personal information.)"),
        _buildFaqItem(
            question:
                "4. Apakah ada batasan usia untuk menggunakan platform ini?",
            answer:
                "Ya, pengguna harus berusia minimal 18 tahun atau memiliki status hukum dewasa sesuai dengan peraturan di wilayah masing-masing. (Is there an age restriction for using this platform? Yes, users must be at least 18 years old or have adult legal status according to regulations in their respective regions.)"),
        _buildFaqItem(
            question: "5. Bagaimana cara melaporkan pelanggaran atau masalah?",
            answer:
                "Anda dapat melaporkan pelanggaran atau masalah melalui kanal bantuan yang tersedia dalam aplikasi atau mengirimkan email langsung ke alamat dukungan kami. (How do I report violations or issues? You can report violations or issues through the support channel available in the application or send an email directly to our support address.)"),
        SizedBox(height: 12.h),
        _buildSectionTitle("K. Pembaruan Layanan dan Ketentuan"),
        _buildParagraph(
            "Dalam upaya meningkatkan kualitas layanan dan menyesuaikan dengan perkembangan teknologi serta peraturan yang berlaku, kami dapat melakukan pembaruan terhadap fitur layanan maupun Ketentuan Penggunaan secara berkala. Setiap perubahan signifikan akan dikomunikasikan kepada pengguna dengan pemberitahuan yang wajar melalui berbagai kanal komunikasi yang tersedia. (In an effort to improve service quality and adapt to technological developments and applicable regulations, we may make updates to service features and Terms of Use periodically. Any significant changes will be communicated to users with reasonable notice through various available communication channels.) Dengan melanjutkan penggunaan platform setelah pembaruan diberlakukan, Anda dianggap menerima dan menyetujui versi terbaru dari ketentuan yang berlaku. (By continuing to use the platform after updates take effect, you are deemed to accept and agree to the latest version of the applicable terms.)"),
        SizedBox(height: 12.h),
        _buildSectionTitle("L. Penyelesaian Sengketa dan Hukum yang Berlaku"),
        _buildParagraph(
            "Platform D'Gul Maritime AI tunduk pada hukum Republik Indonesia. Dalam hal terjadi sengketa antara pengguna dan platform, kami mendorong penyelesaian secara musyawarah-mufakat terlebih dahulu. Apabila upaya penyelesaian damai tidak berhasil, sengketa akan diselesaikan melalui Pengadilan Negeri yang memiliki yurisdiksi yang berwenang sesuai dengan peraturan perundang-undangan yang berlaku. (The D'Gul Maritime AI platform is subject to the laws of the Republic of Indonesia. In the event of a dispute between users and the platform, we encourage resolution through amicable settlement first. If peaceful resolution efforts are unsuccessful, disputes will be resolved through the District Court that has competent jurisdiction in accordance with applicable laws and regulations.)"),
        SizedBox(height: 12.h),
        _buildSectionTitle("M. Hubungi Tim Dukungan Pelanggan"),
        _buildParagraph(
            "Kami berkomitmen untuk memberikan dukungan terbaik kepada seluruh pengguna. Tim dukungan kami siap membantu Anda mengatasi berbagai pertanyaan, masalah teknis, atau memberikan panduan penggunaan platform. (We are committed to providing the best support to all users. Our support team is ready to help you overcome various questions, technical issues, or provide platform usage guidance.)"),
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
        SizedBox(height: 12.h),
        _buildParagraph(
            "Waktu Respons: Tim kami akan merespons pertanyaan Anda secepatnya pada hari kerja. Meskipun kami tidak memberikan jaminan SLA (Service Level Agreement) yang spesifik, kami selalu berupaya memberikan respons yang cepat dan solusi yang efektif. (Response Time: Our team will respond to your inquiries as soon as possible on working days. Although we do not provide specific SLA (Service Level Agreement) guarantees, we always strive to provide quick responses and effective solutions.)"),

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
