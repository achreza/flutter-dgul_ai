import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  // 1. Buat variabel observable untuk status dark mode
  final isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    // 2. Muat status dari storage saat controller dimulai
    isDarkMode.value = _loadThemeFromBox();
  }

  // Getter ini masih berguna untuk mengatur themeMode awal di main.dart
  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  void _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  // 3. Sederhanakan fungsi switchTheme
  void switchTheme() {
    // Ubah nilai boolean
    isDarkMode.value = !isDarkMode.value;
    // Terapkan perubahan tema ke GetX
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    // Simpan preferensi baru ke storage
    _saveThemeToBox(isDarkMode.value);
  }
}
