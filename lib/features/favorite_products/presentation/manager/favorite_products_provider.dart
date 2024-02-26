import 'package:ecommerce/core/models/product_model.dart';
import 'package:ecommerce/core/sqlite_helpers/favorite_products_sqlite_helper.dart';
import 'package:flutter/material.dart';

class FavoriteProductsProvider extends ChangeNotifier {
  List<ProductModel>? _favoriteProducts;

  List<ProductModel>? get favoriteProducts => _favoriteProducts;

  void set favoriteProducts(List<ProductModel>? value) {
    _favoriteProducts = value;
    notifyListeners();
  }

  Future<void> fetchFavoriteProducts() async {
    favoriteProducts =
        await FavoriteProductsSQLiteHelper.instance.getFavoriteProducts();
  }

  Future<void> addFavoriteProduct(ProductModel product) async {
    print('addFavoriteProduct');
    await FavoriteProductsSQLiteHelper.instance.insert(product);
    await fetchFavoriteProducts();
  }

  Future<void> removeFavoriteProduct(ProductModel product) async {
    print('deleteFavoriteProduct');

    await FavoriteProductsSQLiteHelper.instance.delete(product.id);
    await fetchFavoriteProducts();
  }

  bool isFavoriteProduct(ProductModel product) {
    final isFavorite =
        favoriteProducts?.any((element) => element.id == product.id) ?? false;
    print(isFavorite);
    return isFavorite;
  }
}
