// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PostFavData welcomeFromJson(String str) => PostFavData.fromJson(json.decode(str));

String welcomeToJson(PostFavData data) => json.encode(data.toJson());

class PostFavData {
  PostFavData({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory PostFavData.fromJson(Map<String, dynamic> json) => PostFavData(
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
    required this.id,
    required this.product,
  });

  int id;
  Product product;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": product.toJson(),
  };
}

class Product {
  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
  });

  int id;
  int price;
  int oldPrice;
  int discount;
  String image;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    price: json["price"],
    oldPrice: json["old_price"],
    discount: json["discount"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "old_price": oldPrice,
    "discount": discount,
    "image": image,
  };
}
