class PaymentModel {
  String? paymentID;
  String? paymentMethod;

  PaymentModel({this.paymentID, this.paymentMethod});

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      paymentID: json['paymentID'] as String,
      paymentMethod: json['paymentMethod'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentID': paymentID,
      'paymentMethod': paymentMethod,
    };
  }
}
