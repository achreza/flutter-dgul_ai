import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        // --- BAHASA INDONESIA ---
        'id_ID': {
          //menu register
          'register': 'Daftar',
          'seafarer': 'Pelaut',
          'shore_base_maritime_worker': 'Pekerja Darat Maritim',
          'full_name': 'Nama Lengkap',
          'email_address': 'Alamat Email',
          'password': 'Kata Sandi',
          'login_as': 'Masuk sebagai',
          'language': 'Bahasa',
          'register_with_google': 'Daftar dengan Google',

          //promo sheet
          'choose_subscription': 'Pilih Paket Berlangganan',
          'see_all_subscription_plans': 'Lihat Semua Paket Berlangganan',
          'most_popular': 'Paling Populer',
          'per_month': 'per bulan',
          'billed_annually': 'ditagih setiap tahun',
          'start_free_trial': 'Mulai Uji Coba Gratis',
          'get_10000_free_tokens':
              'Dapatkan 10.000 Token GRATIS dan akses terbatas ke fitur D\'Gul AI.',
          'try_it_first':
              'Coba dulu dan rasakan kekuatan asisten pintar sebelum berlangganan penuh!',
          'one_month': '1-Bulan',
          'save_50_percent': 'Hemat 50% | Akses Penuh | 8.000.000 Token',

          // Menu Popup
          'dark_mode': 'Mode Gelap',
          'light_mode': 'Mode Terang',
          'clear_chat': 'Hapus Chat',
          'subscription': 'Langganan',
          'help_and_support': 'Bantuan dan Dukungan',
          'terms_and_conditions': 'Syarat dan Ketentuan',
          'logout': 'Keluar',

          // Tampilan Awal
          'welcome_greeting': "Ahooy, D'Gul",
          'suggestion_info': 'Informasi dan Komunikasi',
          'suggestion_edu': 'Edukasi dan Pengembangan Karir',
          'suggestion_inspire': 'Ruang Komunikasi',

          // Input Composer
          'text_field_hint': "Chat D'Gul...",
          'thinking': "D'Gul AI sedang berpikir...",

          // Dialog
          'clear_chat_title': 'Hapus Riwayat Chat',
          'clear_chat_message':
              'Apakah Anda yakin ingin menghapus seluruh percakapan?',
          'delete_button': 'Hapus',
          'cancel_button': 'Batal',

          //List of Suggestions
          'suggestion_1': 'Informasi dan Berita Maritim',
          'suggestion_2': 'Edukasi dan Pengembangan Karir',
          'suggestion_3': 'Ruang Komunikasi',

          'view_foto_suggestion_1': 'Analisis Foto',
          'view_foto_suggestion_2': 'Pertannyaan dan Jawaban',
          'view_foto_suggestion_3': 'Ringkasan Foto',

          'foto_suggestion_1': 'Jelaskan foto ini',
          'foto_suggestion_2': 'Jawablah soal di foto ini?',
          'foto_suggestion_3': 'Apa yang Anda lihat di foto ini?',

          'document_suggestion_1': 'Jelaskan dokumen ini',
          'document_suggestion_2': 'Apa yang Anda lihat di dokumen ini?',
          'document_suggestion_3':
              'Bagaimana perasaan Anda tentang dokumen ini?',

          // List of sub Suggestions
          'sub_suggestion_1_1': 'Sub Saran 1',
          'sub_suggestion_1_2': 'Sub Saran 2',
          'sub_suggestion_1_3': 'Sub Saran 3',
          'sub_suggestion_2_1': 'Sub Saran 4',
          'sub_suggestion_2_2': 'Sub Saran 5',
          'sub_suggestion_2_3': 'Sub Saran 6',
          'sub_suggestion_3_1': 'Sub Saran 7',
          'sub_suggestion_3_2': 'Sub Saran 8',
          'sub_suggestion_3_3': 'Sub Saran 9',

          'account_setting': 'Pengaturan Akun',
        },
        // --- BAHASA INGGRIS ---
        'en_US': {
          //menu register
          'register': 'Register',
          'seafarer': 'Seafarer',
          'shore_base_maritime_worker': 'Shore Base Maritime Worker',
          'full_name': 'Full Name',
          'email_address': 'Email Address',
          'password': 'Password',
          'login_as': 'Login as',
          'language': 'Language',
          'register_with_google': 'Register with Google',

          //promo sheet
          'choose_subscription': 'Choose Subscription Plan',
          'see_all_subscription_plans': 'See All Subscription Plans',
          'most_popular': 'Most Popular',
          'per_month': 'per month',
          'billed_annually': 'billed annually',
          'start_free_trial': 'Start Your Free Trial Now!',
          'get_10000_free_tokens':
              'Get 10,000 FREE Tokens and limited access to D\'Gul AI features.',
          'try_it_first':
              'Try it first and see the power of smart assistance before subscribing fully!',
          'one_month': '1-Month',
          'save_50_percent': 'Save 50% | Full Access | 8,000,000 Token',

          // Popup Menu
          'dark_mode': 'Dark Mode',
          'light_mode': 'Light Mode',
          'clear_chat': 'Clear Chat',
          'subscription': 'Subscription',
          'logout': 'Logout',
          'help_and_support': 'Help and Support',
          'terms_and_conditions': 'Terms and Conditions',

          'view_foto_suggestion_1': 'Photo Analysis',
          'view_foto_suggestion_2': 'Question and Answer',
          'view_foto_suggestion_3': 'Photo Summary',

          'foto_suggestion_1': 'Describe this photo',
          'foto_suggestion_2': 'Answer the question in this photo?',
          'foto_suggestion_3': 'What do you see in this photo?',

          // Initial View
          'welcome_greeting': "Ahooy, D'Gul",
          'suggestion_info': 'Information and Communication',
          'suggestion_edu': 'Education and Career Development',
          'suggestion_inspire': 'Inspiration and Motivation',

          // Input Composer
          'text_field_hint': "Chat D'Gul...",
          'thinking': "D'Gul AI is thinking...",

          // Dialog
          'clear_chat_title': 'Clear Chat History',
          'clear_chat_message':
              'Are you sure you want to delete the entire conversation?',
          'delete_button': 'Delete',
          'cancel_button': 'Cancel',

          // List of Suggestions
          'suggestion_1': 'Information and Maritime News',
          'suggestion_2': 'Education and Career Development',
          'suggestion_3': 'Inspiration and Motivation',

          // List of sub Suggestions
          'sub_suggestion_1_1': 'Sub Suggestion 1',
          'sub_suggestion_1_2': 'Sub Suggestion 2',
          'sub_suggestion_1_3': 'Sub Suggestion 3',
          'sub_suggestion_2_1': 'Sub Suggestion 4',
          'sub_suggestion_2_2': 'Sub Suggestion 5',
          'sub_suggestion_2_3': 'Sub Suggestion 6',
          'sub_suggestion_3_1': 'Sub Suggestion 7',
          'sub_suggestion_3_2': 'Sub Suggestion 8',
          'sub_suggestion_3_3': 'Sub Suggestion 9',

          'account_setting': 'Account Setting',
        }
      };
}
