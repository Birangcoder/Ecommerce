import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/app_database.dart';
import '../../data/model/cart_item.dart';
import '../../data/repositiory/cart_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>(
  (ref) => AppDatabase.instance,
);

final cartRepositoryProvider = Provider<CartRepository>(
  (ref) => CartRepository(ref.watch(appDatabaseProvider)),
);

class CartNotifier extends AsyncNotifier<List<CartItem>> {
  @override
  Future<List<CartItem>> build() => ref.watch(cartRepositoryProvider).getAll();

  Future<void> addToCart(CartItem item) async {
    final repo = ref.read(cartRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final existing = await repo.findByProductId(item.productId);
      if (existing != null) {
        final newQty = existing.quantity + item.quantity;
        await repo.updateQuantity(existing.id!, newQty, item.price * newQty);
      } else {
        await repo.insert(item);
      }
      return repo.getAll();
    });
  }

  Future<void> removeFromCart(int id) async {
    final repo = ref.read(cartRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await repo.deleteById(id);
      return repo.getAll();
    });
  }

  Future<void> clearCart() async {
    final repo = ref.read(cartRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await repo.clearCart();
      return repo.getAll();
    });
  }

  Future<void> updateQuantity(CartItem item, int newQuantity) async {
    final repo = ref.read(cartRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      if (newQuantity <= 0) {
        await repo.deleteById(item.id!);
      } else {
        final newTotal = item.price * newQuantity;
        await repo.updateQuantity(item.id!, newQuantity, newTotal);
      }
      return repo.getAll();
    });
  }
}

final cartNotifierProvider =
    AsyncNotifierProvider<CartNotifier, List<CartItem>>(CartNotifier.new);
