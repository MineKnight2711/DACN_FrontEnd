import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/api/map/map_api.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/model/map/location_model.dart';
import 'package:fooddelivery_fe/model/map/predict_location_model.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:get/get.dart';
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
  RxDouble latitude = 0.0.obs;
  RxDouble longLatitude = 0.0.obs;

  Rx<List<Prediction>> places = Rx<List<Prediction>>([]);
  final TextEditingController searchController = TextEditingController();
  Rx<List<Result>> details = Rx<List<Result>>([]);

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
      places.value = locationResponse.predictions;
      isShow.value = true;
      isHidden.value = true;
      Logger().i("Loggg dia diem ${locationResponse.predictions.length}");
      return "Success";
    }

    return responseBaseModel?.message ?? "";
  }

  Future<String> getLocation(String address) async {
    isShow.value = false;
    isHidden.value = false;
    ResponseBaseModel? responseBaseModel = await _mapApi.getLocation(address);

    if (responseBaseModel != null && responseBaseModel.message == "Success") {
      Logger().i("Loggg dia diem ${responseBaseModel.data}");
      LocationResponse locationResponse =
          LocationResponse.fromJson(responseBaseModel.data);
      details.value = locationResponse.results;
      latitude.value = double.parse(details.value[0].geometry.location.lat);
      longLatitude.value = double.parse(details.value[0].geometry.location.lng);
      centerCameraOnCoordinate(latitude.value, longLatitude.value);
      String address = details.value[0].formattedAddress;

      String latString = latitude.value.toStringAsFixed(4);
      String lngString = longLatitude.toStringAsFixed(4);

      mainText.value = address;
      secondText.value = "Tọa độ: $latString, $lngString";
    }

    return responseBaseModel?.message ?? "";
  }

  void findCurrentLocation() async {
    bool serviceEnabled;
    geolocator.LocationPermission permission;

    serviceEnabled = await geolocator.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {}

    permission = await geolocator.Geolocator.checkPermission();
    if (permission == geolocator.LocationPermission.denied) {
      if (permission == geolocator.LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == geolocator.LocationPermission.deniedForever) {
      Get.dialog(AlertDialog(
        title: const Text("Enable Location!"),
        content: const Text(
            "Please enable location services to access your location!"),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              geolocator.Geolocator.openLocationSettings();
              Get.back();
            },
          )
        ],
      ));
      return;
    }

    gpi.Position position = await geolocator.Geolocator.getCurrentPosition(
        desiredAccuracy: geolocator.LocationAccuracy.high);
    Position getPositon = Position(position.longitude, position.latitude);
    // Cập nhật vị trí camera
    centerCameraOnCoordinate(getPositon.lat, getPositon.lng);
  }

  void centerCameraOnCoordinate(num lat, num longLat) {
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
            bearing: 0,
            pitch: 0),
        MapAnimationOptions(duration: 2000, startDelay: 0));
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
