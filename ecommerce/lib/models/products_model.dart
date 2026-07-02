class ProductModel {
  final int id;
  final String name;
  final String image;
  final double price;
  final double rating;

  const ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['title'],
      image: json['thumbnail'],
      price: json['price'],
      rating: json['rating'],
    );
  }
}
