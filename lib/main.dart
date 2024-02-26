import 'package:ecommerce/core/sqlite_helpers/favorite_products_sqlite_helper.dart';
import 'package:ecommerce/features/favorite_products/presentation/manager/favorite_products_provider.dart';
import 'package:ecommerce/features/home/presentation/manager/products_provider.dart';
import 'package:ecommerce/features/onboarding/view/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/features/login/view/manager/login_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FavoriteProductsSQLiteHelper.instance.open();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProductsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const OnBoardingScreen(),
      ),
    );
  }
}
