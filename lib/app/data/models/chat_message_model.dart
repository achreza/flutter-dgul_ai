enum Sender { user, ai }

class ChatMessage {
  final String text;
  final Sender sender;
  final String? imagePath;
  final int? tokenCount;

  // -- PROPERTI BARU UNTUK FILE --
  final String? fileName; // Untuk menyimpan nama file, misal: "laporan.pdf"
  final String? fileUri; // Untuk menyimpan URI dari Gemini File API

  ChatMessage({
    required this.text,
    required this.sender,
    this.imagePath,
    this.tokenCount,
    this.fileName,
    this.fileUri,
  });

  // Fungsi untuk mengubah objek menjadi JSON (untuk disimpan di GetStorage)
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'sender': sender.toString(),
      'imagePath': imagePath,
      'tokenCount': tokenCount,
      'fileName': fileName,
      'fileUri': fileUri,
    };
  }

  // Fungsi untuk membuat objek dari JSON (saat dimuat dari GetStorage)
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json['text'],
      sender: Sender.values.firstWhere((e) => e.toString() == json['sender']),
      imagePath: json['imagePath'],
      tokenCount: json['tokenCount'],
      fileName: json['fileName'],
      fileUri: json['fileUri'],
    );
  }
}
