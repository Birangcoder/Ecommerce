class CartModel {
  final int cartId;
  final int userId;
  final int productId;
  final String productImage;
  final String productName;
  final String unit;
  int quantity;
  final double price;
  final double oldPrice;

  CartModel({
    required this.cartId,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.productImage,
    required this.productName,
    required this.unit,
    required this.price,
    required this.oldPrice,
  });

  factory CartModel.fromJson(Map<String, dynamic> map) {
    return CartModel(
      cartId: int.tryParse(map['cartId'].toString()) ?? 0,
      userId: int.tryParse(map['userId'].toString()) ?? 0,
      productId: int.tryParse(map['productId'].toString()) ?? 0,
      quantity: int.tryParse(map['quantity'].toString()) ?? 0,
      productImage: map['productImage'] ?? "",
      productName: map['productName'] ?? "",
      unit: map['unit'] ?? "",
      price: double.tryParse(map['price'].toString()) ?? 0,
      oldPrice: double.tryParse(map['oldPrice'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
    };
  }
}