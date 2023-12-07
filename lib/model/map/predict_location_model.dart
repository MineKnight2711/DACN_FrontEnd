class PredictLocationResponse {
  List<Prediction> predictions;
  String status;

  PredictLocationResponse({required this.predictions, required this.status});
  factory PredictLocationResponse.fromJson(Map<String, dynamic> json) {
    return PredictLocationResponse(
        predictions: (json['predictions'] as List<dynamic>)
            .map((p) => Prediction.fromJson(p))
            .toList(),
        status: json['status'] as String);
  }
}

class Prediction {
  String description;
  String placeId;
  Compound compound;

  Prediction({
    required this.description,
    required this.compound,
    required this.placeId,
  });
  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      placeId: json['place_id'] as String,
      description: json['description'] as String,
      compound: Compound.fromJson(json['compound']),
    );
  }
}

class Compound {
  String district;
  String commune;
  String province;

  Compound(
      {required this.district, required this.commune, required this.province});
  factory Compound.fromJson(Map<String, dynamic> json) {
    return Compound(
      district: json['district'],
      commune: json['commune'],
      province: json['province'],
    );
  }
}
