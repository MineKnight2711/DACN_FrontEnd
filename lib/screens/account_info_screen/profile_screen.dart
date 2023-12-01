// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/controller/update_profile_controller.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';
import 'package:fooddelivery_fe/widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/custom_message.dart';
import 'package:fooddelivery_fe/widgets/expansion_tile.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView {
  ProfileScreen({super.key});
  final profileController = Get.find<UpdateProfileController>();
  final accountController = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    profileController.fetchCurrent();
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Get.delete<UpdateProfileController>();
          profileController.onClose();
          Navigator.pop(context);
        },
        title: 'Cập nhật thông tin',
        backGroundColor: AppColors.orange80,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: CustomMediaQuerry.mediaHeight(context, 40),
            ),
            AccountAvatar(
                imageUrl: accountController.accountSession.value?.imageUrl),
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
                title: 'Họ và tên',
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
                title: "Ngày sinh",
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
                title: 'Số điện thoại',
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
              onPressed: () {
                // Navigate to change email screen
              },
              child: Text(tr('Change Email')),
            ),
            TextButton(
              onPressed: () {
                // Show reset password dialog
              },
              child: Text(tr('Reset Password')),
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
}

class AccountAvatar extends StatelessWidget {
  final String? imageUrl;
  const AccountAvatar({
    super.key,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 80,
      backgroundImage: Image.network("$imageUrl").image,
    );
  }
}
