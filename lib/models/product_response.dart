// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

class ProductResponse {
  ProductResponse(
      {required this.available,
      required this.name,
      this.picture,
      required this.price,
      this.id});

  bool available;
  String name;
  String? picture;
  double price;
  String? id;

  factory ProductResponse.fromRawJson(String str) =>
      ProductResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
      };

  ProductResponse copy() => ProductResponse(
        available: available,
        name: name,
        picture: picture,
        price: price,
        id: id,
      );
}
