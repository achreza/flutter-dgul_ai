import 'package:intl/intl.dart';

class RFormatter {
  /// Mengambil nilai dinamis (String atau num) dan mengubahnya
  /// menjadi format mata uang Rupiah yang rapi.
  static String formatRupiah(dynamic price) {
    // Jika harga null atau bukan String/num, kembalikan nilai default.
    if (price == null || (price is! String && price is! num)) {
      return 'Rp. 0';
    }

    double numericPrice;
    if (price is String) {
      // Coba parse String menjadi double. Jika gagal, gunakan 0.
      numericPrice = double.tryParse(price) ?? 0.0;
    } else {
      numericPrice = (price as num).toDouble();
    }

    // Gunakan NumberFormat dari package intl untuk membuat format Rupiah.
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID', // Menggunakan lokal Indonesia
      symbol: 'Rp. ', // Simbol mata uang
      decimalDigits: 0, // Tidak ada angka di belakang koma
    );

    return formatCurrency.format(numericPrice);
  }

  static String? formatToken(int? token) {
    //format like 1000000 to 1,000,000
    if (token == null) return null;
    final formatter = NumberFormat('#,##0');
    return formatter.format(token);
  }
}
