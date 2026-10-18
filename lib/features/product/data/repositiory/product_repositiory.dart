import 'dart:convert';

import 'package:ecommerce/features/product/data/model/products_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/api_config.dart';

class ProductRepository {
  Future<List<ProductModel>> getProducts() async {
    final response = await http.get(Uri.parse("${Api.products}?limit=20"));

    if (response.statusCode != 200) {
      throw Exception('failed to load products');
    }

    final json = jsonDecode(response.body);
    final list = json['products'] as List;
    return list.map((e) => ProductModel.fromJson(e)).toList();
  }

  Future<ProductModel> getProductById(int id) async {
    final response = await http.get(Uri.parse(Api.product(id)));

    if (response.statusCode != 200) {
      throw Exception('Failed to load product details');
    }

    final json = jsonDecode(response.body);

    return ProductModel.fromJson(json);
  }
}
