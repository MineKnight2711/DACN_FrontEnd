import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/controller/voucher_controller.dart';

class SortingPopupMenu extends StatelessWidget {
  final VoucherController voucherController;
  const SortingPopupMenu({super.key, required this.voucherController});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(tr("exchange_voucher.sort_by")),
        PopupMenuButton(
          icon: Image.asset(
            'assets/images/menu_icon.png',
            color: Colors.black,
            scale: 4,
          ),
          itemBuilder: (context) => <PopupMenuEntry>[
            PopupMenuItem(
              child: PopupMenuButton<SortVoucherByPoints>(
                child: Text(tr("exchange_voucher.sort_points_redeem")),
                onSelected: (sortByPoints) {
                  voucherController.sortByExpDateController.value =
                      voucherController.sortByStartDateController.value =
                          voucherController.sortByTypeController.value = null;
                  voucherController.sortByPointsController.value = sortByPoints;
                  voucherController.sortListOrder();
                },
                itemBuilder: (context) => <PopupMenuEntry<SortVoucherByPoints>>[
                  PopupMenuItem<SortVoucherByPoints>(
                    value: SortVoucherByPoints.lowToHigh,
                    child: Row(
                      children: [
                        Text(tr("exchange_voucher.point_low")),
                        const Icon(Icons.arrow_drop_up_sharp),
                      ],
                    ),
                  ),
                  PopupMenuItem<SortVoucherByPoints>(
                    value: SortVoucherByPoints.highToLow,
                    child: Row(
                      children: [
                        Text(tr("exchange_voucher.point_high")),
                        const Icon(Icons.arrow_drop_down_sharp),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem(
              child: PopupMenuButton<SortVoucherByExpDate>(
                child: Text(tr("exchange_voucher.sort_expiration_date")),
                onSelected: (sortByExpDateController) {
                  voucherController.sortByPointsController.value =
                      voucherController.sortByStartDateController.value =
                          voucherController.sortByTypeController.value = null;
                  voucherController.sortByExpDateController.value =
                      sortByExpDateController;
                  voucherController.sortListOrder();
                },
                itemBuilder: (context) =>
                    <PopupMenuEntry<SortVoucherByExpDate>>[
                  PopupMenuItem<SortVoucherByExpDate>(
                    value: SortVoucherByExpDate.nearest,
                    child: Row(
                      children: [
                        Text(tr("exchange_voucher.nearest_day")),
                        Icon(Icons.arrow_drop_up_sharp),
                      ],
                    ),
                  ),
                  PopupMenuItem<SortVoucherByExpDate>(
                    value: SortVoucherByExpDate.furthest,
                    child: Row(
                      children: [
                        Text(tr("exchange_voucher.farthest_day")),
                        Icon(Icons.arrow_drop_down_sharp),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem(
              child: PopupMenuButton<SortVoucherByStartDate>(
                child: Text(tr("exchange_voucher.sort_start_date")),
                onSelected: (sortByStartDateController) {
                  voucherController.sortByPointsController.value =
                      voucherController.sortByExpDateController.value =
                          voucherController.sortByTypeController.value = null;
                  voucherController.sortByStartDateController.value =
                      sortByStartDateController;
                  voucherController.sortListOrder();
                },
                itemBuilder: (context) =>
                    <PopupMenuEntry<SortVoucherByStartDate>>[
                  PopupMenuItem<SortVoucherByStartDate>(
                    value: SortVoucherByStartDate.nearest,
                    child: Row(
                      children: [
                        Text(tr("exchange_voucher.nearest_day")),
                        Icon(Icons.arrow_drop_up_sharp),
                      ],
                    ),
                  ),
                  PopupMenuItem<SortVoucherByStartDate>(
                    value: SortVoucherByStartDate.furthest,
                    child: Row(
                      children: [
                        Text(tr("exchange_voucher.farthest_day")),
                        Icon(Icons.arrow_drop_down_sharp),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem(
              child: PopupMenuButton<SortVoucherByType>(
                child: Text(tr("exchange_voucher.sort_voucher_type")),
                onSelected: (sortByTypeController) {
                  voucherController.sortByPointsController.value =
                      voucherController.sortByStartDateController.value =
                          voucherController.sortByExpDateController.value =
                              null;
                  voucherController.sortByTypeController.value =
                      sortByTypeController;
                  voucherController.sortListOrder();
                },
                itemBuilder: (context) => <PopupMenuEntry<SortVoucherByType>>[
                  PopupMenuItem<SortVoucherByType>(
                    value: SortVoucherByType.percent,
                    child: Text(tr("exchange_voucher.percent")),
                  ),
                  PopupMenuItem<SortVoucherByType>(
                    value: SortVoucherByType.amount,
                    child: Text("exchange_voucher.amount_money"),
                  ),
                ],
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem(
              child: Text(tr("exchange_voucher.all_vouchers")),
              onTap: () {
                voucherController.sortByPointsController.value =
                    voucherController.sortByStartDateController.value =
                        voucherController.sortByExpDateController.value =
                            voucherController.sortByTypeController.value = null;
                voucherController.listVoucher.value =
                    List.from(voucherController.storedListVoucher);
              },
            ),
          ],
        ),
      ],
    );
  }
}
