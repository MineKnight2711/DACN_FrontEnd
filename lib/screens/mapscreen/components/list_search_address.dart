import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/controller/map_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:http/http.dart' as http;

class ListAddress extends StatelessWidget {
  final MapController mapController;
  const ListAddress({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: mapController.places.value.length,
        itemBuilder: (context, index) {
          final coordinate = mapController.places.value[index];

          return ListTile(
            horizontalTitleGap: 5,
            title: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.blue,
                  size: 20,
                ),
                SizedBox(
                  width: 320,
                  child: Text(
                    coordinate['description'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                )
              ],
            ),
            onTap: () async {
              mapController.isShow.value = false;
              mapController.isHidden.value = false;
              Logger().i("Coordinate ${mapController.places.value}");
              final url = Uri.parse(
                  'https://rsapi.goong.io/geocode?address=${coordinate['description']}&api_key=1D1TShB6BE7zzAKPIlT7GF61V0wa6KnsO8UAnl1P');
              var response = await http.get(url);
              final jsonResponse = jsonDecode(response.body);
              mapController.details.value =
                  jsonResponse['results'] as List<dynamic>;

              // ignore: no_leading_underscores_for_local_identifiers
              mapController.mapboxMap.value?.setCamera(CameraOptions(
                  center: Point(
                          coordinates: Position(
                              mapController.details.value[index]['geometry']
                                  ['location']['lng'],
                              mapController.details.value[index]['geometry']
                                  ['location']['lat']))
                      .toJson(),
                  zoom: 12.0));

              mapController.mapboxMap.value?.flyTo(
                  CameraOptions(
                      anchor: ScreenCoordinate(x: 0, y: 0),
                      zoom: 15,
                      bearing: 0,
                      pitch: 0),
                  MapAnimationOptions(duration: 2000, startDelay: 0));
              mapController.mapboxMap.value?.annotations
                  .createCircleAnnotationManager()
                  .then((value) async {
                mapController.circleManager.value = value;

                value.create(
                  CircleAnnotationOptions(
                    geometry: Point(
                        coordinates: Position(
                      mapController.details.value[index]['geometry']['location']
                          ['lng'],
                      mapController.details.value[index]['geometry']['location']
                          ['lat'],
                    )).toJson(),
                    circleColor: Colors.blue.value,
                    circleRadius: 12.0,
                  ),
                );
              });
              String address =
                  mapController.details.value[index]['formatted_address'];
              double lat = mapController.details.value[index]['geometry']
                  ['location']['lat'];
              double lng = mapController.details.value[index]['geometry']
                  ['location']['lng'];

              String latString = lat.toStringAsFixed(4);
              String lngString = lng.toStringAsFixed(4);

              mapController.mainText.value = address;
              mapController.secondText.value = "Tọa độ: $latString, $lngString";
            },
          );
        },
      ),
    );
  }
}
