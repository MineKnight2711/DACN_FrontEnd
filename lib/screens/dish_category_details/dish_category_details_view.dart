// import 'package:flutter/material.dart';

// class DishCategoryDetailsScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> dishCategoryArr = [
//     {
//       "image": "assets/img/m_res_1.png",
//       "name": "Minute by tuk tuk",
//       "rate": "4.9",
//       "rating": "124",
//       "type": "Cafa",
//       "food_type": "Western Food"
//     },
//     {
//       "image": "assets/img/m_res_2.png",
//       "name": "Café de Noir",
//       "rate": "4.9",
//       "rating": "124",
//       "type": "Cafa",
//       "food_type": "Western Food"
//     },
//     {
//       "image": "assets/img/m_res_2.png",
//       "name": "Café de Noir",
//       "rate": "4.9",
//       "rating": "124",
//       "type": "Cafa",
//       "food_type": "Western Food"
//     },
//     {
//       "image": "assets/img/m_res_1.png",
//       "name": "Minute by tuk tuk",
//       "rate": "4.9",
//       "rating": "124",
//       "type": "Cafa",
//       "food_type": "Western Food"
//     },
//     {
//       "image": "assets/img/m_res_2.png",
//       "name": "Café de Noir",
//       "rate": "4.9",
//       "rating": "124",
//       "type": "Cafa",
//       "food_type": "Western Food"
//     },
//     {
//       "image": "assets/img/m_res_2.png",
//       "name": "Café de Noir",
//       "rate": "4.9",
//       "rating": "124",
//       "type": "Cafa",
//       "food_type": "Western Food"
//     },
//     {
//       "image": "assets/img/m_res_1.png",
//       "name": "Minute by tuk tuk",
//       "rate": "4.9",
//       "rating": "124",
//       "type": "Cafa",
//       "food_type": "Western Food"
//     },
//     {
//       "image": "assets/img/m_res_2.png",
//       "name": "Café de Noir",
//       "rate": "4.9",
//       "rating": "124",
//       "type": "Cafa",
//       "food_type": "Western Food"
//     },
//     {
//       "image": "assets/img/m_res_2.png",
//       "name": "Café de Noir",
//       "rate": "4.9",
//       "rating": "124",
//       "type": "Cafa",
//       "food_type": "Western Food"
//     },
//     {
//       "image": "assets/img/m_res_1.png",
//       "name": "Minute by tuk tuk",
//       "rate": "4.9",
//       "rating": "124",
//       "type": "Cafa",
//       "food_type": "Western Food"
//     },
//     {
//       "image": "assets/img/m_res_2.png",
//       "name": "Café de Noir",
//       "rate": "4.9",
//       "rating": "124",
//       "type": "Cafa",
//       "food_type": "Western Food"
//     },
//     {
//       "image": "assets/img/m_res_2.png",
//       "name": "Café de Noir",
//       "rate": "4.9",
//       "rating": "124",
//       "type": "Cafa",
//       "food_type": "Western Food"
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text(
//           'Dish Category Details',
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//         iconTheme: IconThemeData(
//           color: Colors.black,
//         ),
//       ),
//       body: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3, // Hiển thị 3 sản phẩm trên mỗi hàng
//           childAspectRatio: 3 / 4, // Tỷ lệ chiều rộng và chiều cao của mỗi mục
//         ),
//         itemCount: dishCategoryArr.length,
//         itemBuilder: (BuildContext context, int index) {
//           final dish = dishCategoryArr[index];
//           return Card(
//             elevation: 2.0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10.0),
//                   child: Image.asset(
//                     dish["image"],
//                     width: double.infinity,
//                     height: 150,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         dish["name"],
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 4.0),
//                       Text(
//                         dish["type"],
//                         style: TextStyle(
//                           fontSize: 14.0,
//                         ),
//                       ),
//                       SizedBox(height: 4.0),
//                       Text(
//                         dish["food_type"],
//                         style: TextStyle(
//                           fontSize: 14.0,
//                         ),
//                       ),
//                       SizedBox(height: 4.0),
//                       Row(
//                         children: [
//                           Image.asset(
//                             'assets/img/rate.png',
//                             width: 16.0,
//                             height: 16.0,
//                           ),
//                           SizedBox(width: 4.0),
//                           Text(dish["rate"]),
//                           SizedBox(width: 4.0),
//                           Text(dish["rating"]),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class DishCategoryDetailsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> dishes = [
    {
      "image": "assets/img/m_res_1.png",
      "name": "Bún",
      "description": "Món ngon từ miền Bắc",
      "rating": "4.5",
      "distance": "2 km"
    },
    {
      "image": "assets/img/m_res_1.png",
      "name": "Phở",
      "description": "Món ăn truyền thống",
      "rating": "4.8",
      "distance": "3 km"
    },
    {
      "image": "assets/img/m_res_1.png",
      "name": "Cháo",
      "description": "Món nhẹ dễ tiêu hóa",
      "rating": "4.2",
      "distance": "1 km"
    },
    {
      "image": "assets/img/m_res_1.png",
      "name": "Bún",
      "description": "Món ngon từ miền Bắc",
      "rating": "4.5",
      "distance": "2 km"
    },
    {
      "image": "assets/img/m_res_1.png",
      "name": "Phở",
      "description": "Món ăn truyền thống",
      "rating": "4.8",
      "distance": "3 km"
    },
    {
      "image": "assets/img/m_res_1.png",
      "name": "Cháo",
      "description": "Món nhẹ dễ tiêu hóa",
      "rating": "4.2",
      "distance": "1 km"
    },
    // Add more dishes here
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dish Category Details'),
      ),
      body: ListView.builder(
        itemCount: dishes.length,
        itemBuilder: (context, index) {
          final dish = dishes[index];
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  dish['image'],
                  width: 80,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              title: Row(
                children: [
                  Icon(
                    Icons.check,
                    size: 16,
                    color: Colors.green,
                  ),
                  SizedBox(width: 4),
                  Text(
                    dish['name'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text(
                    dish['description'],
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.yellow),
                      SizedBox(width: 4),
                      Text(dish['rating']),
                      SizedBox(width: 8),
                      Icon(Icons.location_on, size: 16),
                      SizedBox(width: 4),
                      Text(dish['distance']),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
