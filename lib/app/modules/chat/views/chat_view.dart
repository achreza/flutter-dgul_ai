import 'dart:io';

import 'package:dgul_ai/app/modules/chat/controllers/chat_controller.dart';
import 'package:dgul_ai/app/modules/chat/views/account_setting_view.dart';
import 'package:dgul_ai/app/modules/chat/views/help_and_support_view.dart';
import 'package:dgul_ai/app/modules/chat/views/subscription_view.dart';
import 'package:dgul_ai/app/modules/chat/views/terms_and_condition_view.dart';
import 'package:dgul_ai/app/modules/home/controllers/theme_controller.dart';
import 'package:dgul_ai/app/utitls/rasset.dart';
import 'package:dgul_ai/app/utitls/rcolor.dart';
import 'package:dgul_ai/app/widgets/language_button.dart';
import 'package:dgul_ai/app/widgets/message_bubble.dart';
import 'package:dgul_ai/app/widgets/tnc_dialog.dart';
import 'package:dgul_ai/app/widgets/work_type_dialog.dart';
import 'package:dgul_ai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hexcolor/hexcolor.dart';
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
        preferredSize: Size.fromHeight(80.h),
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
          title: Image.asset(RAsset().logoDgulAiNoTagline, height: 35.h),
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
                  Get.to(() => HelpAndSupportView());
                } else if (value == 'account_setting') {
                  Get.to(() => AccountSettingView());
                } else if (value == 'terms_and_conditions') {
                  Get.to(() => TermsAndConditionView());
                }
              },
              color: themeController.isDarkMode.value
                  ? Colors.black
                  : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Container(
                margin: EdgeInsets.only(right: 16.w, top: 2.h),
                child: Image.asset(
                  RAsset().iconMenu,
                  width: 24.w,
                  height: 24.h,
                  color: RColor().primaryYellowColor,
                ),
              ),
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
                _buildPopupMenuItem(
                    icon: Icons.article_outlined,
                    text: 'terms_and_conditions'.tr,
                    value: 'terms_and_conditions'),
                const PopupMenuDivider(),
                _buildPopupMenuItem(
                    icon: Icons.logout, text: 'logout'.tr, value: 'logout'),
              ],
            ),
          ],
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(40.h),
              child: Center(
                //backup disini
                child: GestureDetector(
                    onTap: () =>
                        WorkTypeDialog.showWorkTypeDialog(context, () {}),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      width: 200.w,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: RColor().primaryBlueColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            // biar teks pakai sisa space
                            child: Obx(
                              () => Text(
                                controller.selectedWorkType.value,
                                style: body1TextStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1, // cuma 1 baris
                                overflow: TextOverflow.ellipsis, // kasih ...
                                softWrap: false, // jangan otomatis enter
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ],
                      ),
                    )),
              )),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              image: DecorationImage(
                image: themeController.isDarkMode.value
                    ? AssetImage(RAsset().bgSirkuitDark)
                    : AssetImage(RAsset().bgSirkuitLight),
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
                      child: Container(
                        alignment: Alignment.center,
                        width: 50.w,
                        height: 50.h,
                        child: Image.asset(
                          RAsset().loading,
                          width: 50.w,
                          height: 50.h,
                        ),
                      ));
                } else {
                  return const SizedBox.shrink();
                }
              }),
              // Tampilkan saran prompt hanya di awal

              Obx(() {
                if (controller.messages.length <= 1 &&
                    controller.selectedSuggestion.value != 0) {
                  return _buildSubSuggestionPrompts(context, controller);
                }
                return const SizedBox.shrink();
              }),
              //[SUGGESTION PROMPTS]
              // Obx(() {
              //   if (controller.messages.length <= 1) {
              //     return _buildSuggestionPrompts(context, controller);
              //   }
              //   return const SizedBox.shrink();
              // }),
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
      height: 90.h, // Memberi tinggi tetap untuk area scroll

      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: controller.suggestionPrompts.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final prompt = controller.suggestionPrompts[index];
          return Obx(() => OutlinedButton(
                onPressed: () {
                  controller.selectedSuggestion.value != index + 1
                      ? controller.selectedSuggestion.value = index + 1
                      : controller.selectedSuggestion.value = 0;
                },
                style: OutlinedButton.styleFrom(
                  // add shadow
                  elevation: 2,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  foregroundColor: RColor().primaryBlueColor,

                  backgroundColor: themeController.isDarkMode.value
                      ? HexColor("#045082")
                      : Colors.white.withOpacity(0.8),
                  side: BorderSide(
                      width: 2,
                      color: themeController.isDarkMode.value
                          ? controller.selectedSuggestion.value == index + 1
                              ? Colors.lightBlue
                              : Colors.transparent
                          : controller.selectedSuggestion.value == index + 1
                              ? Colors.lightBlue
                              : Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Container(
                  width: 94.w,
                  child: Text(
                    prompt,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: themeController.isDarkMode.value
                          ? Colors.white
                          : Colors.grey.shade700,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget _buildSubSuggestionPrompts(
      BuildContext context, ChatController controller) {
    return Container(
      height: (56 * controller.subSuggestion1Prompts.length.toDouble()).h,
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: controller.selectedSuggestion.value == 1
            ? controller.subSuggestion1Prompts.length
            : controller.selectedSuggestion.value == 2
                ? controller.subSuggestion2Prompts.length
                : controller.subSuggestion3Prompts.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final prompt = controller.selectedSuggestion.value == 1
              ? controller.subSuggestion1Prompts[index]
              : controller.selectedSuggestion.value == 2
                  ? controller.subSuggestion2Prompts[index]
                  : controller.subSuggestion3Prompts[index];
          return OutlinedButton(
            onPressed: () => controller.sendSuggestion(prompt),
            style: OutlinedButton.styleFrom(
              // add shadow
              elevation: 2,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              foregroundColor: RColor().primaryBlueColor,

              backgroundColor: themeController.isDarkMode.value
                  ? HexColor("#045082")
                  : Colors.white.withOpacity(0.8),
              side: themeController.isDarkMode.value
                  ? BorderSide.none
                  : BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              prompt,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: themeController.isDarkMode.value
                    ? Colors.white
                    : Colors.grey.shade700,
                fontSize: 15.sp,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSuggestionPhotoPrompts(
      BuildContext context, ChatController controller) {
    return Container(
      height: 60.h, // Memberi tinggi tetap untuk area scroll
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: controller.fotoSuggestionPrompts.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final prompt = controller.fotoSuggestionPrompts[index];
          return OutlinedButton(
            onPressed: () => controller.sendSuggestion(prompt),
            style: OutlinedButton.styleFrom(
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

  Widget _buildSuggestionDocumentPrompts(
      BuildContext context, ChatController controller) {
    return Container(
      height: 60.h, // Memberi tinggi tetap untuk area scroll
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: controller.documentSuggestionPrompts.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final prompt = controller.documentSuggestionPrompts[index];
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
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
      ),
      decoration: BoxDecoration(
        color: themeController.isDarkMode.value
            ? HexColor("#0E3956")
            : Colors.white.withOpacity(0.9),
        border: Border.all(
          color: themeController.isDarkMode.value
              ? Colors.transparent
              : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Obx(() {
              if (controller.selectedImagePath.isNotEmpty) {
                return _buildSuggestionPhotoPrompts(context, controller);
              } else if (controller.selectedFilePath.isNotEmpty) {
                return _buildSuggestionDocumentPrompts(context, controller);
              } else {
                return const SizedBox.shrink();
              }
            }),
            Obx(() {
              if (controller.selectedImagePath.isNotEmpty) {
                return _buildImagePreview(context);
              } else if (controller.selectedFilePath.isNotEmpty) {
                return _buildFilePreview(context);
              } else {
                return const SizedBox.shrink();
              }
            }),
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                  ),
                  iconSize: 30.sp,
                  color: themeController.isDarkMode.value
                      ? HexColor("#43B2FC")
                      : RColor().primaryBlueColor,
                  onPressed: () => controller.pickImage(ImageSource.camera),
                ),
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
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
                  // Kondisi 1: Sedang mendengarkan -> Tampilkan animasi
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
                  }
                  // Kondisi 2: Tidak mendengarkan DAN teks tidak kosong -> Tampilkan tombol Kirim
                  else if (!controller.isTextEmpty.value) {
                    return IconButton(
                      icon: const Icon(Icons.send_rounded),
                      onPressed: controller.sendMessageToDGULAPI,
                      color: Theme.of(context).colorScheme.primary,
                    );
                  }
                  // Kondisi 3: Tidak mendengarkan DAN teks kosong -> Tampilkan tombol Mic & Add
                  else {
                    return Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.mic_none_outlined),
                          iconSize: 30.sp,
                          onPressed: controller.toggleListening,
                          color: themeController.isDarkMode.value
                              ? HexColor("#43B2FC")
                              : RColor().primaryBlueColor,
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          iconSize: 30.sp,
                          color: themeController.isDarkMode.value
                              ? HexColor("#43B2FC")
                              : RColor().primaryBlueColor,
                          onPressed: () => _showAttachmentSheet(controller),
                        ),
                      ],
                    );
                  }
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview(BuildContext context) {
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

  Widget _buildFilePreview(BuildContext context) {
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
              // ListTile(
              //   leading: const Icon(Icons.attach_file),
              //   title: const Text('Lampirkan Dokumen'),
              //   onTap: () {
              //     Get.back();
              //     controller.pickFile();
              //   },
              // ),
            ],
          ),
        ),
        backgroundColor: Get.theme.cardColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ));
  }
}
