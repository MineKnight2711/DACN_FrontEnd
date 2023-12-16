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
        height: 90.h,
        margin: const EdgeInsets.fromLTRB(0, 200, 0, 0),
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        alignment: Alignment.topLeft,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.results.formattedAddress,
                    style: CustomFonts.customGoogleFonts(fontSize: 16.r),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 12)),
                  Text(
                    "${location.results.geometry.location.lat}, ${location.results.geometry.location.lng}",
                    style: CustomFonts.customGoogleFonts(fontSize: 14.r),
                  )
                ],
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
      ),
    );
  }
}
