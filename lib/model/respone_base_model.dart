class ResponseBaseModel {
  String? id;
  String? apiVersion;
  String? message;
  dynamic data;

  ResponseBaseModel({
    this.apiVersion,
    this.id,
    this.message,
    this.data,
  });

  factory ResponseBaseModel.fromJson(Map<String, dynamic> json) {
    return ResponseBaseModel(
      id: json['id'],
      apiVersion: json['apiVersion'],
      message: json['message'],
      data: json['data'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['apiVersion'] = apiVersion;
    data['message'] = message;
    data['data'] = data;
    return data;
  }
}
