import '../../../../core/storage/app_database.dart';
import '../model/order_item.dart';

class OrderRepository {
  final AppDatabase dbProvider;
  OrderRepository(this.dbProvider);

  Future<List<OrderItem>> getAll() async {
    final db = await dbProvider.database;
    final maps = await db.query('orders', orderBy: 'orderedAt DESC');
    return maps.map(OrderItem.fromMap).toList();
  }

  Future<int> insert(OrderItem order) async {
    final db = await dbProvider.database;
    return db.insert('orders', order.toMap());
  }

  // insert multiple order rows at once (e.g. checking out several cart items together)
  Future<void> insertMany(List<OrderItem> orders) async {
    final db = await dbProvider.database;
    final batch = db.batch();
    for (final order in orders) {
      batch.insert('orders', order.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<List<OrderItem>> getByPaymentMethod(String method) async {
    final db = await dbProvider.database;
    final maps = await db.query(
      'orders',
      where: 'paymentMethod = ?',
      whereArgs: [method],
      orderBy: 'orderedAt DESC',
    );
    return maps.map(OrderItem.fromMap).toList();
  }

  Future<int> deleteById(int id) async {
    final db = await dbProvider.database;
    return db.delete('orders', where: 'id = ?', whereArgs: [id]);
  }
}
