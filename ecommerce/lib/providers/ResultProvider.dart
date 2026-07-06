import 'package:ecommerce/models/products_model.dart';
import 'package:riverpod/riverpod.dart';

import '../repositiory/ResultRepository.dart';

final repositoryProvider = Provider<ResultRepository>((ref) {
  return ResultRepository();
});

class ResultNotifier extends AsyncNotifier<List<ProductModel>> {
  ResultNotifier(this.category);

  final String category;

  @override
  Future<List<ProductModel>> build() async {
    final repo = ref.read(repositoryProvider);
    return repo.getProducts(category);
  }
}

final resultProvider =
    AsyncNotifierProvider.family<ResultNotifier, List<ProductModel>, String>(
      ResultNotifier.new,
    );
