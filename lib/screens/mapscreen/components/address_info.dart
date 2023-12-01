import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';

class AddressInfo extends StatelessWidget {
  final String address, info;
  const AddressInfo({super.key, required this.address, required this.info});

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              const Padding(padding: EdgeInsets.only(top: 12)),
              Text(
                info,
                style: const TextStyle(color: Colors.black54, fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
