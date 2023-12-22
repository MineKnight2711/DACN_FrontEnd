// ignore_for_file: deprecated_member_use
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

Future<bool> showConfirmDialog(
    BuildContext context, String title, String confirmMessage) async {
  bool confirm = false;

  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            title,
            style: GoogleFonts.roboto(fontSize: 16),
          ),
          content: Text(
            confirmMessage,
            style: GoogleFonts.roboto(fontSize: 16),
          ),
          actions: [
            TextButton(
              child: Text(
                "Huỷ",
                style: GoogleFonts.roboto(fontSize: 16.r),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(
                "OK",
                style: GoogleFonts.roboto(
                    fontSize: 16.r, color: AppColors.orange100),
              ),
              onPressed: () {
                confirm = true;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });

  return confirm;
}

Future<void> showCustomSnackBar(BuildContext context, String title,
    String message, ContentType contentType, int? duration) async {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: contentType,
    ),
    duration: Duration(seconds: duration ?? 1),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);

  return await Future.delayed(snackBar.duration);
}

class CustomAlertDialog extends StatelessWidget {
  final String content;
  final String? title;
  final Function()? onPressed;

  const CustomAlertDialog(
      {super.key, required this.content, this.title, this.onPressed});

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
        title: Text(title ?? ''),
        content: Text(content),
        actions: [
          ElevatedButton(
            onPressed: onPressed,
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

// void showResetLinkSentDialog(BuildContext context, String link) {
//   final loginController = Get.find<LoginController>();
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: const Text('Reset Password Link Sent'),
//       content: InkWell(
//         onTap: () {
//           launchURLLink(link);
//           Navigator.pop(context);
//           Navigator.pop(context);
//           loginController.onClose();
//         },
//         child: const Text.rich(
//           TextSpan(
//             text: "Nhấn vào đây để đổi mật khẩu",
//             style: TextStyle(
//                 color: Colors.blue, decoration: TextDecoration.underline),
//           ),
//         ),
//       ),
//       actions: [
//         ElevatedButton(
//           child: const Text('OK'),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ],
//     ),
//   );
// }

// Future launchURLLink(String link) async {
//   Uri url = Uri.parse(link);
//   if (await launchUrl(url)) {
//     await launchUrl(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
