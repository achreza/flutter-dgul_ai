import 'dart:io';
import 'package:dgul_ai/app/data/models/chat_message_model.dart';
import 'package:dgul_ai/app/modules/home/controllers/theme_controller.dart';
import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  final ThemeController themeController = Get.find<ThemeController>();

  MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == Sender.user;
    final isAi = message.sender == Sender.ai;
    final theme = Theme.of(context);

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
      alignment: isUser ? Alignment.centerRight : Alignment.center,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: isUser
              ? themeController.isDarkMode.value
                  ? Colors.transparent
                  : HexColor("#E8E8E8")
              : Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.r),
            bottomLeft: Radius.circular(18.r),
            bottomRight: Radius.circular(18.r),
          ),
          border: Border.all(
            color: isUser
                ? themeController.isDarkMode.value
                    ? RColor().primaryYellowColor
                    : Colors.transparent
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon action hanya untuk AI
            if (isAi)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await Clipboard.setData(
                          ClipboardData(text: message.text));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Teks berhasil dicopy")),
                      );
                    },
                    child: Icon(
                      Icons.content_copy,
                      color: themeController.isDarkMode.value
                          ? RColor().primaryYellowColor
                          : RColor().primaryBlueColor,
                      size: 16.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  // GestureDetector(
                  //   onTap: () async {},
                  //   child: Icon(
                  //     Icons.volume_up,
                  //     color: themeController.isDarkMode.value
                  //         ? RColor().primaryYellowColor
                  //         : RColor().primaryBlueColor,
                  //     size: 20.sp,
                  //   ),
                  // ),
                ],
              ),
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
                      textAlign: isUser ? TextAlign.end : TextAlign.start,
                      style: TextStyle(
                        color: themeController.isDarkMode.value
                            ? Colors.white
                            : HexColor("#595959"),
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
