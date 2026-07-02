import 'package:ecommerce/models/products_model.dart';
import 'package:ecommerce/repositiory/product_repositiory.dart';
import 'package:riverpod/riverpod.dart';

final repositoryProvider = Provider<productRepositiory>((ref) {
  return productRepositiory();
});

class productNotifier extends AsyncNotifier<List<ProductModel>> {
  @override
  Future<List<ProductModel>> build() async {
    final repo = ref.read(repositoryProvider);
    return repo.getProducts();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    final repo = ref.read(repositoryProvider);
    state = await AsyncValue.guard(() => repo.getProducts());
  }
}

final productProvider = AsyncNotifierProvider<productNotifier, List<ProductModel>>(
  productNotifier.new,
);
