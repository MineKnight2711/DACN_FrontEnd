import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/api/map/map_api.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/model/map/predict_location_model.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart'
    as gpi;
import 'package:logger/logger.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapController extends GetxController {
  late MapApi _mapApi;
  Rx<MapboxMap?> mapboxMap = Rx<MapboxMap?>(null);
  Rx<CircleAnnotationManager?> circleManager =
      Rx<CircleAnnotationManager?>(null);
  RxInt mapWidgetKey = 0.obs;
  RxDouble zoomLevel = 15.0.obs;

  RxBool isShow = false.obs;
  RxBool isHidden = true.obs;

  RxString searchText = "".obs;
  RxString mainText = "".obs;
  RxString secondText = "".obs;
  RxString lat = "".obs;
  RxString lng = "".obs;

  Rx<List<dynamic>> places = Rx<List<dynamic>>([]);
  final TextEditingController searchController = TextEditingController();
  Rx<List<dynamic>> details = Rx<List<dynamic>>([]);

  @override
  void onInit() {
    super.onInit();
    _mapApi = MapApi();
  }

  onMapCreated(MapboxMap mapboxMapCreate) {
    mapboxMap.value = mapboxMapCreate;
  }

  void zoomIn() {
    print("Zoom level $zoomLevel");
    zoomLevel.value++;
    mapboxMap.value?.setCamera(CameraOptions(zoom: zoomLevel.value + 1));
  }

  void zoomOut() {
    print("Zoom level $zoomLevel");
    zoomLevel.value--;
    mapboxMap.value?.setCamera(CameraOptions(zoom: zoomLevel.value - 1));
  }

  Future<String> predictLocation(String predictString) async {
    ResponseBaseModel? responseBaseModel =
        await _mapApi.getPredictLocation(predictString);

    if (responseBaseModel != null && responseBaseModel.message == "Success") {
      PredictLocationResponse locationResponse =
          PredictLocationResponse.fromJson(responseBaseModel.data);
      Logger().i("Loggg dia diem ${locationResponse.predictions.length}");
      return "Success";
    }

    return responseBaseModel?.message ?? "";
  }

  void findCurrentLocation() async {
    bool serviceEnabled;
    geolocator.LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await geolocator.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await geolocator.Geolocator.checkPermission();
    if (permission == geolocator.LocationPermission.denied) {
      permission = await geolocator.Geolocator.requestPermission();
      if (permission == geolocator.LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == geolocator.LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Logger().i(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    gpi.Position position = await geolocator.Geolocator.getCurrentPosition(
        desiredAccuracy: geolocator.LocationAccuracy.high);
    Position getPositon = Position(position.longitude, position.latitude);
    // Update map camera to current location
    mapboxMap.value?.setCamera(CameraOptions(
        center: Point(
          coordinates: getPositon,
        ).toJson(),
        zoom: 15));
    mapboxMap.value?.flyTo(
        CameraOptions(
            anchor: ScreenCoordinate(x: 0, y: 0),
            zoom: 15,
            bearing: 0,
            pitch: 0),
        MapAnimationOptions(duration: 2000, startDelay: 0));
    mapboxMap.value?.annotations
        .createCircleAnnotationManager()
        .then((value) async {
      circleManager.value = value;
      value.create(
        CircleAnnotationOptions(
          geometry: Point(coordinates: getPositon).toJson(),
          circleColor: AppColors.orange100.value,
          circleRadius: 12.0,
        ),
      );
    });
  }

  // void addAnnotation(latLng) {
  //   // Use circleManager to add annotation
  // }
  Future<void> fetchData(String input) async {
    try {
      final url = Uri.parse(
          'https://rsapi.goong.io/Place/AutoComplete?api_key=1D1TShB6BE7zzAKPIlT7GF61V0wa6KnsO8UAnl1P&input=$input');

      var response = await http.get(url);

      final jsonResponse = jsonDecode(response.body);
      places.value = jsonResponse['predictions'] as List<dynamic>;
      circleManager.value?.deleteAll();
      isShow.value = true;
      isHidden.value = true;
    } catch (e) {
      // ignore: avoid_print
      print('$e');
    }
  }
}
