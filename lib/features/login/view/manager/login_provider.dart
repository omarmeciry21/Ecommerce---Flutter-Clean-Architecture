import 'package:ecommerce/features/home/presentation/screens/home_screen.dart';
import 'package:ecommerce/features/login/data/models/login_request_model.dart';
import 'package:ecommerce/features/login/data/repo/login_repo.dart';
import 'package:ecommerce/features/login/view/screens/login_screen.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void loginUser(BuildContext context,
      {required String username, required String password}) async {
    try {
      isLoading = true;
      final response = await LoginRepo.login(
          LoginRequestModel(username: username, password: password));
      isLoading = false;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
