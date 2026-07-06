import 'package:ecommerce/models/products_model.dart';
import 'package:ecommerce/repositiory/product_repositiory.dart';
import 'package:riverpod/riverpod.dart';

final productRepositoryProvider = Provider<productRepositiory>((ref) {
  return productRepositiory();
});

class ProductDetailsNotifier extends AsyncNotifier<ProductModel> {
  final int productId;

  ProductDetailsNotifier(this.productId);

  @override
  Future<ProductModel> build() {
    return ref.read(productRepositoryProvider).getProductById(productId);
  }
}

final productDetailProvider =
    AsyncNotifierProvider.family<ProductDetailsNotifier, ProductModel, int>(
      ProductDetailsNotifier.new,
    );
