import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/screens/goongmap/autocomplete.dart';
import 'package:fooddelivery_fe/screens/my_order/my_order_view.dart';
import 'package:fooddelivery_fe/utils/custom/color_extension.dart';

import 'package:fooddelivery_fe/utils/custom/globs.dart';
import 'package:fooddelivery_fe/widgets/category_cell.dart';
import 'package:fooddelivery_fe/widgets/most_popular_cell.dart';
import 'package:fooddelivery_fe/widgets/popular_resutaurant_row.dart';
import 'package:fooddelivery_fe/widgets/recent_item_row.dart';
import 'package:fooddelivery_fe/widgets/round_textfield.dart';
import 'package:fooddelivery_fe/widgets/view_all_title_row.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController txtSearch = TextEditingController();

  List catArr = [
    {"image": "assets/img/categories/rice-bowl-54.png", "name": "Rice"},
    {"image": "assets/img/categories/salami-pizza-54.png", "name": "Pizza"},
    {"image": "assets/img/categories/noodles-54.png", "name": "Noodles"},
    {"image": "assets/img/categories/hot-dog-54.png", "name": "Hot Dog"},
    {"image": "assets/img/categories/cola-54.png", "name": "Drinks"},
    {"image": "assets/img/categories/steak-54.png", "name": "Meat"},
    {"image": "assets/img/categories/crab-54.png", "name": "Seafood"},
    {
      "image": "assets/img/categories/cherry-cheesecake-54.png",
      "name": "Desserts"
    },
    {"image": "assets/img/categories/orange-juice-54.png", "name": "Juice"},
    {"image": "assets/img/categories/bubble-tea-54.png", "name": "Bubble Tea"},
    {"image": "assets/img/categories/hemp-milk-54.png", "name": "Milk Tea"},
    {"image": "assets/img/categories/sandwich-54.png", "name": "Sandwich"},
    {"image": "assets/img/categories/other-54.png", "name": "Other"},
  ];

  List popArr = [
    {
      "image": "assets/img/res_1.png",
      "name": "Minute by tuk tuk",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    // {
    //   "image": "assets/img/res_2.png",
    //   "name": "Café de Noir",
    //   "rate": "4.9",
    //   "rating": "124",
    //   "type": "Cafa",
    //   "food_type": "Western Food"
    // },
    // {
    //   "image": "assets/img/res_3.png",
    //   "name": "Bakes by Tella",
    //   "rate": "4.9",
    //   "rating": "124",
    //   "type": "Cafa",
    //   "food_type": "Western Food"
    // },
  ];

  List mostPopArr = [
    {
      "image": "assets/img/m_res_1.png",
      "name": "Minute by tuk tuk",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/img/m_res_2.png",
      "name": "Café de Noir",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/img/m_res_2.png",
      "name": "Café de Noir",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafa",
      "food_type": "Western Food"
    },
  ];

  List recentArr = [
    {
      "image": "assets/img/item_1.png",
      "name": "Mulberry Pizza by Josh",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/img/item_2.png",
      "name": "Barita",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/img/item_3.png",
      "name": "Pizza Rush Hour",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafa",
      "food_type": "Western Food"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 46,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Good morning ",
                          style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyOrderView()),
                            );
                          },
                          icon: Image.asset(
                            "assets/img/shopping_cart.png",
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Dat Huynh Phuoc !",
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "huynhphuocdat2@gmail.com",
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivering to",
                      style:
                          TextStyle(color: TColor.secondaryText, fontSize: 11),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AutocompleteMap()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Current Location",
                            style: TextStyle(
                              color: TColor.secondaryText,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Image.asset(
                            "assets/img/dropdown.png",
                            width: 12,
                            height: 12,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RoundTextfield(
                  hintText: "Search Food",
                  controller: txtSearch,
                  left: Container(
                    alignment: Alignment.center,
                    width: 30,
                    child: Image.asset(
                      "assets/img/search.png",
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ViewAllTitleRow(
                  title: "",
                  onView: () {},
                ),
              ),
              SizedBox(
                height: 210,
                child: Wrap(
                  spacing: 10, // Khoảng cách ngang giữa các item
                  runSpacing: 30, // Khoảng cách dọc giữa các hàng
                  children: List.generate(catArr.length, (index) {
                    return Flexible(
                      child: CategoryCell(cObj: catArr[index], onTap: () {}),
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ViewAllTitleRow(
                  title: "Most Popular",
                  onView: () {},
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: mostPopArr.length,
                  itemBuilder: ((context, index) {
                    var mObj = mostPopArr[index] as Map? ?? {};
                    return MostPopularCell(
                      mObj: mObj,
                      onTap: () {},
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ViewAllTitleRow(
                  title: "Popular Restaurants",
                  onView: () {},
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: popArr.length,
                itemBuilder: ((context, index) {
                  var pObj = popArr[index] as Map? ?? {};
                  return PopularRestaurantRow(
                    pObj: pObj,
                    onTap: () {},
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ViewAllTitleRow(
                  title: "Recent Items",
                  onView: () {},
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: recentArr.length,
                itemBuilder: ((context, index) {
                  var rObj = recentArr[index] as Map? ?? {};
                  return RecentItemRow(
                    rObj: rObj,
                    onTap: () {},
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
