class TransactionResponseModel {
  final String orderId;
  final int paymentDetailsId;
  final PaymentResponseModel paymentResponse;
  TransactionResponseModel(
      {required this.orderId,
      required this.paymentDetailsId,
      required this.paymentResponse});
  factory TransactionResponseModel.fromJson(Map<String, dynamic> json) {
    return TransactionResponseModel(
      orderId: json['orderId'] as String,
      paymentDetailsId: json['paymentDetailsId'] as int,
      paymentResponse: PaymentResponseModel.fromJson(json['paymentResponse']),
    );
  }
}

class PaymentResponseModel {
  final String code;
  final String desc;
  final PaymentData data;

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
  final double amount;
  final String description;
  final int orderCode;
  final String status;
  final String checkoutUrl;
  final String qrCode;

  PaymentData({
    required this.amount,
    required this.description,
    required this.orderCode,
    required this.status,
    required this.checkoutUrl,
    required this.qrCode,
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
