import 'dart:convert';

import 'package:ecommerce/core/api_services.dart';
import 'package:ecommerce/features/login/data/models/login_request_model.dart';
import 'package:ecommerce/features/login/data/models/login_response_model.dart';
import 'package:http/http.dart' as http;

class LoginRepo {
  static Future<LoginResponseModel> login(
      LoginRequestModel loginRequestModel) async {
    const String endpoint = '${APIServices.baseUrl}/auth/login';
    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    final String body = jsonEncode(loginRequestModel.toJson());
    try {
      print(loginRequestModel.toJson());
      final http.Response response =
          await http.post(Uri.parse(endpoint), headers: headers, body: body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return LoginResponseModel.fromJson(jsonDecode(response.body));
      } else {
        print("---Login Failed---");
        print(response.statusCode);
        print(response.body);
        throw Exception('Failed to login! Please try again.');
      }
    } catch (e) {
      throw Exception('Failed to login! Please try again.');
    }
  }
}
