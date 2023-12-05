import 'dart:convert';

import 'package:fooddelivery_fe/model/cart_model.dart';
import 'package:fooddelivery_fe/model/dish_model.dart';

class Order {
  String? status;
  int? quantity;
  DateTime? orderDate;
  String? deliveryInfo;
  List<DishItem>? dishes;

  Order({
    this.status,
    this.quantity,
    this.orderDate,
    this.deliveryInfo,
    this.dishes,
  });

  // factory Order.fromJson(Map<String, dynamic> json) {
  //   return Order(
  //     status: json['status'],
  //     quantity: json['quantity'],
  //     orderDate: json['orderDate'],
  //     deliveryInfo: json['deliveryInfo'],
  //     dishes: (json['dishes'] as List)
  //         .map((dish) => DishItem.fromJson(dish))
  //         .toList(),
  //   );
  // }
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'quantity': quantity,
      'orderDate': DateTime.now(),
      'deliveryInfo': deliveryInfo,
      'dishes': jsonEncode(dishes),
    };
  }
}

class DishItem {
  String? dishId;
  int? quantity;

  DishItem({
    this.dishId,
    this.quantity,
  });

  factory DishItem.fromJson(Map<String, dynamic> json) {
    return DishItem(
      dishId: json['dishId'],
      quantity: json['quantity'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'dishId': dishId,
      'quantity': quantity,
    };
  }
}

class PaymentDetails {
  String? paymentId;
  String? info;
  String? status;
  int? amount;
  String? paidTime;

  PaymentDetails({
    this.paymentId,
    this.info,
    this.status,
    this.amount,
    this.paidTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'paymentId': paymentId,
      'info': info,
      'status': status,
      'amount': amount,
      'paidTime': DateTime.now(),
    };
  }
}

class PaymentRequestBody {
  int? amount;
  String? cancelUrl;
  String? returnUrl;
  String? description;

  PaymentRequestBody({
    this.amount,
    this.cancelUrl,
    this.returnUrl,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'returnUrl': returnUrl,
      'cancelUrl': cancelUrl,
      'description': description,
    };
  }
}

class TransactionModel {
  String? accountId;
  Order? ordersDTO;
  PaymentDetails? paymentDetailsDTO;
  PaymentRequestBody? paymentRequestBody;

  TransactionModel({
    this.accountId,
    this.ordersDTO,
    this.paymentDetailsDTO,
    this.paymentRequestBody,
  });
  Map<String, dynamic> toJson() {
    return {
      'amount': accountId,
      'ordersDTO': ordersDTO?.toJson(),
      'paymentDetailsDTO': paymentDetailsDTO?.toJson(),
      'paymentRequestBody': paymentDetailsDTO?.toJson(),
    };
  }
}
