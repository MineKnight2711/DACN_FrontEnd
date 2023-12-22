// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/controller/change_image_controller.dart';
import 'package:fooddelivery_fe/controller/update_profile_controller.dart';
import 'package:fooddelivery_fe/screens/homescreen/homescreen.dart';
import 'package:fooddelivery_fe/screens/slpash_screen.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_message.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_textfield.dart';
import 'package:fooddelivery_fe/widgets/expansion_tile.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'components/account_avatar.dart';

class ProfileScreen extends GetView {
  ProfileScreen({super.key});

  final accountController = Get.find<AccountController>();
  final profileController = Get.put(UpdateProfileController());
  final changeImageController = Get.put(ChangeImageController());
  @override
  Widget build(BuildContext context) {
    profileController.fetchCurrent();
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Get.delete<UpdateProfileController>();
          Get.delete<ChangeImageController>();
          profileController.onClose();
          Navigator.pop(context);
        },
        title: tr("profile.appbar.update_profile"),
        backGroundColor: AppColors.orange80,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: CustomMediaQuerry.mediaHeight(context, 40),
            ),
            Obx(
              () {
                if (accountController.accountSession.value != null) {
                  return AccountAvatar(
                      account: accountController.accountSession.value!,
                      changeImageController: changeImageController,
                      imageUrl:
                          accountController.accountSession.value?.imageUrl);
                }
                return const SizedBox.shrink();
              },
            ),
            SizedBox(
              height: CustomMediaQuerry.mediaHeight(context, 40),
            ),
            Divider(
              endIndent: CustomMediaQuerry.mediaWidth(context, 5),
              indent: CustomMediaQuerry.mediaWidth(context, 5),
              thickness: 2,
              color: Colors.black38,
            ),
            SizedBox(
              height: CustomMediaQuerry.mediaHeight(context, 50),
            ),
            Obx(
              () => InputExpandTile(
                controller: profileController.fullnameExpansionTileController,
                title: tr("profile.full_name"),
                content: "${accountController.accountSession.value?.fullName}",
                textController: profileController
                    .textControllers.txtFullNameUpdateController,
                isExpanded: profileController.isFullNameDropdown.value,
                isValid: profileController.validate.isValidFullnameUpdate.value,
                textFieldOnChanged: profileController.validateFullname,
                onExpansionChanged: (isExpanded) {
                  profileController.isFullNameDropdown.value = isExpanded;
                  profileController.observeDropdowns();
                },
                onSavePressed: () async {
                  doUpdate(context);
                },
              ),
            ),
            Obx(
              () => DatePickerExpandTile(
                controller: profileController.birthDayExpansionTileController,
                title: tr("profile.birthday"),
                currentBirthday:
                    accountController.accountSession.value?.birthday ??
                        DateTime.now(),
                updateProfileController: profileController,
                onExpansionChanged: (value) {
                  profileController.isBirthDayDropDown.value = value;
                  profileController.observeDropdowns();
                },
                onSavePressed: () async {
                  doUpdate(context);
                },
              ),
            ),
            SizedBox(
              height: CustomMediaQuerry.mediaHeight(context, 20 * 10),
            ),
            Obx(
              () => InputExpandTile(
                controller:
                    profileController.phoneNumberExpansionTileController,
                title: tr("profile.phone_number"),
                content:
                    "${accountController.accountSession.value?.phoneNumber}",
                textController: profileController
                    .textControllers.txtPhoneNumberUpdateController,
                isExpanded: profileController.isPhoneNumberDropDown.value,
                isValid:
                    profileController.validate.isValidPhonenumberUpdate.value,
                textFieldOnChanged: profileController.validatePhonenumber,
                onExpansionChanged: (isExpanded) {
                  profileController.isPhoneNumberDropDown.value = isExpanded;
                  profileController.observeDropdowns();
                },
                onSavePressed: () async {
                  doUpdate(context);
                },
              ),
            ),
            TextButton(
              onPressed: () async {
                // String result = await profileController.changeEmail();
                showDialog(
                  context: context,
                  builder: (context1) {
                    return ChangeEmailDialog(
                      controller:
                          profileController.textControllers.txtEmailUpdate,
                      title: "Đổi email",
                      onPressed: () async {
                        showLoadingAnimation(
                            context, "assets/animations/loading.json", 180);
                        final result = await profileController
                            .changeEmail(profileController
                                .textControllers.txtEmailUpdate.text)
                            .whenComplete(() => Get.back());
                        if (result.message == "Success") {
                          showCustomSnackBar(
                                  context,
                                  "Thông báo",
                                  "Một email xác thực đã được gửi đến bạn\nVui lòng kiểm tra hộp thư",
                                  ContentType.help,
                                  3)
                              .whenComplete(() async {
                            await accountController.logOut().whenComplete(
                                () => Get.offAll(const SplashScreen()));
                            profileController.textControllers.txtEmailUpdate
                                .clear();
                          });
                        } else {
                          showCustomSnackBar(
                              context,
                              "Lỗi",
                              "Có lỗi xảy ra\nChi tiết ${result.data.toString()}",
                              ContentType.failure,
                              2);
                        }
                      },
                      onCancelPressed: () => Get.back(),
                    );
                  },
                );
              },
              child: Text(tr("profile.change_email")),
            ),
            TextButton(
              onPressed: () {
                // Show reset password dialog
              },
              child: Text(tr("profile.reset_password")),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> doUpdate(BuildContext context) async {
    showLoadingAnimation(context, "assets/animations/loading.json", 180);
    String result = await profileController.updateAccount();
    if (result == "Success") {
      showCustomSnackBar(context, "Thông báo", "Cập nhật thành công!",
              ContentType.success, 2)
          .whenComplete(() {
        Navigator.pop(context);
      });
    } else {
      showCustomSnackBar(context, "Lỗi ", "Có lỗi xảy ra :\n $result",
              ContentType.failure, 2)
          .whenComplete(() {
        Navigator.pop(context);
      });
    }
  }

  // void toVerifiedEmailWebView(
  //     BuildContext context, String link, String oldEmail, String newEmail) {
  //   final webViewController = MainController.initController();
  //   webViewController
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     ..setBackgroundColor(AppColors.white100)
  //     ..setNavigationDelegate(
  //       NavigationDelegate(
  //         onProgress: (int progress) {
  //           // Update loading bar.
  //         },
  //         onPageStarted: (String url) {},
  //         onPageFinished: (String url) {},
  //         onWebResourceError: (WebResourceError error) {},
  //         onNavigationRequest: (NavigationRequest request) async {
  //           if (request.url.contains("/api/account/verifiedEmail")) {
  //             // Future.delayed(
  //             //   const Duration(seconds: 3),
  //             //   () => Get.back(),
  //             // );
  //             return NavigationDecision.navigate;
  //           }
  //           return NavigationDecision.navigate;
  //         },
  //       ),
  //     )
  //     ..loadRequest(Uri.parse(link));
  //   Get.to(
  //       () => WillPopScope(
  //             onWillPop: () async {
  //               await profileController.changeEmail(newEmail);
  //               return true;
  //             },
  //             child: VerifyEmailWebView(
  //               webViewController: webViewController,
  //             ),
  //           ),
  //       transition: Transition.downToUp);
  // }
}

