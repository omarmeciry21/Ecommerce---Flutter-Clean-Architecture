import 'dart:convert';

import 'package:ecommerce/core/api_services.dart';
import 'package:ecommerce/features/home/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class HomeRepo {
  static Future<List<ProductModel>> getProducts() async {
    try {
      const endpoint = '${APIServices.baseUrl}/products';

      final response = await http.get(Uri.parse(endpoint));

      final decodedResponse = jsonDecode(response.body);

      final tmpProductList = <ProductModel>[];

      (decodedResponse as List).forEach((element) {
        tmpProductList.add(ProductModel.fromJson(element));
      });
      return tmpProductList;
    } catch (e) {
      print('Get Products Exception ' + e.toString());
      throw Exception('Failed to get products! Please try again.');
    }
  }
}
