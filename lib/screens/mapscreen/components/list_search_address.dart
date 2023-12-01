import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/controller/map_controller.dart';
import 'package:get/get.dart';

class ListAddress extends StatelessWidget {
  final MapController mapController;
  const ListAddress({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: mapController.places.value.length,
        itemBuilder: (context, index) {
          final perdictionAddress = mapController.places.value[index];
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
                    perdictionAddress.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
            onTap: () async {
              await mapController.getLocation(perdictionAddress.description);
            },
          );
        },
      ),
    );
  }
}
