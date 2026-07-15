import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/AppDatabase.dart';
import '../models/WishlistItem.dart';
import '../repositiory/WishlistRepository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase.instance);

final wishlistRepositoryProvider = Provider<WishlistRepository>(
        (ref) => WishlistRepository(ref.watch(appDatabaseProvider)));

class WishlistNotifier extends AsyncNotifier<List<WishlistItem>> {
  @override
  Future<List<WishlistItem>> build() =>
      ref.watch(wishlistRepositoryProvider).getAll();

  Future<void> toggle(WishlistItem item) async {
    final repo = ref.read(wishlistRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final exists = await repo.isInWishlist(item.productId);
      if (exists) {
        await repo.deleteByProductId(item.productId);
      } else {
        await repo.insert(item);
      }
      return repo.getAll();
    });
  }
}

final wishlistNotifierProvider =
AsyncNotifierProvider<WishlistNotifier, List<WishlistItem>>(WishlistNotifier.new);