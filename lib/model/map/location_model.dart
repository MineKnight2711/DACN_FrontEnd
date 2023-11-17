class LocationResponse {
  List<Result> results;
  String status;

  LocationResponse({required this.results, required this.status});
  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    return LocationResponse(
        results:
            (json['results'] as List).map((p) => Result.fromJson(p)).toList(),
        status: json['status'] as String);
  }
}

class Result {
  String formattedAddress;
  Geometry geometry;
  String name;
  String address;

  Result(
      {required this.formattedAddress,
      required this.geometry,
      required this.name,
      required this.address});
  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
        formattedAddress: json['formatted_address'] as String,
        name: json['name'] as String,
        address: json['address'] as String,
        geometry: Geometry.fromJson(json['geometry']));
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
  String lat;
  String lng;

  Location({required this.lat, required this.lng});
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
