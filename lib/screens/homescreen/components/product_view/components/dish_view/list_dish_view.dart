// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/controller/dish_controller.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/product_view/components/dish_view/dish_item.dart';
import 'package:fooddelivery_fe/widgets/empty_widget.dart';
import 'package:get/get.dart';

class ListDishView extends StatelessWidget {
  ListDishView({super.key});

  final dishController = Get.find<DishController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (dishController.listDish.value.isNotEmpty) {
          return Column(
              children: dishController.listDish.value
                  .map((dishItem) => DishItem(dishItem: dishItem))
                  .toList());
        }
        return EmptyWidgetSmall(
          assetsAnimations: "loading_1",
          tilte: tr("home.no_dish"),
        );
      },
    );
  }
}
