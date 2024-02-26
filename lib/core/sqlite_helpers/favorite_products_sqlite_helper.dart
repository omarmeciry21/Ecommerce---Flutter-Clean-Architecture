import 'dart:io';

import 'package:ecommerce/core/models/product_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tablefavoriteProduct = 'favoriteProduct';
final String columnid = 'id';
final String columntitle = 'title';
final String columndescription = 'description';
final String columnprice = 'price';
final String columnimage = 'image';
final String columncategory = 'category';
final String columnrating = 'rating';
final String columncount = 'count';

class FavoriteProductsSQLiteHelper {
  Database? db;
  FavoriteProductsSQLiteHelper._();
  static final FavoriteProductsSQLiteHelper instance =
      FavoriteProductsSQLiteHelper._();

  Future open() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'favoriteProduct.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tablefavoriteProduct ( 
  uid integer primary key autoincrement,
  $columnid integer not null, 
  $columntitle text not null,
  $columndescription text not null,
  $columnprice real not null,
  $columnimage text not null,
  $columncategory text not null,
  $columnrating real not null,
  $columncount integer not null
  )
''');
    });
  }

  Future<ProductModel> insert(ProductModel favoriteProduct) async {
    await db!.insert(tablefavoriteProduct, favoriteProduct.toSQLiteMap());
    return favoriteProduct;
  }

  Future<List<ProductModel>> getFavoriteProducts() async {
    List<Map> maps = await db!.query(
      tablefavoriteProduct,
    );
    if (maps.length > 0) {
      return maps
          .map((e) => ProductModel.fromSQLiteMap(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<ProductModel?> getfavoriteProduct(int productId) async {
    List<Map> maps = await db!.query(tablefavoriteProduct,
        columns: [
          columnid,
          columntitle,
          columndescription,
          columnprice,
          columnimage,
          columncategory,
          columnrating,
          columncount,
        ],
        where: '$columnid = ?',
        whereArgs: [productId]);
    if (maps.length > 0) {
      return ProductModel.fromSQLiteMap(maps.first as Map<String, dynamic>);
    }
    return null;
  }

  Future<int> delete(int productId) async {
    return await db!.delete(tablefavoriteProduct,
        where: '$columnid = ?', whereArgs: [productId]);
  }

  Future<int> update(ProductModel favoriteProduct) async {
    return await db!.update(tablefavoriteProduct, favoriteProduct.toJson(),
        where: '$columnid = ?', whereArgs: [favoriteProduct.id]);
  }

  Future close() async => db!.close();
}
