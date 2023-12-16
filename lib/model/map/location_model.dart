import 'package:fooddelivery_fe/model/map/predict_location_model.dart';

class LocationResponse {
  Result results;
  String status;

  LocationResponse({required this.results, required this.status});
  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    return LocationResponse(
        results: Result.fromJson(json['result']),
        status: json['status'] as String);
  }
}

class LocationByLatitudeResponse {
  List<Result> results;
  String status;

  LocationByLatitudeResponse({required this.results, required this.status});
  factory LocationByLatitudeResponse.fromJson(Map<String, dynamic> json) {
    return LocationByLatitudeResponse(
      results: (json['results'] as List<dynamic>)
          .map((p) => Result.fromJson(p))
          .toList(),
      status: json['status'] as String,
    );
  }
}

class Result {
  String formattedAddress;
  Geometry geometry;
  String name;
  Compound compound;

  Result({
    required this.formattedAddress,
    required this.geometry,
    required this.name,
    required this.compound,
  });
  factory Result.fromJson(Map<String, dynamic> json) {
    print(json['compound']);
    return Result(
        formattedAddress: json['formatted_address'] as String,
        name: json['name'] as String,
        geometry: Geometry.fromJson(json['geometry']),
        compound: Compound.fromJson(json['compound']));
  }
}

class Geometry {
  Location location;

  Geometry({required this.location});
  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(location: Location.fromJson(json['location']));
  }
}

class Location {
  double lat;
  double lng;

  Location({required this.lat, required this.lng});
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'] as double,
      lng: json['lng'] as double,
    );
  }
}
