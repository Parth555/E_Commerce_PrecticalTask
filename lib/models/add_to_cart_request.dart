// To parse this JSON data, do
//
//     final addToCartRequest = addToCartRequestFromJson(jsonString);

import 'dart:convert';

AddToCartRequest addToCartRequestFromJson(String str) => AddToCartRequest.fromJson(json.decode(str));

String addToCartRequestToJson(AddToCartRequest data) => json.encode(data.toJson());

class AddToCartRequest {
  int? userId;
  DateTime? date;
  List<ProductReq>? products;

  AddToCartRequest({
    this.userId,
    this.date,
    this.products,
  });

  factory AddToCartRequest.fromJson(Map<String, dynamic> json) => AddToCartRequest(
    userId: json["userId"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    products: json["products"] == null ? [] : List<ProductReq>.from(json["products"]!.map((x) => ProductReq.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class ProductReq {
  int? productId;
  int? quantity;

  ProductReq({
    this.productId,
    this.quantity,
  });

  factory ProductReq.fromJson(Map<String, dynamic> json) => ProductReq(
    productId: json["productId"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "quantity": quantity,
  };
}

