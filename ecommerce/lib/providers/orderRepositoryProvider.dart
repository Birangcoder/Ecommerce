import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/AppDatabase.dart';
import '../models/OrderItem.dart';
import '../repositiory/OrderRepository.dart';

final appDatabaseProvider = Provider<AppDatabase>(
  (ref) => AppDatabase.instance,
);

final orderRepositoryProvider = Provider<OrderRepository>(
  (ref) => OrderRepository(ref.watch(appDatabaseProvider)),
);

class OrderNotifier extends AsyncNotifier<List<OrderItem>> {
  @override
  Future<List<OrderItem>> build() =>
      ref.watch(orderRepositoryProvider).getAll();

  Future<void> placeOrder(List<OrderItem> orders) async {
    final repo = ref.read(orderRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await repo.insertMany(orders);
      return repo.getAll();
    });
  }

  Future<void> removeOrder(int id) async {
    final repo = ref.read(orderRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await repo.deleteById(id);
      return repo.getAll();
    });
  }
}

final orderNotifierProvider =
    AsyncNotifierProvider<OrderNotifier, List<OrderItem>>(OrderNotifier.new);
