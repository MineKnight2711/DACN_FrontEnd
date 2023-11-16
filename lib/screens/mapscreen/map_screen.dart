import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';
import 'package:fooddelivery_fe/screens/mapscreen/components/address_textfield.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart'
    as gpi;
import 'package:logger/logger.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:http/http.dart' as http;

class AutocompleteMap extends StatefulWidget {
  const AutocompleteMap({super.key});

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<AutocompleteMap> {
  List<dynamic> places = [];
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> details = [];
  CircleAnnotationManager? _circleAnnotationManager;

  MapboxMap? mapboxMap;
  double _zoomLevel = 15.0;

  void _zoomIn() {
    print("Zoom level $_zoomLevel");
    _zoomLevel++;
    mapboxMap?.setCamera(CameraOptions(zoom: _zoomLevel + 1));
  }

  void _zoomOut() {
    print("Zoom level $_zoomLevel");
    _zoomLevel--;
    mapboxMap?.setCamera(CameraOptions(zoom: _zoomLevel - 1));
  }

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
  }

  void _findCurrentLocation() async {
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
    mapboxMap?.setCamera(CameraOptions(
        center: Point(
          coordinates: getPositon,
        ).toJson(),
        zoom: 15));
    mapboxMap?.flyTo(
        CameraOptions(
            anchor: ScreenCoordinate(x: 0, y: 0),
            zoom: 15,
            bearing: 0,
            pitch: 0),
        MapAnimationOptions(duration: 2000, startDelay: 0));
    mapboxMap?.annotations.createCircleAnnotationManager().then((value) async {
      setState(() {
        _circleAnnotationManager =
            value; // Store the reference to the circle annotation manager
      });

      value.create(
        CircleAnnotationOptions(
          geometry: Point(coordinates: getPositon).toJson(),
          circleColor: Colors.blue.value,
          circleRadius: 12.0,
        ),
      );
    });
    // String address = position.;
    // double lat = details[index]['geometry']['location']['lat'];
    // double lng = details[index]['geometry']['location']['lng'];

    // String latString = lat.toStringAsFixed(4);
    // String lngString = lng.toStringAsFixed(4);

    // mainText = address;
    // secondText = "Tọa độ: $latString, $lngString";
  }

  String searchText = "";
  String mainText = "";
  String secondText = "";
  String lat = "";
  String lng = "";

  bool isShow = false;
  bool isHidden = true;

  Future<void> fetchData(String input) async {
    try {
      final url = Uri.parse(
          'https://rsapi.goong.io/Place/AutoComplete?api_key=1D1TShB6BE7zzAKPIlT7GF61V0wa6KnsO8UAnl1P&input=$input');

      var response = await http.get(url);

      setState(() {
        final jsonResponse = jsonDecode(response.body);
        places = jsonResponse['predictions'] as List<dynamic>;
        _circleAnnotationManager?.deleteAll();
        isShow = true;
        isHidden = true;
      });
    } catch (e) {
      // ignore: avoid_print
      print('$e');
    }
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        final coordinate = places[index];

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
            setState(() {
              isShow = false;
              isHidden = false;
            });

            final url = Uri.parse(
                'https://rsapi.goong.io/geocode?address=${coordinate['description']}&api_key=1D1TShB6BE7zzAKPIlT7GF61V0wa6KnsO8UAnl1P');
            var response = await http.get(url);
            final jsonResponse = jsonDecode(response.body);
            details = jsonResponse['results'] as List<dynamic>;

            // ignore: no_leading_underscores_for_local_identifiers
            mapboxMap?.setCamera(CameraOptions(
                center: Point(
                        coordinates: Position(
                            details[index]['geometry']['location']['lng'],
                            details[index]['geometry']['location']['lat']))
                    .toJson(),
                zoom: 12.0));

            mapboxMap?.flyTo(
                CameraOptions(
                    anchor: ScreenCoordinate(x: 0, y: 0),
                    zoom: 15,
                    bearing: 0,
                    pitch: 0),
                MapAnimationOptions(duration: 2000, startDelay: 0));
            mapboxMap?.annotations
                .createCircleAnnotationManager()
                .then((value) async {
              setState(() {
                _circleAnnotationManager =
                    value; // Store the reference to the circle annotation manager
              });

              value.create(
                CircleAnnotationOptions(
                  geometry: Point(
                      coordinates: Position(
                    details[index]['geometry']['location']['lng'],
                    details[index]['geometry']['location']['lat'],
                  )).toJson(),
                  circleColor: Colors.blue.value,
                  circleRadius: 12.0,
                ),
              );
            });
            String address = details[index]['formatted_address'];
            double lat = details[index]['geometry']['location']['lat'];
            double lng = details[index]['geometry']['location']['lng'];

            String latString = lat.toStringAsFixed(4);
            String lngString = lng.toStringAsFixed(4);

            mainText = address;
            secondText = "Tọa độ: $latString, $lngString";
          },
        );
      },
    );
  }

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
                center: Point(coordinates: Position(106.702765, 10.749325))
                    .toJson(),
                zoom: _zoomLevel,
              ),
              styleUri: MapboxStyles.SATELLITE_STREETS,
              textureView: true,
              onMapCreated: _onMapCreated,
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
                  onPressed: _zoomIn,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 16), // Khoảng cách giữa 2 button
                FloatingActionButton(
                  onPressed: _zoomOut,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(height: 16),
                FloatingActionButton(
                  onPressed: _findCurrentLocation,
                  child: const Icon(Icons.location_on),
                ),
              ],
            ),
          ),
          //list địa chỉ
          if (isShow == true)
            Container(
              height: 120,
              margin: const EdgeInsets.fromLTRB(10, 60, 10, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: _buildListView(),
            ),
          //Text field địa chỉ
          Container(
            height: 70,
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: AddressTextField(
              hintText: "Mời nhập địa chỉ",
              controller: _searchController,
              onChanged: (text) {
                // print('First text field: $text');
                if (text != null) {
                  setState(() {
                    searchText = text;
                  });
                  fetchData(text);
                }
                isHidden = true;
              },
            ),
          ),
          isHidden
              ? const Card()
              : AddressInfo(
                  address: mainText,
                  info: secondText,
                )
        ],
      ),
    );
  }
}

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
          child: Column(
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
