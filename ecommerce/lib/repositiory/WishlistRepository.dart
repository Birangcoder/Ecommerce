import '../config/AppDatabase.dart';
import '../models/WishlistItem.dart';

class WishlistRepository {
  final AppDatabase dbProvider;
  WishlistRepository(this.dbProvider);

  Future<List<WishlistItem>> getAll() async {
    final db = await dbProvider.database;
    final maps = await db.query('wishlist', orderBy: 'id DESC');
    return maps.map(WishlistItem.fromMap).toList();
  }

  Future<int> insert(WishlistItem item) async {
    final db = await dbProvider.database;
    return db.insert('wishlist', item.toMap());
  }

  Future<int> deleteByProductId(int productId) async {
    final db = await dbProvider.database;
    return db.delete('wishlist', where: 'productId = ?', whereArgs: [productId]);
  }

  Future<bool> isInWishlist(int productId) async {
    final db = await dbProvider.database;
    final maps = await db.query('wishlist',
        where: 'productId = ?', whereArgs: [productId], limit: 1);
    return maps.isNotEmpty;
  }
}