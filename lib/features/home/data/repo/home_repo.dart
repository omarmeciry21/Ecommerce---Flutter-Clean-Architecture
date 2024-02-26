import 'dart:convert';

import 'package:ecommerce/core/api_services.dart';
import 'package:ecommerce/core/models/product_model.dart';
import 'package:ecommerce/core/sqlite_helpers/favorite_products_sqlite_helper.dart';
import 'package:http/http.dart' as http;

class HomeRepo {
  static Future<List<ProductModel>> getProducts() async {
    try {
      const endpoint = '${APIServices.baseUrl}/products';

      final response = await http.get(Uri.parse(endpoint));

      final decodedResponse = jsonDecode(response.body);

      final tmpProductList = <ProductModel>[];

      for (var element in (decodedResponse as List)) {
        tmpProductList.add(ProductModel.fromJson(element));
      }
      return tmpProductList;
    } catch (e) {
      print('Get Products Exception ' + e.toString());
      throw Exception('Failed to get products! Please try again.');
    }
  }
}
