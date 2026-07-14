import '../config/AppDatabase.dart';
import '../models/CartItem.dart';

class CartRepository {
  final AppDatabase dbProvider;
  CartRepository(this.dbProvider);

  Future<List<CartItem>> getAll() async {
    final db = await dbProvider.database;
    final maps = await db.query('cart');
    return maps.map(CartItem.fromMap).toList();
  }

  Future<int> insert(CartItem item) async {
    final db = await dbProvider.database;
    return db.insert('cart', item.toMap());
  }

  Future<int> updateQuantity(int id, int quantity, double total) async {
    final db = await dbProvider.database;
    return db.update('cart', {'quantity': quantity, 'total': total},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteById(int id) async {
    final db = await dbProvider.database;
    return db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> clearCart() async {
    final db = await dbProvider.database;
    return db.delete('cart');
  }

  // cart-specific: check if product already exists to bump quantity instead of duplicate row
  Future<CartItem?> findByProductId(int productId) async {
    final db = await dbProvider.database;
    final maps = await db.query('cart',
        where: 'productId = ?', whereArgs: [productId], limit: 1);
    return maps.isNotEmpty ? CartItem.fromMap(maps.first) : null;
  }
}