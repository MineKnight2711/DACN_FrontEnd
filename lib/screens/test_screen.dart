import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: VoucherCoupon(
          size: 1,
          imagePath: "assets/images/voucher_banner.png",
        ),
      ),
    );
  }
}

class VoucherCoupon extends StatelessWidget {
  final double size;
  final String imagePath;
  const VoucherCoupon({
    super.key,
    required this.size,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final finalSize = (size * 0.15);
    return Stack(children: [
      Container(
          decoration: BoxDecoration(
              color: AppColors.orange100.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20)),
          height: finalSize.sh,
          width: (finalSize * 5).sw,
          child: Row(
            children: [
              Container(
                width: (finalSize * 600).w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Image.asset(
                    imagePath,
                    scale: 1 / size,
                  ).image),
                ),
              ),
              SizedBox(
                height: (finalSize * (100 / 0.15)).h,
                width: 1.w,
                child: CustomPaint(
                  painter: DashedLinePainter(),
                ),
              ),
              Padding(
                padding: EdgeInsets.all((finalSize * (10 / 0.15)).w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Voucher",
                      style: CustomFonts.customGoogleFonts(
                          fontSize: (finalSize * (16 / 0.15)).r),
                    ),
                    SizedBox(
                      height: (finalSize * (10 / 0.15)).h,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Giảm",
                            style:
                                CustomFonts.customGoogleFonts(fontSize: 14.r),
                          ),
                          TextSpan(
                            text: " 1000 %",
                            style:
                                CustomFonts.customGoogleFonts(fontSize: 18.r),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: (finalSize * (10 / 0.15)).h,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Từ",
                            style: CustomFonts.customGoogleFonts(
                                fontSize: (finalSize * (14 / 0.15)).r),
                          ),
                          TextSpan(
                            text: " 13/12",
                            style: CustomFonts.customGoogleFonts(
                                fontSize: (finalSize * (16 / 0.15)).r),
                          ),
                          TextSpan(
                            text: " đến",
                            style: CustomFonts.customGoogleFonts(
                                fontSize: (finalSize * (14 / 0.15)).r),
                          ),
                          TextSpan(
                            text: " 15/12",
                            style: CustomFonts.customGoogleFonts(
                                fontSize: (finalSize * (16 / 0.15)).r),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
      Positioned(
        left: -(finalSize * (15 / 0.15)).w,
        top: (finalSize * (32 / 0.15)).h,
        child: ClipOval(
          child: Container(
            width: (finalSize * (30 / 0.15)).w,
            height: (finalSize * (58 / 0.15)).h,
            color: AppColors.white100,
          ),
        ),
      ),
      Positioned(
        right: -(finalSize * (15 / 0.15)).w,
        top: (finalSize * (32 / 0.15)).h,
        child: ClipOval(
          child: Container(
            width: (finalSize * (30 / 0.15)).w,
            height: (finalSize * (58 / 0.15)).h,
            color: AppColors.white100,
          ),
        ),
      ),
    ]);
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white // Set the color of the dashed line
      ..strokeWidth = 2 // Set the width of the dashed line
      ..style = PaintingStyle.stroke;

    const double dashHeight = 5; // Height of each dash
    const double dashSpace = 5; // Space between dashes

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
          Offset(size.width / 2, startY),
          Offset(
              size.width / 2,
              startY + dashHeight < size.height
                  ? startY + dashHeight
                  : size.height),
          paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
