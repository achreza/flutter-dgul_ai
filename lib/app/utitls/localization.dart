import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        // --- BAHASA INDONESIA ---
        'id_ID': {
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
          'suggestion_inspire': 'Inspirasi dan Motivasi',

          // Input Composer
          'text_field_hint': "Chat D'Gul...",
          'thinking': "D'Gul AI sedang berpikir...",

          // Dialog
          'clear_chat_title': 'Hapus Riwayat Chat',
          'clear_chat_message':
              'Apakah Anda yakin ingin menghapus seluruh percakapan?',
          'delete_button': 'Hapus',
          'cancel_button': 'Batal',
        },
        // --- BAHASA INGGRIS ---
        'en_US': {
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
        }
      };
}
