import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';

class AddressInfo extends StatelessWidget {
  final String address, info;
  const AddressInfo({super.key, required this.address, required this.info});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: CustomMediaQuerry.mediaHeight(context, 9),
        margin: const EdgeInsets.fromLTRB(0, 200, 0, 0),
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        alignment: Alignment.topLeft,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
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
