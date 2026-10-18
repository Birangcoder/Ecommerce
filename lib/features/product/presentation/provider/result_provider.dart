import 'package:ecommerce/features/product/data/model/products_model.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../core/utils/search_parameter.dart';
import '../../data/repositiory/result_repository.dart';

final repositoryProvider = Provider<ResultRepository>((ref) {
  return ResultRepository();
});

class ResultNotifier extends AsyncNotifier<List<ProductModel>> {
  ResultNotifier(this.search);

  final Search search;

  @override
  Future<List<ProductModel>> build() async {
    final repo = ref.read(repositoryProvider);
    return repo.getProducts(search.search, search.type);
  }
}

final resultProvider =
    AsyncNotifierProvider.family<ResultNotifier, List<ProductModel>, Search>(
      ResultNotifier.new,
    );
