// File: lib/app/utils/app_exceptions.dart

/// Class dasar untuk semua jenis exception di dalam aplikasi.
/// Memudahkan untuk menangkap semua error aplikasi dengan satu tipe.
class AppExceptions implements Exception {
  final String? _message;
  final String? _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

/// Dilempar saat terjadi kesalahan komunikasi dengan server selama panggilan API.
class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

/// Dilempar saat server mengembalikan respons 400 (Bad Request).
class BadRequestException extends AppExceptions {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

/// Dilempar saat server mengembalikan respons 401 (Unauthorized) atau 403 (Forbidden).
class UnauthorizedException extends AppExceptions {
  UnauthorizedException([message]) : super(message, "Unauthorized: ");
}

/// Dilempar saat server mengembalikan respons 404 (Not Found).
class NotFoundException extends AppExceptions {
  NotFoundException([message]) : super(message, "Not Found: ");
}

/// Dilempar saat server mengembalikan respons 422 (Unprocessable Entity),
/// biasanya digunakan untuk error validasi.
class InvalidInputException extends AppExceptions {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
