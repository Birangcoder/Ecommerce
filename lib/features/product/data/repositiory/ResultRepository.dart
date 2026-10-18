import 'dart:convert';

import 'package:ecommerce/core/constants/apiConfig.dart';
import 'package:ecommerce/features/product/data/model/products_model.dart';
import 'package:http/http.dart' as http;

class ResultRepository{
  Future<List<ProductModel>> getProducts(String search, String type) async{
    String url;
    switch (type) {
      case "search":
        url = Api.search(search);
        break;

      case "category":
        url = Api.category(search);
        break;

      default:
        throw Exception("Unknown search type: $type");
    }

    final response = await http.get(Uri.parse(url));


    if (response.statusCode != 200){
      throw Exception("Failed to load Result data");
    }

    final json = jsonDecode(response.body);
    final list = json['products'] as List;
    return list.map((e) => ProductModel.fromJson(e)).toList();
  }
}