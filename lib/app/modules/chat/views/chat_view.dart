import 'dart:io';

import 'package:dgul_ai/app/modules/chat/controllers/chat_controller.dart';
import 'package:dgul_ai/app/modules/chat/views/account_setting_view.dart';
import 'package:dgul_ai/app/modules/chat/views/subscription_view.dart';
import 'package:dgul_ai/app/modules/home/controllers/theme_controller.dart';
import 'package:dgul_ai/app/utitls/rasset.dart';
import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/app/widgets/language_button.dart';
import 'package:dgul_ai/app/widgets/message_bubble.dart';
import 'package:dgul_ai/app/widgets/tnc_dialog.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class ChatView extends GetView<ChatController> {
  ChatView({Key? key}) : super(key: key);
  final ChatController controller = Get.put(ChatController());
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(100.h), // Menyesuaikan tinggi total AppBar
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                RAsset().appBarBg,
                fit: BoxFit.cover,
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Image.asset(RAsset().logoDgulAi, height: 35.h),
          centerTitle: true,
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'logout') {
                  // Tambahkan logika logout
                  controller.logout();
                } else if (value == 'clear_chat') {
                  controller.clearChatHistory();
                } else if (value == 'subscription') {
                  Get.to(() => SubscriptionView());
                } else if (value == 'help') {
                  TncDialogHelper.showTncDialog(context);
                } else if (value == 'account_setting') {
                  Get.to(() => AccountSettingView());
                }
              },
              color: themeController.isDarkMode.value
                  ? Colors.black
                  : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              icon: Icon(Icons.apps, color: RColor().primaryYellowColor),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'theme',
                  enabled: false,
                  child: Obx(() => SwitchListTile(
                        title: Text(
                          themeController.isDarkMode.value
                              ? 'dark_mode'.tr
                              : 'light_mode'.tr,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: themeController.isDarkMode.value
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        value: !themeController.isDarkMode.value,
                        onChanged: (bool value) {
                          themeController.switchTheme();
                          Get.back();
                        },
                        secondary: Icon(
                          themeController.isDarkMode.value
                              ? Icons.nightlight_round
                              : Icons.wb_sunny,
                          color: RColor().primaryYellowColor,
                        ),
                      )),
                ),
                PopupMenuItem<String>(
                    value: 'language',
                    enabled: false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildLanguageButton(context, "Indonesia", "id_ID",
                            controller.selectedLanguage),
                        buildLanguageButton(context, "English", "en_US",
                            controller.selectedLanguage),
                      ],
                    )),
                const PopupMenuDivider(),
                _buildPopupMenuItem(
                    icon: Icons.person_outline,
                    text: 'account_setting'.tr,
                    value: 'account_setting'),
                _buildPopupMenuItem(
                    icon: Icons.delete_outline,
                    text: 'clear_chat'.tr,
                    value: 'clear_chat'),
                _buildPopupMenuItem(
                    icon: Icons.subscriptions_outlined,
                    text: 'subscription'.tr,
                    value: 'subscription'),
                _buildPopupMenuItem(
                    icon: Icons.help_outline,
                    text: 'help_and_support'.tr,
                    value: 'help'),
                const PopupMenuDivider(),
                _buildPopupMenuItem(
                    icon: Icons.logout, text: 'logout'.tr, value: 'logout'),
              ],
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: Center(
              child: Container(
                // Container ini hanya untuk dekorasi, bukan untuk sizing
                margin: EdgeInsets.only(bottom: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: RColor().primaryBlueColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(
                      color: Colors.white.withOpacity(0.5), width: 1),
                ),
                child: Obx(
                  () => DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.selectedWorkType.value,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          controller.selectWorkType(newValue);
                        }
                      },
                      // Item untuk menu dropdown (bisa lebar)
                      items: controller.maritimeWorkTypes
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      // Builder untuk tampilan tombol (lebar tetap)
                      selectedItemBuilder: (BuildContext context) {
                        return controller.maritimeWorkTypes
                            .map<Widget>((String item) {
                          return Container(
                            width: 200.w, // Lebar tetap untuk tombol
                            alignment: Alignment.centerLeft,
                            child: Text(
                              item,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList();
                      },
                      icon: const Icon(Icons.keyboard_arrow_down,
                          color: Colors.white),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                      dropdownColor: RColor().primaryBlueColor.withOpacity(0.7),
                      isDense: true,

                      isExpanded: false, // Agar dropdown bisa lebih lebar
                    ),
                  ),
                ),
              ),
            ),
          ),
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
                  // Tampilkan welcome screen jika hanya ada 1 pesan (sapaan awal)
                  if (controller.messages.length <= 1) {
                    return _buildInitialWelcomeUI(context, controller);
                  }
                  // Tampilkan chat jika sudah ada interaksi
                  else {
                    return ListView.builder(
                      controller: controller.scrollController,
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
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
              // Tampilkan saran prompt hanya di awal
              Obx(() {
                if (controller.messages.length <= 1) {
                  return _buildSuggestionPrompts(context, controller);
                }
                return const SizedBox.shrink();
              }),
              _buildTextComposer(context, controller),
            ],
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(
      {required IconData icon, required String text, required String value}) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: RColor().primaryBlueColor),
          SizedBox(width: 12.w),
          Text(text,
              style: TextStyle(
                  fontSize: 14.sp,
                  color: themeController.isDarkMode.value
                      ? Colors.white
                      : Colors.black)),
        ],
      ),
    );
  }

  Widget _buildInitialWelcomeUI(
      BuildContext context, ChatController controller) {
    return Center(
      child: Text(
        "Ahooy, ${controller.userController.getName()}!",
        textAlign: TextAlign.center,
        style: headlineTextStyle.copyWith(
          //use gradient color
          foreground: Paint()
            ..shader = LinearGradient(
              colors: [
                RColor().primaryGradientStartColor,
                RColor().primaryGradientEndColor,
              ],
            ).createShader(
              Rect.fromLTWH(0, 0, 200, 50),
            ),
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
      ),
    );
  }

  Widget _buildSuggestionPrompts(
      BuildContext context, ChatController controller) {
    return Container(
      height: 60.h, // Memberi tinggi tetap untuk area scroll
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: controller.suggestionPrompts.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final prompt = controller.suggestionPrompts[index];
          return OutlinedButton(
            onPressed: () => controller.sendSuggestion(prompt),
            style: OutlinedButton.styleFrom(
              // add shadow
              elevation: 2,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              foregroundColor: RColor().primaryBlueColor,

              backgroundColor: Colors.white.withOpacity(0.8),
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              prompt,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 12.sp,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextComposer(BuildContext context, ChatController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () => _showAttachmentSheet(controller),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(color: Colors.grey.shade300),
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
                      child: Icon(Icons.mic, color: Colors.white, size: 20.sp),
                    ),
                  ),
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.mic_none_outlined),
                  onPressed: controller.toggleListening,
                  color: Theme.of(context).colorScheme.primary,
                );
              }
            }),
            IconButton(
              icon: const Icon(Icons.send_rounded),
              onPressed: controller.sendMessage,
              color: Theme.of(context).colorScheme.primary,
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
        ));
  }
}
