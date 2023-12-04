import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:google_fonts/google_fonts.dart';

class ListSearchAddress extends StatelessWidget {
  final List<dynamic> listItem;
  final ValueChanged<dynamic> onItemSelected;
  const ListSearchAddress(
      {super.key, required this.listItem, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400.w,
      height: 120.h,
      child: NoGlowingScrollView(
        child: Column(
          children: listItem
              .map((item) => SizedBox(
                    height: 40.h,
                    child: ListTile(
                      onTap: () {
                        listItem.clear();
                        onItemSelected(item);
                      },
                      leading: const Icon(CupertinoIcons.location_solid),
                      title: Text(
                        item.name,
                        style: GoogleFonts.roboto(fontSize: 14.r),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
    //  ListView.builder(
    //   itemCount: listItem.length,
    //   itemBuilder: (context, index) {
    //     final perdictionAddress = mapController.places.value[index];
    //     return ListTile(
    //       horizontalTitleGap: 5,
    //       title: Row(
    //         children: [
    //           const Icon(
    //             Icons.location_on_outlined,
    //             color: Colors.blue,
    //             size: 20,
    //           ),
    //           Expanded(
    //             child: Text(
    //               perdictionAddress.description,
    //               overflow: TextOverflow.ellipsis,
    //               maxLines: 1,
    //               style: const TextStyle(
    //                 color: Colors.black54,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //       onTap: () async {
    //         await mapController.getLocation(perdictionAddress.description);
    //       },
    //     );
    //   },
    // );
  }
}
