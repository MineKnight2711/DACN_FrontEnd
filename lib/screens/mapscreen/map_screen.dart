// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/controller/map_controller.dart';
import 'package:fooddelivery_fe/screens/homescreen/homescreen.dart';
import 'package:fooddelivery_fe/screens/mapscreen/components/address_info.dart';
import 'package:fooddelivery_fe/screens/mapscreen/components/address_textfield.dart';
import 'package:fooddelivery_fe/screens/mapscreen/components/list_predict_address.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';
import 'package:fooddelivery_fe/widgets/custom_message.dart';
import 'package:geolocator/geolocator.dart' as geolocator;

import 'package:get/get.dart';

import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapScreen extends GetView {
  MapScreen({super.key});
  final mapController = Get.find<MapController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.to(() => const HomeScreen(), transition: Transition.fadeIn);
        Get.delete<MapController>();
        return true;
      },
      child: Scaffold(
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
                styleUri: MapboxStyles.MAPBOX_STREETS,
                textureView: true,
                onMapCreated: mapController.onMapCreated,
              ),
            ),
            Positioned(
              bottom: 130,
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
                      onPressed: () async {
                        String result =
                            await mapController.findCurrentLocation();
                        switch (result) {
                          case "Success":
                            showDelayedLoadingAnimation(context,
                                "assets/animations/loading.json", 160, 1);
                            break;
                          case "DeniedForever":
                            Get.dialog(AlertDialog(
                              title: const Text("Enable Location!"),
                              content: const Text(
                                  "Please enable location services to access your location!"),
                              actions: [
                                TextButton(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    geolocator.Geolocator
                                        .openLocationSettings();
                                    Get.back();
                                  },
                                )
                              ],
                            ));
                            break;
                          case "Denied":
                            showCustomSnackBar(
                                context,
                                "Thông báo",
                                "Vui lòng bật cài đặt vị trí",
                                ContentType.warning,
                                2);
                          case "NotEnable":
                            if (!await geolocator.Geolocator
                                .isLocationServiceEnabled()) {
                              showCustomSnackBar(
                                      context,
                                      "Thông báo",
                                      "Vui lòng bật cài đặt vị trí",
                                      ContentType.warning,
                                      2)
                                  .whenComplete(
                                      () => mapController.getCurrentPosition());
                            }
                            break;
                          default:
                            break;
                        }
                      },
                      iconData: CupertinoIcons.location)
                ],
              ),
            ),

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
                bgColor: AppColors.white100,
                hintText: "Mời nhập địa chỉ",
                controller: mapController.searchController,
                onChanged: (text) async {
                  if (text != null && text.isNotEmpty) {
                    mapController.searchText.value = text;
                    await mapController.predictLocation(text);
                  } else {
                    mapController.isShow.value = false;
                    mapController.isHidden.value = true;
                  }
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
