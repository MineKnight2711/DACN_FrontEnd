import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/model/order_model.dart';

class ListDetailsDishes extends StatelessWidget {
  final List<DetailsDTO>? detailList;
  const ListDetailsDishes({super.key, this.detailList});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: CustomFonts.customGoogleFonts(fontSize: 14.r),
        children: detailList?.map((details) {
          if (detailList != null) {
            final index = detailList!.indexOf(details);
            if (detailList!.length == 1) {
              return TextSpan(
                text: "${details.dish?.dishName}",
                style: CustomFonts.customGoogleFonts(fontSize: 14.r),
              );
            } else if (detailList!.isNotEmpty && index < 2) {
              if (index == 1 && detailList!.length == 2) {
                return TextSpan(
                  text: "${details.dish?.dishName}",
                  style: CustomFonts.customGoogleFonts(fontSize: 14.r),
                );
              } else {
                return TextSpan(
                  text: "${details.dish?.dishName}${index == 1 ? '' : ', '}",
                  style: CustomFonts.customGoogleFonts(fontSize: 14.r),
                );
              }
            } else if (detailList!.length > 2 && index == 2) {
              int remainingCount = detailList!.length - 2;
              return TextSpan(
                text: " và $remainingCount món khác...",
                style: CustomFonts.customGoogleFonts(fontSize: 14.r),
              );
            }
          }
          return const TextSpan(text: "");
        }).toList(),
      ),
    );
  }
}
