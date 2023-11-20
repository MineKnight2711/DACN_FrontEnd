import 'package:flutter/material.dart';
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
                FloatingActionButton(
                  onPressed: mapController.zoomIn,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 16), // Khoảng cách giữa 2 button
                FloatingActionButton(
                  onPressed: mapController.zoomOut,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(height: 16),
                FloatingActionButton(
                  onPressed: mapController.findCurrentLocation,
                  child: const Icon(Icons.location_on),
                ),
              ],
            ),
          ),
          //list địa chỉ
          Obx(
            () {
              if (mapController.isShow.value) {
                return Container(
                  height: 120,
                  margin: const EdgeInsets.fromLTRB(10, 60, 10, 0),
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
            height: 70,
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
