// // ignore_for_file: use_build_context_synchronously

// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:flutter/material.dart';
// import 'package:fooddelivery_fe/controller/register_controller.dart';
// import 'package:fooddelivery_fe/screens/homescreen/homescreen.dart';
// import 'package:fooddelivery_fe/utils/mediaquery.dart';
// import 'package:fooddelivery_fe/utils/transition_animation.dart';
// import 'package:fooddelivery_fe/widgets/custom_appbar.dart';
// import 'package:fooddelivery_fe/widgets/custom_button.dart';
// import 'package:fooddelivery_fe/widgets/custom_input_textfield.dart';
// import 'package:fooddelivery_fe/widgets/datetime_picker.dart';
// import 'package:fooddelivery_fe/widgets/gender_chose.dart';
// import 'package:fooddelivery_fe/widgets/message.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SignInWithGoogleScreen extends StatelessWidget {
//   final RegisterController registerController = Get.find();
//   SignInWithGoogleScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         backGroundColor: Colors.transparent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//         child: Column(children: [
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               "Hoàn tất đăng ký!",
//               style: GoogleFonts.roboto(
//                 fontSize: 30,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: CustomMediaQuery.mediaHeight(context, 30),
//           ),
//           CustomInputTextField(
//             labelText: 'Họ và tên',
//             controller: registerController.fullNameController,
//           ),
//           SizedBox(
//             height: CustomMediaQuery.mediaHeight(context, 30),
//           ),
//           CustomInputTextField(
//             labelText: 'Email',
//             controller: registerController.emailController,
//           ),
//           SizedBox(
//             height: CustomMediaQuery.mediaHeight(context, 30),
//           ),
//           BirthdayDatePickerWidget(
//             initialDate: DateTime.now(),
//             onChanged: (value) {
//               registerController.selectedBirthDay = value;
//             },
//           ),
//           SizedBox(
//             height: CustomMediaQuery.mediaHeight(context, 50),
//           ),
//           GenderSelectionWidget(
//             onChanged: (value) {
//               registerController.selectedGender.value = value;
//             },
//             size: CustomMediaQuery.mediaAspectRatio(context, 0.25),
//           ),
//           SizedBox(
//             height: CustomMediaQuery.mediaHeight(context, 50),
//           ),
//           CustomInputTextField(
//             labelText: 'Số diện thoại',
//             controller: registerController.phoneController,
//           ),
//           SizedBox(
//             height: CustomMediaQuery.mediaHeight(context, 30),
//           ),
//           DefaultButton(
//             text: 'Đăng ký',
//             fontSize: 20,
//             press: () async {
//               String? result =
//                   await registerController.saveSignInUserToDatabase();
//               switch (result) {
//                 case "Success":
//                   showCustomSnackBar(context, "Thông báo", "Đăng ký thành công",
//                       ContentType.success);
//                   slideInTransitionReplacement(context, HomeScreen());
//                   registerController.getAccountByEmail(
//                       registerController.emailController.text);
//                   registerController.onClose();

//                   break;
//                 case "EmailAlreadyExist":
//                   showCustomSnackBar(
//                       context, "Lỗi", "Email đã tồn tại!", ContentType.failure);
//                   break;
//                 default:
//                   showCustomSnackBar(context, "Lỗi", "lỗi không xác định!",
//                       ContentType.failure);
//                   break;
//               }
//             },
//           ),
//         ]),
//       ),
//     );
//   }
// }
