class OrderItem {
  final int? id;
  final int productId;
  final String title;
  final String? thumbnail;
  final double price;
  final int quantity;
  final String paymentMethod;
  final DateTime orderedAt;

  OrderItem({
    this.id,
    required this.productId,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.quantity,
    required this.paymentMethod,
    required this.orderedAt,
  });

  double get total => price * quantity;

  Map<String, dynamic> toMap() => {
        'id': id,
        'productId': productId,
        'title': title,
        'thumbnail': thumbnail,
        'price': price,
        'quantity': quantity,
        'paymentMethod': paymentMethod,
        'orderedAt': orderedAt.toIso8601String(),
      };

  factory OrderItem.fromMap(Map<String, dynamic> m) => OrderItem(
        id: m['id'] as int?,
        productId: m['productId'] as int,
        title: m['title'] as String,
        thumbnail: m['thumbnail'] as String?,
        price: (m['price'] as num).toDouble(),
        quantity: m['quantity'] as int,
        paymentMethod: m['paymentMethod'] as String,
        orderedAt: DateTime.parse(m['orderedAt'] as String),
      );
}