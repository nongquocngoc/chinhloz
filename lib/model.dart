// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.id,
    this.msvs,
    this.ten,
    this.lop,
    this.nganh,
    this.email,
    this.chuongtrinh,
    this.sdt,
  });

  int id;
  String msvs;
  String ten;
  String lop;
  String nganh;
  String email;
  String chuongtrinh;
  String sdt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["Id"],
    msvs: json["p0"],
    ten: json["p1"],
    lop: json["p2"],
    nganh: json["p3"],
    email: json["p4"],
    chuongtrinh: json["p5"],
    sdt: json["p6"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "p0": msvs,
    "p1": ten,
    "p2": lop,
    "p3": nganh,
    "p4": email,
    "p5": chuongtrinh,
    "p6": sdt,
  };
}
