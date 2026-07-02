import 'dart:convert';

import 'package:ecommerce/models/products_model.dart';
import 'package:http/http.dart' as http;

import '../config/apiConfig.dart';

class productRepositiory {
  Future<List<ProductModel>> getProducts() async {
    final response = await http.get(Uri.parse("${Api.Products}?limit=20"));

    if (response.statusCode != 200) {
      throw Exception('failed to load products');
    }

    final json = jsonDecode(response.body);
    final list = json['products'] as List;

    return list.map((e) => ProductModel.fromJson(e)).toList();
  }
}
