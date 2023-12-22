import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:fooddelivery_fe/model/dish_model.dart';
import 'package:fooddelivery_fe/model/voucher_model.dart';

class OrderDetailsDTO {
  OrderModel? order;
  String? paymentMethod;
  List<DetailsDTO>? detailList;

  OrderDetailsDTO({this.order, this.paymentMethod, this.detailList});

  factory OrderDetailsDTO.fromJson(Map<String, dynamic> json) {
    return OrderDetailsDTO(
      order: json['order'] != null ? OrderModel.fromJson(json['order']) : null,
      paymentMethod: json['paymentMethod'] ?? "",
      detailList: json['detailList'] != null
          ? (json['detailList'] as List)
              .map((detail) => DetailsDTO.fromJson(detail))
              .toList()
          : null,
    );
  }
}

class OrderModel {
  String? orderID;
  String? status;
  String? deliveryInfo;
  int? quantity;
  double? score;
  String? feedBack;
  DateTime? dateFeedBack;
  VoucherModel? voucher;
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
      voucher: json['voucher'] != null
          ? VoucherModel.fromJson(json['voucher'])
          : null,
      account: json['account'] != null
          ? AccountModel.fromJson(json['account'])
          : null,
      orderDate:
          json['orderDate'] != null ? DateTime.parse(json['orderDate']) : null,
    );
  }
}

class DetailsDTO {
  DishModel? dish;
  int? amount;
  double? price;

  DetailsDTO({this.dish, this.amount, this.price});

  factory DetailsDTO.fromJson(Map<String, dynamic> json) {
    return DetailsDTO(
      dish: json['dish'] != null ? DishModel.fromJson(json['dish']) : null,
      amount: json['amount'],
      price: json['price'],
    );
  }
}
