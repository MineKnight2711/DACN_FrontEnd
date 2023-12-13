import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/model/order_model.dart';
import 'package:fooddelivery_fe/screens/rating_order/components/rating_order_bottom_sheet.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';
import 'package:fooddelivery_fe/widgets/custom_button.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';

class OrderDetailsBottomSheet extends StatelessWidget {
  final OrderDetailsDTO orderDetails;
  final ScrollController? scrollController;
  const OrderDetailsBottomSheet({
    super.key,
    required this.orderDetails,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OrderDetailsBottomSheetHeader(),
        Container(
          alignment: Alignment.center,
          color: Colors.lightBlue.withOpacity(0.2),
          child: SizedBox(
            width: 0.55.sw,
            height: 0.3.sh,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6969),
              child: Image.asset(
                "assets/images/order_banner.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Divider(
          height: 30.h,
          thickness: 3.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Trạng thái",
                textAlign: TextAlign.center,
                style: CustomFonts.customGoogleFonts(
                  fontSize: 14.r,
                  color: AppColors.dark20,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "${orderDetails.order?.status}",
                textAlign: TextAlign.center,
                style: CustomFonts.customGoogleFonts(
                  fontSize: 16.r,
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 20.h,
          thickness: 3.h,
        ),
        Row(
          mainAxisAlignment: "${orderDetails.order?.status}" == "Đã hoàn tất"
              ? MainAxisAlignment.spaceEvenly
              : "${orderDetails.order?.status}" == "Chờ thanh toán"
                  ? MainAxisAlignment.spaceEvenly
                  : MainAxisAlignment.center,
          children: [
            "${orderDetails.order?.status}" == "Đã hoàn tất"
                ? SizedBox(
                    height: 0.05.sh,
                    child: RoundIconButton(
                      size: 40.w,
                      title: "Đánh giá",
                      onPressed: () {},
                    ),
                  )
                : const SizedBox.shrink(),
            "${orderDetails.order?.status}" == "Chờ thanh toán"
                ? SizedBox(
                    height: 0.05.sh,
                    child: RoundIconButton(
                      size: 60.w,
                      title: "Thanh toán ngay!",
                      onPressed: () {},
                    ),
                  )
                : const SizedBox.shrink(),
            SizedBox(
              height: 0.05.sh,
              child: RoundIconButton(
                size: "${orderDetails.order?.status}" == "Đã hoàn tất"
                    ? 40.w
                    : "${orderDetails.order?.status}" == "Chờ thanh toán"
                        ? 40.w
                        : 80.w,
                title: "Đặt lại",
                onPressed: () {},
              ),
            )
          ],
        ),
        Divider(
          height: 20.h,
          thickness: 3.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Text(
                "Thông tin đơn hàng",
                style: CustomFonts.customGoogleFonts(fontSize: 16.r),
              ),
              SizedBox(
                height: 15.h,
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tên người nhận',
                          style: CustomFonts.customGoogleFonts(
                              fontSize: 14.r, color: AppColors.dark20),
                        ),
                        Text(
                          '${(orderDetails.order?.deliveryInfo?.split("|")[1])?.split(",")[0]}',
                          style: CustomFonts.customGoogleFonts(fontSize: 14.r),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      height: 40,
                      width: 0.8,
                      color: Colors.black,
                    ),
                  ),
                  Positioned(
                    right: 90,
                    child: Column(
                      children: [
                        Text(
                          'Số điện thoại',
                          style: CustomFonts.customGoogleFonts(
                              fontSize: 14.r, color: AppColors.dark20),
                        ),
                        Text(
                          '${(orderDetails.order?.deliveryInfo?.split("|")[1])?.split(",")[1]}',
                          style: CustomFonts.customGoogleFonts(
                            fontSize: 14.r,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                height: 20.h,
                thickness: 1.h,
              ),
              Text(
                "Địa chỉ",
                style: CustomFonts.customGoogleFonts(
                    fontSize: 14.r, color: AppColors.dark20),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "${orderDetails.order?.deliveryInfo?.split("|")[0]}",
                style: CustomFonts.customGoogleFonts(fontSize: 15.r),
              ),
              Divider(
                height: 20.h,
                thickness: 1.h,
              ),
              Text(
                "Trạng thái thanh toán",
                style: CustomFonts.customGoogleFonts(
                    fontSize: 14.r, color: AppColors.dark20),
              ),
              "${orderDetails.order?.status}" == "Đã thanh toán" ||
                      "${orderDetails.order?.status}" == "Đã hoàn tất"
                  ? Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "${orderDetails.order?.status}",
                          style: CustomFonts.customGoogleFonts(fontSize: 15.r),
                        ),
                      ],
                    )
                  : "${orderDetails.order?.status}" == "Đã huỷ"
                      ? Row(
                          children: [
                            const Icon(CupertinoIcons.xmark_circle_fill,
                                color: Colors.redAccent),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "Đã huỷ",
                              style:
                                  CustomFonts.customGoogleFonts(fontSize: 15.r),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            const Icon(CupertinoIcons.xmark_circle_fill,
                                color: Colors.redAccent),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "Chưa thanh toán",
                              style:
                                  CustomFonts.customGoogleFonts(fontSize: 15.r),
                            ),
                          ],
                        ),
            ],
          ),
        ),
        Divider(
          height: 20.h,
          thickness: 3.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            "Các sản phẩm đã đặt",
            style: CustomFonts.customGoogleFonts(
              fontSize: 16.r,
            ),
          ),
        ),
        orderDetails.detailList != null
            ? SizedBox(
                height: orderDetails.detailList!.length * (60.h + 1.h),
                child: Column(
                  children: orderDetails.detailList!
                      .map((details) => SizedBox(
                            height: 60.h,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Padding(
                                    padding: EdgeInsets.only(top: 2.5.h),
                                    child: Text(
                                      "${(details.price ?? 0) ~/ double.parse("${details.dish?.price}")}x",
                                      style: CustomFonts.customGoogleFonts(
                                          fontSize: 14.r),
                                    ),
                                  ),
                                  title: Text(
                                    "${details.dish?.dishName}",
                                    style: CustomFonts.customGoogleFonts(
                                        fontSize: 14.r),
                                  ),
                                  trailing: Text(
                                      DataConvert()
                                          .formatCurrency(details.price ?? 0.0),
                                      style: CustomFonts.customGoogleFonts(
                                          fontSize: 14.r)),
                                ),
                                Divider(
                                  height: 1.h,
                                  indent: 10.w,
                                  endIndent: 10.w,
                                  thickness: 1.h,
                                )
                              ],
                            ),
                          ))
                      .toList(),
                ),
              )
            : const Card(),
        Divider(
          height: 20.h,
          thickness: 3.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tổng cộng",
                style: CustomFonts.customGoogleFonts(
                  fontSize: 16.r,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Thành tiền",
                    style: CustomFonts.customGoogleFonts(
                      fontSize: 14.r,
                    ),
                  ),
                  Text(
                    DataConvert()
                        .formatCurrency(orderDetails.detailList?.fold<double>(
                              0.0,
                              (previousValue, details) =>
                                  previousValue + (details.price ?? 0.0),
                            ) ??
                            0.0),
                    style: CustomFonts.customGoogleFonts(
                      fontSize: 14.r,
                    ),
                  ),
                ],
              ),
              Divider(
                height: 20.h,
                thickness: 1.h,
              ),
              orderDetails.order?.voucher != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Khuyến mãi sử dụng",
                              style: CustomFonts.customGoogleFonts(
                                fontSize: 14.r,
                              ),
                            ),
                            Text(
                              "Tên khuyến mãi",
                              style: CustomFonts.customGoogleFonts(
                                fontSize: 14.r,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "-${DataConvert().formatCurrency(-10000)}",
                          style: CustomFonts.customGoogleFonts(
                            fontSize: 14.r,
                          ),
                        ),
                      ],
                    )
                  : const Card(),
              orderDetails.order?.voucher != null
                  ? Divider(
                      height: 25.h,
                      thickness: 1.h,
                    )
                  : const SizedBox.shrink(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Số tiền thanh toán",
                    style: CustomFonts.customGoogleFonts(
                      fontSize: 14.r,
                    ),
                  ),
                  Text(
                    DataConvert().formatCurrency(10000),
                    style: CustomFonts.customGoogleFonts(
                      fontSize: 14.r,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class OrderDetailsBottomSheetHeader extends StatelessWidget {
  const OrderDetailsBottomSheetHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 5.h),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 10.h),
            child: Text(
              "Chi tiết đơn hàng",
              textAlign: TextAlign.center,
              style: CustomFonts.customGoogleFonts(fontSize: 16.r),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
