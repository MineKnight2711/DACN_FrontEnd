import 'package:flutter/material.dart';

class LoginWithGoogleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final String? buttonIconAssets;
  const LoginWithGoogleButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.buttonIconAssets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 1.8,
      height: size.height / 18,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Colors.grey[300]),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          disabledForegroundColor: Colors.transparent.withOpacity(0.38),
          disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
          shadowColor: Colors.transparent,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center text horizontally
          children: [
            buttonIconAssets != null
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      buttonIconAssets!,
                      scale: 2.5,
                    ),
                  )
                : const SizedBox.shrink(),
            SizedBox(
              width: size.width /
                  30, // Adjust the spacing between the icon and text as needed
            ),
            Text(
              buttonText,
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
