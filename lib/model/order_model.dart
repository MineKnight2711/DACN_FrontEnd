import 'package:fooddelivery_fe/model/account_model.dart';

class OrderModel {
  String? orderID;
  String? status;
  String? deliveryInfo;
  int? quantity;
  double? score;
  String? feedBack;
  DateTime? dateFeedBack;
  String? voucher;
  AccountModel? account;
  DateTime? orderDate;

  OrderModel({
    this.orderID,
    this.status,
    this.deliveryInfo,
    this.quantity,
    this.score,
    this.feedBack,
    this.dateFeedBack,
    this.voucher,
    this.account,
    this.orderDate,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderID: json['orderID'],
      status: json['status'],
      deliveryInfo: json['deliveryInfo'],
      quantity: json['quantity'],
      score: json['score'],
      feedBack: json['feedBack'],
      dateFeedBack: json['dateFeedBack'] != null
          ? DateTime.parse(json['dateFeedBack'])
          : null,
      voucher: json['voucher'],
      account: json['account'] != null
          ? AccountModel.fromJson(json['account'])
          : null,
      orderDate:
          json['orderDate'] != null ? DateTime.parse(json['orderDate']) : null,
    );
  }
}
