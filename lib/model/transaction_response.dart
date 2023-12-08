class TransactionResponseModel {
  String? orderId;
  int? paymentDetailsId;
  PaymentResponseModel? paymentResponse;
  TransactionResponseModel(
      {this.orderId, this.paymentDetailsId, this.paymentResponse});
  factory TransactionResponseModel.fromJson(Map<String, dynamic>? json) {
    return TransactionResponseModel(
      orderId: json?['orderId'] as String?,
      paymentDetailsId: json?['paymentDetailsId'] as int?,
      paymentResponse: json?['paymentResponse'] != null
          ? PaymentResponseModel.fromJson(json?['paymentResponse'])
          : null,
    );
  }
}

class PaymentResponseModel {
  String? code;
  String? desc;
  PaymentData? data;

  PaymentResponseModel(
      {required this.code, required this.desc, required this.data});

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentResponseModel(
      code: json['code'] as String,
      desc: json['desc'] as String,
      data: PaymentData.fromJson(json['data']),
    );
  }
}

class PaymentData {
  double? amount;
  String? description;
  int? orderCode;
  String? status;
  String? checkoutUrl;
  String? qrCode;

  PaymentData({
    this.amount,
    this.description,
    this.orderCode,
    this.status,
    this.checkoutUrl,
    this.qrCode,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      amount: json['amount'] as double,
      description: json['description'] as String,
      orderCode: json['orderCode'] as int,
      status: json['status'] as String,
      checkoutUrl: json['checkoutUrl'] as String,
      qrCode: json['qrCode'] as String,
    );
  }
}
