import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/controller/favorite_controller.dart';
import 'package:fooddelivery_fe/controller/order_controller.dart';
import 'package:fooddelivery_fe/controller/rating_order_controller.dart';
import 'package:fooddelivery_fe/controller/voucher_controller.dart';
import 'package:fooddelivery_fe/screens/favorite_screen/favorite_screen.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/settings_view/components/ultilities_card.dart';
import 'package:fooddelivery_fe/screens/order_screen/order_screen.dart';
import 'package:fooddelivery_fe/screens/rating_order/rating_order_screen.dart';
import 'package:fooddelivery_fe/screens/voucher_shop_screen/voucher_shop_screen.dart';
import 'package:get/get.dart';

class UltilitiesList {
  static late List<ExtensionCard> extensionsCard;
  static void initUtilitiesList() {
    extensionsCard = [
      ExtensionCard(
        onPressed: () {
          Get.put(OrderController());

          Get.to(() => const OrdersScreen(), transition: Transition.upToDown);
        },
        icon: CupertinoIcons.square_list,
        title: tr("more.order_history"),
      ),
      ExtensionCard(
        onPressed: () {
          final orderController = Get.put(VoucherController());
          orderController.getAllVoucher();
          Get.to(() => VoucherShopScreen(), transition: Transition.upToDown);
        },
        icon: Icons.discount,
        title: tr("more.get_voucher"),
      ),
      ExtensionCard(
        onPressed: () async {
          final orderController = Get.put(RatingOrderController());
          orderController.getAllCompleteOrder();
          orderController.getAllRatedOrder();
          Get.to(() => RatingOrderScreen(), transition: Transition.upToDown);
        },
        icon: Icons.star,
        title: tr("more.order_review"),
      ),
      ExtensionCard(
        onPressed: () {
          final favoriteController = Get.find<FavoriteController>();
          favoriteController.getAccountListFavoriteDish();
          Get.to(() => FavoriteScreen(), transition: Transition.upToDown);
        },
        icon: CupertinoIcons.heart_circle_fill,
        title: tr("more.favorite_food"),
      ),
    ];
  }
}
