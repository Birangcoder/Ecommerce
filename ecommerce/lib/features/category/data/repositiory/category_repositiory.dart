import 'dart:convert';
import 'package:ecommerce/features/category/data/model/category_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/apiConfig.dart';

class CategoryRepository {
  Future<List<CategoryModel>> getCategories() async {
    // First API
    final response = await http.get(Uri.parse(Api.categories));

    if (response.statusCode != 200) {
      throw Exception("Failed to load categories");
    }

    final List<dynamic> categories = jsonDecode(response.body);

    List<CategoryModel> result = [];

    for (final category in categories) {
      final String slug = category["slug"];
      final String name = category["name"];

      // Second API
      final productResponse = await http.get(
        Uri.parse("${Api.category(slug)}?limit=1"),
      );

      if (productResponse.statusCode != 200) {
        continue;
      }

      final Map<String, dynamic> productJson = jsonDecode(productResponse.body);

      final List products = productJson["products"];

      String thumbnail = "";

      if (products.isNotEmpty) {
        thumbnail = products.first["thumbnail"];
      }

      result.add(CategoryModel(name: name, slug: slug, image: thumbnail));
    }

    return result;
  }
}
