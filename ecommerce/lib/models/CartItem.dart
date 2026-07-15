class CartItem {
  final int? id;
  final int productId;
  final String title;
  final double price;
  final int quantity;
  final double total;
  final String? thumbnail;

  CartItem({
    this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    this.thumbnail,
  });

  Map<String, dynamic> toMap() =>
      {
        'id': id,
        'productId': productId,
        'title': title,
        'price': price,
        'quantity': quantity,
        'total': total,
        'thumbnail': thumbnail,
      };

  factory CartItem.fromMap(Map<String, dynamic> m) =>
      CartItem(
        id: m['id'] as int?,
        productId: m['productId'] as int,
        title: m['title'] as String,
        price: (m['price'] as num).toDouble(),
        quantity: m['quantity'] as int,
        total: (m['total'] as num).toDouble(),
        thumbnail: m['thumbnail'] as String?,
      );

  CartItem copyWith({int? quantity, double? total}) =>
      CartItem(
        id: id,
        productId: productId,
        title: title,
        price: price,
        quantity: quantity ?? this.quantity,
        total: total ?? this.total,
        thumbnail: thumbnail,
      );
}