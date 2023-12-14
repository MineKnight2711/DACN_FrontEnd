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
        const Text('Xếp theo'),
        PopupMenuButton(
          icon: Image.asset(
            'assets/images/menu_icon.png',
            color: Colors.black,
            scale: 4,
          ),
          itemBuilder: (context) => <PopupMenuEntry>[
            PopupMenuItem(
              child: PopupMenuButton<SortVoucherByPoints>(
                child: const Text('Xếp theo điểm cần đổi'),
                onSelected: (sortByPoints) {
                  voucherController.sortByExpDateController.value =
                      voucherController.sortByStartDateController.value =
                          voucherController.sortByTypeController.value = null;
                  voucherController.sortByPointsController.value = sortByPoints;
                  voucherController.sortListOrder();
                },
                itemBuilder: (context) =>
                    const <PopupMenuEntry<SortVoucherByPoints>>[
                  PopupMenuItem<SortVoucherByPoints>(
                    value: SortVoucherByPoints.lowToHigh,
                    child: Row(
                      children: [
                        Text('Điểm: Thấp đến cao'),
                        Icon(Icons.arrow_drop_up_sharp),
                      ],
                    ),
                  ),
                  PopupMenuItem<SortVoucherByPoints>(
                    value: SortVoucherByPoints.highToLow,
                    child: Row(
                      children: [
                        Text('Điểm: Cao đến thấp'),
                        Icon(Icons.arrow_drop_down_sharp),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem(
              child: PopupMenuButton<SortVoucherByExpDate>(
                child: const Text('Xếp theo ngày hết hạn'),
                onSelected: (sortByExpDateController) {
                  voucherController.sortByPointsController.value =
                      voucherController.sortByStartDateController.value =
                          voucherController.sortByTypeController.value = null;
                  voucherController.sortByExpDateController.value =
                      sortByExpDateController;
                  voucherController.sortListOrder();
                },
                itemBuilder: (context) =>
                    const <PopupMenuEntry<SortVoucherByExpDate>>[
                  PopupMenuItem<SortVoucherByExpDate>(
                    value: SortVoucherByExpDate.nearest,
                    child: Row(
                      children: [
                        Text('Ngày gần nhất'),
                        Icon(Icons.arrow_drop_up_sharp),
                      ],
                    ),
                  ),
                  PopupMenuItem<SortVoucherByExpDate>(
                    value: SortVoucherByExpDate.furthest,
                    child: Row(
                      children: [
                        Text('Ngày xa nhất'),
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
                child: const Text('Xếp theo ngày bắt đầu'),
                onSelected: (sortByStartDateController) {
                  voucherController.sortByPointsController.value =
                      voucherController.sortByExpDateController.value =
                          voucherController.sortByTypeController.value = null;
                  voucherController.sortByStartDateController.value =
                      sortByStartDateController;
                  voucherController.sortListOrder();
                },
                itemBuilder: (context) =>
                    const <PopupMenuEntry<SortVoucherByStartDate>>[
                  PopupMenuItem<SortVoucherByStartDate>(
                    value: SortVoucherByStartDate.nearest,
                    child: Row(
                      children: [
                        Text('Ngày gần nhất'),
                        Icon(Icons.arrow_drop_up_sharp),
                      ],
                    ),
                  ),
                  PopupMenuItem<SortVoucherByStartDate>(
                    value: SortVoucherByStartDate.furthest,
                    child: Row(
                      children: [
                        Text('Ngày xa nhất'),
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
                child: const Text('Xếp theo loại voucher'),
                onSelected: (sortByTypeController) {
                  voucherController.sortByPointsController.value =
                      voucherController.sortByStartDateController.value =
                          voucherController.sortByExpDateController.value =
                              null;
                  voucherController.sortByTypeController.value =
                      sortByTypeController;
                  voucherController.sortListOrder();
                },
                itemBuilder: (context) =>
                    const <PopupMenuEntry<SortVoucherByType>>[
                  PopupMenuItem<SortVoucherByType>(
                    value: SortVoucherByType.percent,
                    child: Text('Phần trăm'),
                  ),
                  PopupMenuItem<SortVoucherByType>(
                    value: SortVoucherByType.amount,
                    child: Text('Số tiền'),
                  ),
                ],
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem(
              child: const Text('Tất cả voucher'),
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
