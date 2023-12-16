import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/api/map/map_api.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/model/address_model.dart';
import 'package:fooddelivery_fe/model/map/location_model.dart';
import 'package:fooddelivery_fe/model/map/predict_location_model.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart'
    as gpi;
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
  RxString latitude = "".obs;
  RxString longLatitude = "".obs;

  Rx<List<Prediction>> places = Rx<List<Prediction>>([]);
  final TextEditingController searchController = TextEditingController();
  Rx<Result?> details = Rx<Result?>(null);
  Rx<LocationResponse?> selectedLocation = Rx<LocationResponse?>(null);
  @override
  void onInit() {
    super.onInit();
    _mapApi = MapApi();
  }

  @override
  void refresh() {
    super.refresh();
    searchText.value = latitude.value = longLatitude.value = "";
    isShow.value = false;
    isHidden.value = true;
    selectedLocation.value = null;
    searchController.clear();
  }

  onMapCreated(MapboxMap mapboxMapCreate) {
    mapboxMap.value = mapboxMapCreate;
  }

  void zoomIn() {
    print("Zoom level $zoomLevel");
    zoomLevel.value++;
    mapboxMap.value?.flyTo(
        CameraOptions(
            anchor: ScreenCoordinate(x: 0, y: 0),
            zoom: zoomLevel.value,
            bearing: 0,
            pitch: 0),
        MapAnimationOptions(duration: 2000, startDelay: 0));
  }

  void zoomOut() {
    print("Zoom level $zoomLevel");
    zoomLevel.value--;
    mapboxMap.value?.flyTo(
        CameraOptions(
            anchor: ScreenCoordinate(x: 0, y: 0),
            zoom: zoomLevel.value,
            bearing: 0,
            pitch: 0),
        MapAnimationOptions(duration: 2000, startDelay: 0));
  }

  Future<String> predictLocation(String predictString) async {
    ResponseBaseModel responseBaseModel =
        await _mapApi.getPredictLocation(predictString);

    if (responseBaseModel.message == "Success") {
      PredictLocationResponse locationResponse =
          PredictLocationResponse.fromJson(responseBaseModel.data);
      places.value = locationResponse.predictions;
      isShow.value = true;
      isHidden.value = true;

      return "Success";
    }

    return responseBaseModel.message ?? "";
  }

  Future<String> getLocation(String placesID) async {
    searchController.clear();
    isShow.value = false;
    isHidden.value = false;
    ResponseBaseModel responseBaseModel =
        await _mapApi.getLocationByID(placesID);

    if (responseBaseModel.message == "Success") {
      LocationResponse locationResult =
          LocationResponse.fromJson(responseBaseModel.data);
      details.value = locationResult.results;
      latitude.value = "${details.value?.geometry.location.lat}";
      longLatitude.value = "${details.value?.geometry.location.lng}";
      centerCameraOnCoordinate(
          double.parse(latitude.value), double.parse(longLatitude.value));
      selectedLocation.value = locationResult;
    }

    return responseBaseModel.message ?? "";
  }

  Future<String> findCurrentLocation() async {
    return await getCurrentPosition();
  }

  void selectAddress() {}
  Future<String> getCurrentPosition() async {
    String result = "";
    geolocator.LocationPermission permission =
        await geolocator.Geolocator.checkPermission();
    if (permission == geolocator.LocationPermission.deniedForever) {
      result = 'DeniedForever';
    } else if (permission == geolocator.LocationPermission.denied) {
      result = "Denied";
      geolocator.LocationPermission requestPermission =
          await geolocator.Geolocator.requestPermission();
      if (requestPermission == geolocator.LocationPermission.deniedForever) {
        return "DeniedForever";
      }
    } else if (permission == geolocator.LocationPermission.whileInUse ||
        permission == geolocator.LocationPermission.always) {
      gpi.Position position = await geolocator.Geolocator.getCurrentPosition(
          desiredAccuracy: geolocator.LocationAccuracy.high);
      Position getPositon = Position(position.longitude, position.latitude);
      final locationResult =
          await getLocationByLatitude("${getPositon.lat}", "${getPositon.lng}");
      if (locationResult == "Success") {
        centerCameraOnCoordinate(
            getPositon.lat.toDouble(), getPositon.lng.toDouble());
      }
      return "Success";
    }

    return result;
  }

  Future<String> getLocationByLatitude(String lat, String longLat) async {
    searchController.clear();
    isShow.value = false;
    isHidden.value = false;
    ResponseBaseModel responseBaseModel =
        await _mapApi.getLocationByLatitude(lat, longLat);

    if (responseBaseModel.message == "Success") {
      LocationByLatitudeResponse locationResult =
          LocationByLatitudeResponse.fromJson(responseBaseModel.data);
      final resultAddress = locationResult.results[0];
      selectedLocation.value =
          LocationResponse(results: resultAddress, status: "OK");
      return responseBaseModel.message ?? "";
    }

    return responseBaseModel.message ?? "";
  }

  void centerCameraOnCoordinate(double lat, double longLat) {
    circleManager.value?.deleteAll();
    mapboxMap.value?.setCamera(CameraOptions(
        center: Point(
          coordinates: Position(longLat, lat),
        ).toJson(),
        zoom: 12.0));

    mapboxMap.value?.flyTo(
        CameraOptions(
            anchor: ScreenCoordinate(x: 0, y: 0),
            zoom: 15,
            bearing: 180,
            pitch: 30),
        MapAnimationOptions(duration: 3000, startDelay: 0));
    mapboxMap.value?.annotations
        .createCircleAnnotationManager()
        .then((value) async {
      circleManager.value = value;
      value.create(
        CircleAnnotationOptions(
          geometry: Point(coordinates: Position(longLat, lat)).toJson(),
          circleColor: AppColors.orange100.value,
          circleRadius: 12.0,
        ),
      );
    });
  }
}
