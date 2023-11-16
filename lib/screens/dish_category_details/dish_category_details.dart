import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/screens/item_details/item_details_view.dart';
import 'package:fooddelivery_fe/utils/custom/color_extension.dart';
import 'package:fooddelivery_fe/widgets/filter_view.dart';
import 'package:fooddelivery_fe/widgets/line_textfield.dart';
import 'package:fooddelivery_fe/widgets/category_by_list_row.dart';
import 'package:fooddelivery_fe/widgets/popup_layout.dart';

class DishCategoryDetailsView extends StatefulWidget {
  const DishCategoryDetailsView({super.key});

  @override
  State<DishCategoryDetailsView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<DishCategoryDetailsView> {
  TextEditingController txtSearch = TextEditingController();

  List nearbyArr = [
    {
      "name": "Cơm Gà",
      "description": "Cơm gà nhà làm, ngon như nhà làm...",
      "category": "Cơm",
      "image": "assets/img/l1.png",
      "time": "11:30AM to 11:00PM",
      "kilometter": "2.8 KM",
      "rate": 4.8
    },
    {
      "name": "Phở Thịt Bò",
      "description": "Phở thịt bò nhà làm, ngon như nhà làm...",
      "category": "Phở, Noodles",
      "image": "assets/img/l2.png",
      "time": "11:30AM to 11:00PM",
      "kilometter": "2.8 KM",
      "rate": 3.8
    },
    {
      "name": "Cơm Sườn Nướng",
      "description": "Cơm sườn nướng nhà làm, ngon như nhà làm...",
      "category": "Cơm",
      "image": "assets/img/l3.png",
      "time": "11:30AM to 11:00PM",
      "kilometter": "2.8 KM",
      "rate": 2.8
    },
    {
      "name": "Bún Riêu Cua",
      "description": "Bún riêu cua nhà làm, ngon như nhà làm...",
      "category": "Seafood, Spain",
      "image": "assets/img/t1.png",
      "time": "11:30AM to 11:00PM",
      "kilometter": "2.8 KM",
      "rate": 5.0
    },
    {
      "name": "Cơm Gà",
      "description": "Cơm gà nhà làm, ngon như nhà làm...",
      "category": "Cơm",
      "image": "assets/img/l1.png",
      "time": "11:30AM to 11:00PM",
      "kilometter": "2.8 KM",
      "rate": 4.8
    },
    {
      "name": "Phở Thịt Bò",
      "description": "Phở thịt bò nhà làm, ngon như nhà làm...",
      "category": "Phở, Noodles",
      "image": "assets/img/l2.png",
      "time": "11:30AM to 11:00PM",
      "kilometter": "2.8 KM",
      "rate": 3.8
    },
    {
      "name": "Cơm Sườn Nướng",
      "description": "Cơm sườn nướng nhà làm, ngon như nhà làm...",
      "category": "Cơm",
      "image": "assets/img/l3.png",
      "time": "11:30AM to 11:00PM",
      "kilometter": "2.8 KM",
      "rate": 2.8
    },
    {
      "name": "Bún Riêu Cua",
      "description": "Bún riêu cua nhà làm, ngon như nhà làm...",
      "category": "Seafood, Spain",
      "image": "assets/img/t1.png",
      "time": "11:30AM to 11:00PM",
      "kilometter": "2.8 KM",
      "rate": 5.0
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.bg,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              pinned: true,
              floating: false,
              centerTitle: false,
              leadingWidth: 0,
              title: Row(
                children: [
                  Image.asset(
                    "assets/img/bookmark_icon.png",
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Cơm - Phở, Bún...",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: TColor.text,
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              pinned: false,
              floating: true,
              primary: false,
              expandedHeight: 50,
              flexibleSpace: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: RoundTextField(
                  controller: txtSearch,
                  hitText: "Search for name dish category",
                  leftIcon: Icon(Icons.search, color: TColor.gray),
                ),
              ),
            ),
          ];
        },
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            ListView.builder(
              itemCount: nearbyArr.length,
              itemBuilder: (context, index) {
                var fObj = nearbyArr[index] as Map? ?? {};
                return GestureDetector(
                  onTap: () {
                    // Xử lý sự kiện khi nhấn vào item
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetailsView(),
                      ),
                    );
                  },
                  child: CategoryByListRow(
                    fObj: fObj,
                    isBookmark: true,
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context, PopupLayout(child: const FilterView()));
                    },
                    child: Text(
                      "Filter",
                      style: TextStyle(
                          color: TColor.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
