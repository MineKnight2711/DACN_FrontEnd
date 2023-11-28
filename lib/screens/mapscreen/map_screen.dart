import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/controller/map_controller.dart';
import 'package:fooddelivery_fe/screens/mapscreen/components/address_info.dart';
import 'package:fooddelivery_fe/screens/mapscreen/components/address_textfield.dart';
import 'package:fooddelivery_fe/screens/mapscreen/components/list_search_address.dart';

import 'package:get/get.dart';

import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});
  final mapController = Get.find<MapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            child: MapWidget(
              key: const ValueKey("mapWidget"),
              resourceOptions: ResourceOptions(
                  accessToken:
                      "pk.eyJ1IjoidGluaGthaXQiLCJhIjoiY2xoZXhkZmJ4MTB3MzNqczdza2MzcHE2YSJ9.tPQwbEWtA53iWlv3U8O0-g"),
              cameraOptions: CameraOptions(
                center: Point(coordinates: Position(106.702765, 11)).toJson(),
                zoom: mapController.zoomLevel.value,
              ),
              styleUri: MapboxStyles.DARK,
              textureView: true,
              onMapCreated: mapController.onMapCreated,
            ),
          ),
          Positioned(
            bottom:
                130, // Điều chỉnh vị trí lên trên ở đây (ví dụ: bottom: 120)
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MapNavigateButton(
                    onPressed: mapController.zoomIn,
                    iconData: CupertinoIcons.zoom_in),
                MapNavigateButton(
                    onPressed: mapController.zoomOut,
                    iconData: CupertinoIcons.zoom_out),
                MapNavigateButton(
                    onPressed: mapController.findCurrentLocation,
                    iconData: CupertinoIcons.location)
              ],
            ),
          ),
          //list địa chỉ
          Obx(
            () {
              if (mapController.isShow.value) {
                return Container(
                  height: 120,
                  margin: const EdgeInsets.only(top: 80, left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: ListAddress(mapController: mapController),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          //Text field địa chỉ
          Container(
            height: 70.h,
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AddressTextField(
              hintText: "Mời nhập địa chỉ",
              controller: mapController.searchController,
              onChanged: (text) {
                // print('First text field: $text');
                if (text != null) {
                  mapController.searchText.value = text;
                  // mapController.fetchData(text);
                  mapController.predictLocation(text);
                }
                mapController.isHidden.value = true;
              },
            ),
          ),

          Obx(
            () {
              if (!mapController.isHidden.value) {
                return AddressInfo(
                  address: mapController.mainText.value,
                  info: mapController.secondText.value,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class MapNavigateButton extends StatelessWidget {
  final Function()? onPressed;
  final IconData iconData;
  const MapNavigateButton({
    super.key,
    this.onPressed,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: AppColors.orange100, // Make the button circular
          padding: const EdgeInsets.all(18),
        ),
        child: Icon(
          iconData,
          size: 22,
          color: AppColors.white100,
        ),
      ),
    );
  }
}