class ViewEmailLinkDialog extends StatelessWidget {
  final Function()? onLinkPressed;
  const ViewEmailLinkDialog({
    super.key,
    this.onLinkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dialogBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[800],
          ),
        ),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Xác thực email",
          style: CustomFonts.customGoogleFonts(fontSize: 16.r),
        ),
        content: InkWell(
          onTap: onLinkPressed,
          child: Text(
            "Nhấn vào đây",
            style: CustomFonts.customGoogleFonts(
                fontSize: 14.r, color: Colors.blue),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => Get.back(),
                child: Text(
                  'Hủy',
                  style: CustomFonts.customGoogleFonts(
                    fontSize: 14.r,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class VerifyEmailWebView extends GetView {
  final WebViewController webViewController;
  const VerifyEmailWebView({super.key, required this.webViewController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Get.offAll(const HomeScreen(), transition: Transition.fadeIn);
        },
      ),
      body: WebViewWidget(controller: webViewController),
    );
  }
}

class ChangeEmailDialog extends StatelessWidget {
  final TextEditingController controller;
  final String? title;
  final Function()? onPressed, onCancelPressed;

  const ChangeEmailDialog({
    super.key,
    required this.controller,
    this.title,
    this.onPressed,
    this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dialogBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[800],
          ),
        ),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title ?? ''),
        content: RoundTextfield(
          hintText: "Email",
          controller: controller,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: onCancelPressed,
                child: Text(
                  'Hủy',
                  style: CustomFonts.customGoogleFonts(
                    fontSize: 14.r,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  'Đổi',
                  style: CustomFonts.customGoogleFonts(
                    fontSize: 14.r,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
