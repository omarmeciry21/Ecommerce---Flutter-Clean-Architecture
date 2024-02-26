import 'package:ecommerce/core/models/product_model.dart';
import 'package:ecommerce/features/home/data/repo/home_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ProductsProvider extends ChangeNotifier {
  List<ProductModel>? _products;

  List<ProductModel>? get products => _products;

  void set products(List<ProductModel>? value) {
    _products = value;
    if (kDebugMode) {
      print(value);
    }
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchProducts(BuildContext context) async {
    isLoading = true;
    try {
      products = await HomeRepo.getProducts();
      isLoading = false;
    } catch (e) {
      isLoading = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to fetch products! Please try again.'),
          ),
        );
      });
    }
  }
}
