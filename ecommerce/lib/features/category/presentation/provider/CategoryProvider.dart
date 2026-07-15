import 'package:riverpod/riverpod.dart';

import '../../data/model/category_model.dart';
import '../../data/repositiory/category_repositiory.dart';

final repositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepository();
});

class CategoryNotifier extends AsyncNotifier<List<CategoryModel>> {
  @override
  Future<List<CategoryModel>> build() async {
    final repo = ref.read(repositoryProvider);
    return repo.getCategories();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    final repo = ref.read(repositoryProvider);
    state = await AsyncValue.guard(() => repo.getCategories());
  }
}

final categoryProvider =
    AsyncNotifierProvider<CategoryNotifier, List<CategoryModel>>(
      CategoryNotifier.new,
    );
