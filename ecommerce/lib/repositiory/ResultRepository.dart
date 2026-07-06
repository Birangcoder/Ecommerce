import 'dart:convert';

import 'package:ecommerce/config/apiConfig.dart';
import 'package:ecommerce/models/products_model.dart';
import 'package:http/http.dart' as http;

class ResultRepository{
  Future<List<ProductModel>> getProducts(String cate) async{
    final response = await http.get(Uri.parse("${Api.productCategory}$cate"));

    if (response.statusCode != 200){
      throw Exception("Failed to load Result data");
    }

    final json = jsonDecode(response.body);
    final list = json['products'] as List;

    return list.map((e) => ProductModel.fromJson(e)).toList();
  }
}