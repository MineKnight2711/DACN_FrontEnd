class PaymentResponse {
  String? code;
  String? desc;
  PaymentResponseData? data;

  PaymentResponse({this.code, this.desc, this.data});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      code: json['code'],
      desc: json['desc'],
      data: PaymentResponseData.fromJson(json['data']),
    );
  }
}

class PaymentResponseData {
  int? amount;
  String? description;
  int? orderCode;
  String? status;
  String? checkoutUrl;
  String? qrCode;

  PaymentResponseData({
    this.amount,
    this.description,
    this.orderCode,
    this.status,
    this.checkoutUrl,
    this.qrCode,
  });

  factory PaymentResponseData.fromJson(Map<String, dynamic> json) {
    return PaymentResponseData(
      amount: json['amount'],
      description: json['description'],
      orderCode: json['orderCode'],
      status: json['status'],
      checkoutUrl: json['checkoutUrl'],
      qrCode: json['qrCode'],
    );
  }
}
