class WishlistItem {
  final int? id;
  final int productId;
  final String title;
  final double price;
  final double? rating;
  final String? thumbnail;

  WishlistItem({
    this.id,
    required this.productId,
    required this.title,
    required this.price,
    this.rating,
    this.thumbnail,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'productId': productId,
        'title': title,
        'price': price,
        'rating': rating,
        'thumbnail': thumbnail,
      };

  factory WishlistItem.fromMap(Map<String, dynamic> m) => WishlistItem(
        id: m['id'] as int?,
        productId: m['productId'] as int,
        title: m['title'] as String,
        price: (m['price'] as num).toDouble(),
        rating: (m['rating'] as num?)?.toDouble(),
        thumbnail: m['thumbnail'] as String?,
      );
}