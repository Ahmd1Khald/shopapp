// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

CategoriesModelData welcomeFromJson(String str) => CategoriesModelData.fromJson(json.decode(str));

String welcomeToJson(CategoriesModelData data) => json.encode(data.toJson());

class CategoriesModelData {
  CategoriesModelData({
    required this.status,
    this.message,
    required this.data,
  });

  bool status;
  dynamic message;
  Data data;

  factory CategoriesModelData.fromJson(Map<String, dynamic> json) => CategoriesModelData(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  int currentPage;
  List<CategoriesDatum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: List<CategoriesDatum>.from(json["data"].map((x) => CategoriesDatum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class CategoriesDatum {
  CategoriesDatum({
    required this.id,
    required this.name,
    required this.image,
  });

  int id;
  String name;
  String image;

  factory CategoriesDatum.fromJson(Map<String, dynamic> json) => CategoriesDatum(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
