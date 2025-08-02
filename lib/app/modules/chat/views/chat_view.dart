import 'dart:io';

import 'package:dgul_ai/app/modules/chat/controllers/chat_controller.dart';
import 'package:dgul_ai/app/modules/home/controllers/theme_controller.dart';
import 'package:dgul_ai/app/utitls/rasset.dart';
import 'package:dgul_ai/app/widgets/message_bubble.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class ChatView extends GetView<ChatController> {
  ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Pastikan ChatController sudah di-register di file routing (app_pages.dart) menggunakan bindings.
    final ThemeController themeController = Get.find();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.h),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(RAsset().appBarBg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: Colors.white,
              ),
              color: Colors.white,
              onPressed: () {
                controller.clearChatHistory();
              },
            ),
            Obx(() => IconButton(
                  icon: Icon(
                    themeController.isDarkMode.value
                        ? Icons.wb_sunny_outlined
                        : Icons.nightlight_round,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    themeController.switchTheme();
                  },
                )),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              image: DecorationImage(
                image: AssetImage(RAsset().bgSirkuitLight),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (controller.pilihanJurusan.isEmpty) {
                    return _buildJurusanSelectionUI(context, controller);
                  } else {
                    return ListView.builder(
                      controller: controller.scrollController,
                      padding: EdgeInsets.only(top: 130.h, bottom: 10.h),
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        final message = controller.messages[index];
                        return MessageBubble(message: message);
                      },
                    );
                  }
                }),
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: const CircularProgressIndicator(
                                strokeWidth: 2)),
                        SizedBox(width: 10.w),
                        const Text("D'Gul AI is thinking..."),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
              _buildTextComposer(context, controller),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJurusanSelectionUI(
      BuildContext context, ChatController controller) {
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 32.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 120.h),
          Obx(() => Text(
                controller.messages.isNotEmpty
                    ? controller.messages.first.text
                    : "Selamat Datang!", // Fallback text
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onBackground,
                ),
              )),
          const SizedBox(height: 32),
          ...controller.jurusan.map((jurusan) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: ActionChip(
                label: Text(jurusan),
                onPressed: () => controller.selectJurusan(jurusan),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                labelStyle: TextStyle(
                  color: theme.colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.w600,
                ),
                backgroundColor: theme.colorScheme.secondaryContainer,
                shape: const StadiumBorder(),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTextComposer(BuildContext context, ChatController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      color: Colors.transparent,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              if (controller.selectedImagePath.isNotEmpty) {
                return _buildImagePreview(context, controller);
              } else if (controller.selectedFilePath.isNotEmpty) {
                return _buildFilePreview(context, controller);
              } else {
                return const SizedBox.shrink();
              }
            }),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () => _showAttachmentSheet(controller),
                ),
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: controller.textController,
                      onSubmitted: (_) => controller.sendMessage(),
                      decoration: const InputDecoration.collapsed(
                        hintText: "Chat D'Gul...",
                      ),
                      minLines: 1,
                      maxLines: 5,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                // Tombol Mikrofon dengan animasi
                Obx(() {
                  if (controller.isListening.value) {
                    return RippleAnimation(
                      color: Colors.red,
                      delay: const Duration(milliseconds: 300),
                      repeat: true,
                      minRadius: 20.r,
                      ripplesCount: 3,
                      duration: const Duration(milliseconds: 6 * 300),
                      child: InkWell(
                        onTap: controller.toggleListening,
                        child: CircleAvatar(
                          minRadius: 20.r,
                          backgroundColor: Colors.red,
                          child:
                              Icon(Icons.mic, color: Colors.white, size: 20.sp),
                        ),
                      ),
                    );
                  } else {
                    return IconButton(
                      icon: const Icon(Icons.mic),
                      onPressed: controller.toggleListening,
                      color: Theme.of(context).colorScheme.primary,
                    );
                  }
                }),
                // Tombol Kirim
                IconButton(
                  icon: const Icon(Icons.send_rounded),
                  onPressed: controller.sendMessage,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAttachmentSheet(ChatController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 20,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Ambil Foto dari Kamera'),
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Pilih Gambar dari Galeri'),
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_file),
              title: const Text('Lampirkan Dokumen'),
              onTap: () {
                Get.back();
                controller.pickFile();
              },
            ),
          ],
        ),
      ),
      backgroundColor: Get.theme.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  Widget _buildImagePreview(BuildContext context, ChatController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.file(
              File(controller.selectedImagePath.value),
              width: 50.w,
              height: 50.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10.w),
          const Expanded(
            child: Text(
              "Gambar dipilih. Tambahkan teks...",
              style: TextStyle(fontStyle: FontStyle.italic),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: controller.cancelImageSelection,
          )
        ],
      ),
    );
  }

  Widget _buildFilePreview(BuildContext context, ChatController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.description, color: Theme.of(context).colorScheme.primary),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              controller.selectedFileName.value,
              style: const TextStyle(fontStyle: FontStyle.italic),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: controller.cancelFileSelection,
          )
        ],
      ),
    );
  }
}
