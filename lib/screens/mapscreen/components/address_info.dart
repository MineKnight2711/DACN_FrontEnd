import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/model/map/location_model.dart';

class AddressInfo extends StatelessWidget {
  final LocationResponse location;
  final Function(LocationResponse)? onChooseAddress;
  const AddressInfo({super.key, this.onChooseAddress, required this.location});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 120.h,
        margin: const EdgeInsets.only(top: 200),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        alignment: Alignment.topLeft,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Địa chỉ:\n${location.results.formattedAddress}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: CustomFonts.customGoogleFonts(fontSize: 14.r),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    "Toạ độ:\n${location.results.geometry.location.lat.toStringAsFixed(5)}, ${location.results.geometry.location.lng.toStringAsFixed(5)}",
                    style: CustomFonts.customGoogleFonts(fontSize: 12.r),
                  )
                ],
              ),
            ),
            TextButton.icon(
              onPressed: () {
                if (onChooseAddress != null) {
                  onChooseAddress!(location);
                }
              },
              label: Text(
                "Chọn",
                style: CustomFonts.customGoogleFonts(fontSize: 14.r),
              ),
              icon: const Icon(Icons.check),
            ),
          ],
        ),
      ),
    );
  }
}
