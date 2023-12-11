import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';

class RatingBarRow extends StatelessWidget {
  final bool enable;
  final String? score;
  final double minRating;
  final Function()? onTap;
  final Function(double) onRatingUpdate;
  const RatingBarRow(
      {super.key,
      this.onTap,
      this.score,
      required this.enable,
      required this.onRatingUpdate,
      required this.minRating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: RatingBar.builder(
            glowColor: Colors.white,
            ignoreGestures: !enable,
            initialRating: 0,
            minRating: minRating,
            allowHalfRating: true,
            unratedColor: AppColors.gray50,
            itemCount: 5,
            itemSize: 30.h,
            itemPadding: EdgeInsets.symmetric(horizontal: 5.w),
            updateOnDrag: true,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: onRatingUpdate,
          ),
        ),
        score != null
            ? SizedBox(
                width: 10.w,
              )
            : const Card(),
        Text(score != null ? '$score' : '',
            style: CustomFonts.customGoogleFonts(fontSize: 14.r)),
      ],
    );
  }
}
