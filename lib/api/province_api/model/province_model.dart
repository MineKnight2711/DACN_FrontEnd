class Province {
  int code;
  String name;
  List<District> districts;
  Province({required this.code, required this.name, required this.districts});
  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      code: json['code'] as int,
      name: json['name'] as String,
      districts:
          (json['districts'] as List).map((d) => District.fromJson(d)).toList(),
    );
  }
}

class District {
  int code;
  String name;
  List<Ward> wards;
  District({
    required this.code,
    required this.name,
    required this.wards,
  });
  factory District.fromJson(Map<String, dynamic> json) {
    return District(
        code: json['code'] as int,
        name: json['name'] as String,
        wards: (json['wards'] as List).map((w) => Ward.fromJson(w)).toList());
  }
}

class Ward {
  int code;
  String name;

  Ward({
    required this.code,
    required this.name,
  });

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      code: json['code'] as int,
      name: json['name'] as String,
    );
  }
}

class SearchedProvinceDistrictWard {
  int code;
  String name;

  SearchedProvinceDistrictWard({
    required this.code,
    required this.name,
  });

  factory SearchedProvinceDistrictWard.fromJson(Map<String, dynamic> json) {
    return SearchedProvinceDistrictWard(
      code: json['code'] as int,
      name: json['name'] as String,
    );
  }
}
