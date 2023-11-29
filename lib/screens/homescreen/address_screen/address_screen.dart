import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/widgets/custom_appbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "Địa chỉ của bạn",
          onPressed: () {
            Navigator.pop(context);
          }),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 40.h,
              width: 300.w,
              child: ProvinceCombobox(),
            ),
          ),
          Text("123")
        ],
      ),
    );
  }
}

class ProvinceCombobox extends StatefulWidget {
  const ProvinceCombobox({super.key});
  @override
  State<ProvinceCombobox> createState() => _ProvinceComboboxState();
}

class _ProvinceComboboxState extends State<ProvinceCombobox> {
  String _selectedProvince = "";
  List<dynamic> provinces = [];

  @override
  void initState() {
    super.initState();
    _loadProvinces();
  }

  _loadProvinces() async {
    var url = 'https://provinces.open-api.vn/api/p/';
    var response = await http.get(Uri.parse(url));

    setState(() {
      provinces = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
    });
    _selectedProvince = provinces.isNotEmpty ? provinces[0]['name'] : "";
    Logger().i("Loggggg selected province :$_selectedProvince");
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedProvince != "" && _selectedProvince.isNotEmpty) {
      return DropdownButton(
        menuMaxHeight: 200.h,

        // padding: EdgeInsets.only(top: 50),
        isExpanded: true,
        hint: Text('Chọn tỉnh'),
        onChanged: (value) {
          setState(() {
            _selectedProvince = value.toString();
          });
        },
        items: provinces.map((province) {
          return DropdownMenuItem(
            value: province['name'],
            child: Text(province['name']),
          );
        }).toList(),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
