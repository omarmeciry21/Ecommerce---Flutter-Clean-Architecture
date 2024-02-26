import 'package:ecommerce/core/models/product_model.dart';
import 'package:ecommerce/features/favorite_products/presentation/screens/favorite_products_screen.dart';
import 'package:ecommerce/features/home/data/repo/home_repo.dart';
import 'package:ecommerce/core/components/custom_product_card.dart';
import 'package:ecommerce/features/favorite_products/presentation/manager/favorite_products_provider.dart';
import 'package:ecommerce/features/home/presentation/manager/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchProducts(context);
      Provider.of<FavoriteProductsProvider>(context, listen: false)
          .fetchFavoriteProducts();
    });
  }

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).products;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Discover',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const FavoriteProductsScreen();
                      }));
                    },
                    icon: const Icon(Icons.favorite_outline_rounded, size: 32),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              products != null
                  ? Expanded(
                      child: SingleChildScrollView(
                        child: GridView.builder(
                          shrinkWrap: true,
                          controller: scrollController,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  childAspectRatio:
                                      (MediaQuery.of(context).size.width *
                                              0.4) /
                                          205),
                          itemCount: products!.length,
                          itemBuilder: (context, index) {
                            return CustomProductCard(
                              product: products![index],
                              isFavorite:
                                  Provider.of<FavoriteProductsProvider>(context)
                                      .isFavoriteProduct(products![index]),
                              onFavoriteButtonTapped: () {
                                if (Provider.of<FavoriteProductsProvider>(
                                        context,
                                        listen: false)
                                    .isFavoriteProduct(products[index])) {
                                  Provider.of<FavoriteProductsProvider>(context,
                                          listen: false)
                                      .removeFavoriteProduct(products[index]);
                                } else {
                                  Provider.of<FavoriteProductsProvider>(context,
                                          listen: false)
                                      .addFavoriteProduct(products[index]);
                                }
                              },
                            );
                          },
                        ),
                      ),
                    )
                  : Provider.of<ProductsProvider>(context).isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : const Center(child: Text('No Products Found!')),
            ],
          ),
        ),
      ),
    );
  }
}
