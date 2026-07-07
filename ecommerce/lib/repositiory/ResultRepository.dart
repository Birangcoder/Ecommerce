import 'dart:convert';

import 'package:ecommerce/config/apiConfig.dart';
import 'package:ecommerce/models/products_model.dart';
import 'package:http/http.dart' as http;

class ResultRepository{
  Future<List<ProductModel>> getProducts(String search, String type) async{
    String url;
print("search: $search - type: $type");
    switch (type) {
      case "search":
        url = "${Api.search}$search";
        break;

      case "category":
        url = "${Api.productCategory}$search";
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
print(response.body);
    return list.map((e) => ProductModel.fromJson(e)).toList();
  }
}