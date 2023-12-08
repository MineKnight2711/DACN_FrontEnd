class OrderDTO {
  int? quantity;
  DateTime? orderDate;
  String? deliveryInfo;
  List<DishItem>? dishes;

  OrderDTO({
    this.quantity,
    this.orderDate,
    this.deliveryInfo,
    this.dishes,
  });

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'orderDate': DateTime.now().toIso8601String(),
      'deliveryInfo': deliveryInfo,
      'dishes': dishes?.map((e) => e.toJson()).toList(),
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

  double? amount;
  String? paidTime;

  PaymentDetails({
    this.paymentId,
    this.amount,
    this.paidTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'paymentId': paymentId,
      'amount': amount,
      'paidTime': DateTime.now().toIso8601String(),
    };
  }
}

class PaymentRequestBody {
  double? amount;
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
  OrderDTO? ordersDTO;
  PaymentDetails? paymentDetailsDTO;
  PaymentRequestBody? paymentRequestBody;

  TransactionModel({
    this.accountId,
    this.ordersDTO,
    this.paymentDetailsDTO,
    this.paymentRequestBody,
  });
  Map<String, dynamic> toVietQRJson() {
    return {
      'accountId': accountId,
      'ordersDTO': ordersDTO?.toJson(),
      'paymentDetailsDTO': paymentDetailsDTO?.toJson(),
      'paymentRequestBody': paymentDetailsDTO?.toJson(),
    };
  }

  Map<String, dynamic> toCODJson() {
    return {
      'accountId': accountId,
      'ordersDTO': ordersDTO?.toJson(),
      'paymentDetailsDTO': paymentDetailsDTO?.toJson(),
    };
  }
}
