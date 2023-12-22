import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:get/get.dart';

class ImageViewer extends StatelessWidget {
  final String imageUrl;

  const ImageViewer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.black,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.h, right: 20.h),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Text(
                    "X",
                    style: CustomFonts.customGoogleFonts(
                        fontSize: 18.r, color: Colors.white),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: InteractiveViewer(
                maxScale: 5.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // const Expanded(child: Card()),
          ],
        ),
      ),
    );
  }
}
