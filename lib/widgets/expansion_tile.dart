import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';
import 'package:fooddelivery_fe/controller/update_profile_controller.dart';
import 'package:fooddelivery_fe/widgets/custom_textfield.dart';
import 'package:fooddelivery_fe/widgets/datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DatePickerExpandTile extends StatelessWidget {
  final String title;
  final DateTime? currentBirthday;
  final UpdateProfileController updateProfileController;
  final Function()? onSavePressed;
  final Function(bool)? onExpansionChanged;
  final ExpansionTileController controller;
  const DatePickerExpandTile({
    super.key,
    required this.title,
    required this.currentBirthday,
    required this.updateProfileController,
    this.onSavePressed,
    this.onExpansionChanged,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          controller: controller,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(DateFormat("dd/MM/yyyy").format(currentBirthday!)),
            ],
          ),
          textColor: Colors.black,
          trailing: Obx(
            () => AnimatedRotation(
              turns:
                  updateProfileController.isBirthDayDropDown.value ? 0.25 : 0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: updateProfileController.isBirthDayDropDown.value
                    ? Colors.black
                    : Colors.black,
              ),
            ),
          ),
          onExpansionChanged: onExpansionChanged,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 20.w,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 60.h,
                  width: CustomMediaQuerry.mediaWidth(context, 1.5),
                  child: BirthdayDatePickerWidget(
                    initialDate: currentBirthday,
                    onChanged: (value) {
                      updateProfileController.date = value;
                    },
                  ),
                ),
                const Spacer(),
                Container(
                  width: 1.5,
                  height: 20,
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: onSavePressed,
                  child: const Text(
                    'Lưu',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    ]);
  }
}

class InputExpandTile extends StatelessWidget {
  final String title;
  final String content;
  final Function(String?)? textFieldOnChanged;
  final TextEditingController textController;
  final TextInputType? inputType;
  final bool isExpanded;
  final bool isValid;
  final Function(bool)? onExpansionChanged;
  final Function()? onSavePressed;
  final ExpansionTileController controller;
  const InputExpandTile(
      {super.key,
      required this.title,
      required this.content,
      required this.textController,
      this.textFieldOnChanged,
      this.inputType,
      required this.isExpanded,
      this.onExpansionChanged,
      this.onSavePressed,
      required this.isValid,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          controller: controller,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(content),
            ],
          ),
          textColor: Colors.black,
          trailing: AnimatedRotation(
            turns: isExpanded ? 0.25 : 0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: isExpanded ? Colors.black : Colors.black,
            ),
          ),
          onExpansionChanged: onExpansionChanged,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  margin: const EdgeInsets.only(left: 10),
                  height: 90.h,
                  width: CustomMediaQuerry.mediaWidth(context, 1.35),
                  child: Center(
                    child: RoundTextfield(
                      controller: textController,
                      onChanged: textFieldOnChanged,
                      keyboardType: inputType,
                      hintText: '',
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 1.5,
                  height: 20,
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: isValid ? onSavePressed : null,
                  child: const Text(
                    'Lưu',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    ]);
  }
}
