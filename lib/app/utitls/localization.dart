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

          // Menu Popup
          'dark_mode': 'Mode Gelap',
          'light_mode': 'Mode Terang',
          'clear_chat': 'Hapus Chat',
          'subscription': 'Langganan',
          'help_and_support': 'Bantuan dan Dukungan',
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
          'suggestion_1': 'Informasi dan Komunikasi',
          'suggestion_2': 'Edukasi dan Pengembangan Karir',
          'suggestion_3': 'Ruang Komunikasi',

          'foto_suggestion_1': 'Jelaskan foto ini',
          'foto_suggestion_2': 'Apa yang Anda lihat di foto ini?',
          'foto_suggestion_3': 'Bagaimana perasaan Anda tentang foto ini?',

          'document_suggestion_1': 'Jelaskan dokumen ini',
          'document_suggestion_2': 'Apa yang Anda lihat di dokumen ini?',
          'document_suggestion_3':
              'Bagaimana perasaan Anda tentang dokumen ini?',

          'account_setting': 'Pengaturan Akun',
        },
        // --- BAHASA INGGRIS ---
        'en_US': {
          //menu register
          'register': 'Register',
          'seafarer': 'Seafarer',
          'shore_base_maritime_worker': 'Shore Base Maritime Worker',

          // Popup Menu
          'dark_mode': 'Dark Mode',
          'light_mode': 'Light Mode',
          'clear_chat': 'Clear Chat',
          'subscription': 'Subscription',
          'logout': 'Logout',
          'help_and_support': 'Help and Support',

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
          'suggestion_1': 'Information and Communication',
          'suggestion_2': 'Education and Career Development',
          'suggestion_3': 'Inspiration and Motivation',

          'account_setting': 'Account Setting',
        }
      };
}
