import 'package:ecommerce/features/product/data/model/review_model.dart';

class ProductModel {
  final int id;
  final String name;
  final String image;
  final double price;
  final double rating;
  final String? description;
  final String? brand;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? returnPolicy;
  final List<ReviewModel>? reviews;

  const ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    this.description,
    this.brand,
    this.warrantyInformation,
    this.shippingInformation,
    this.returnPolicy,
    this.reviews,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['title'],
      image: json['thumbnail'],
      price: json['price'],
      rating: json['rating'],
      description: json['description'],
      brand: json['brand'],
      warrantyInformation: json['warrantyInformation'],
      shippingInformation: json['shippingInformation'],
      returnPolicy: json['returnPolicy'],
      reviews:
          (json['reviews'] as List<dynamic>?)
              ?.map((e) => ReviewModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
