import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/api/vietnam_province_api/province_api.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:get/get.dart';

class ListProvince extends StatelessWidget {
  final ProvinceApi provinceApi;
  const ListProvince({super.key, required this.provinceApi});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: provinceApi.listProvince.length,
        itemBuilder: (context, index) {
          final perdictionProvince = provinceApi.listProvince[index];
          return ListTile(
            horizontalTitleGap: 5,
            title: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.blue,
                  size: 20,
                ),
                Expanded(
                  child: Text(
                    perdictionProvince.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: AppColors.dark50,
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              provinceApi.selectedProvince.value = perdictionProvince;
              provinceApi.listProvince.clear();
              provinceApi.textControllers.value.txtProvince.text =
                  perdictionProvince.name;
            },
          );
        },
      ),
    );
  }
}

class ListDistrict extends StatelessWidget {
  final ProvinceApi provinceApi;
  const ListDistrict({super.key, required this.provinceApi});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: provinceApi.listDistrict.length,
        itemBuilder: (context, index) {
          final perdictionDistrict = provinceApi.listDistrict[index];
          return ListTile(
            horizontalTitleGap: 5,
            title: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.blue,
                  size: 20,
                ),
                Expanded(
                  child: Text(
                    perdictionDistrict.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: AppColors.dark50,
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              provinceApi.selectedDistrict.value = perdictionDistrict;
              provinceApi.listDistrict.clear();
              provinceApi.textControllers.value.txtDistrict.text =
                  perdictionDistrict.name;
            },
          );
        },
      ),
    );
  }
}

class ListWard extends StatelessWidget {
  final ProvinceApi provinceApi;
  const ListWard({super.key, required this.provinceApi});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: provinceApi.listWard.length,
        itemBuilder: (context, index) {
          final perdictionWard = provinceApi.listWard[index];
          return ListTile(
            horizontalTitleGap: 5,
            title: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.blue,
                  size: 20,
                ),
                Expanded(
                  child: Text(
                    perdictionWard.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: AppColors.dark50,
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {
              provinceApi.selectedWard.value = perdictionWard;
              provinceApi.listWard.clear();
              provinceApi.textControllers.value.txtWard.text =
                  perdictionWard.name;
            },
          );
        },
      ),
    );
  }
}
