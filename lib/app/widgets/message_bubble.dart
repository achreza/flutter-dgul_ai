import 'dart:io';
import 'package:dgul_ai/app/data/models/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == Sender.user;
    final isAi = message.sender == Sender.ai;
    final theme = Theme.of(context);

    // --- PERBAIKAN DI SINI ---
    // Memeriksa apakah imagePath tidak null DAN tidak kosong
    final hasImage = message.imagePath != null && message.imagePath!.isNotEmpty;

    final hasText = message.text.isNotEmpty;
    final hasToken = message.tokenCount != null;

    final markdownStyle = MarkdownStyleSheet.fromTheme(theme).copyWith(
      p: theme.textTheme.bodyMedium?.copyWith(
        color: isAi
            ? theme.colorScheme.onSecondaryContainer
            : theme.colorScheme.onPrimary,
      ),
      listBullet: theme.textTheme.bodyMedium?.copyWith(
        color: isAi
            ? theme.colorScheme.onSecondaryContainer
            : theme.colorScheme.onPrimary,
      ),
      h1: theme.textTheme.titleLarge?.copyWith(
        color: isAi
            ? theme.colorScheme.onSecondaryContainer
            : theme.colorScheme.onPrimary,
      ),
      h2: theme.textTheme.titleMedium?.copyWith(
        color: isAi
            ? theme.colorScheme.onSecondaryContainer
            : theme.colorScheme.onPrimary,
      ),
      strong: const TextStyle(fontWeight: FontWeight.bold),
    );

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: isUser
              ? theme.colorScheme.primary
              : theme.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hanya tampilkan gambar jika 'hasImage' bernilai true
            if (hasImage)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.file(
                    File(message.imagePath!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (hasText)
              isAi
                  ? MarkdownBody(
                      data: message.text,
                      selectable: true,
                      styleSheet: markdownStyle,
                    )
                  : Text(
                      message.text,
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
            if (isAi && hasToken) ...[
              SizedBox(height: 8.h),
              Text(
                "Tokens: ${message.tokenCount}",
                style: theme.textTheme.labelSmall?.copyWith(
                  color:
                      theme.colorScheme.onSecondaryContainer.withOpacity(0.7),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
