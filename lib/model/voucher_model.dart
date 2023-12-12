class VoucherModel {
  String? voucherID;
  DateTime? startDate;
  DateTime? expDate;
  String? voucherName;
  String? type;
  double? discountAmount;
  int? discountPercent;
  int? pointsRequired;

  VoucherModel({
    this.voucherID,
    this.startDate,
    this.expDate,
    this.voucherName,
    this.type,
    this.discountAmount,
    this.discountPercent,
    this.pointsRequired,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      voucherID: json['voucherID'],
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      expDate: json['expDate'] != null ? DateTime.parse(json['expDate']) : null,
      voucherName: json['voucherName'],
      type: json['type'],
      discountAmount: json['discountAmount']?.toDouble(),
      discountPercent: json['discountPercent'],
      pointsRequired: json['pointsRequired'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'voucherID': voucherID,
      'startDate': startDate?.toIso8601String(),
      'expDate': expDate?.toIso8601String(),
      'voucherName': voucherName,
      'type': type,
      'discountAmount': discountAmount,
      'discountPercent': discountPercent,
      'pointsRequired': pointsRequired,
    };
  }
}
