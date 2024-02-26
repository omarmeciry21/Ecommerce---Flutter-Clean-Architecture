import 'package:ecommerce/core/models/product_model.dart';
import 'package:ecommerce/features/home/data/repo/home_repo.dart';
import 'package:ecommerce/core/components/custom_product_card.dart';
import 'package:ecommerce/features/favorite_products/presentation/manager/favorite_products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class FavoriteProductsScreen extends StatefulWidget {
  const FavoriteProductsScreen({super.key});

  @override
  State<FavoriteProductsScreen> createState() => _FavoriteProductsScreenState();
}

class _FavoriteProductsScreenState extends State<FavoriteProductsScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final favoriteProducts =
        Provider.of<FavoriteProductsProvider>(context).favoriteProducts;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, size: 32),
                ),
                const Text(
                  'Favorite Products',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: favoriteProducts?.isEmpty ?? true
                  ? const Center(
                      child: Text('No favorite products yet'),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 16.0, left: 16.0),
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
                          itemCount: favoriteProducts!.length,
                          itemBuilder: (context, index) {
                            return CustomProductCard(
                              product: favoriteProducts![index],
                              isFavorite: Provider.of<FavoriteProductsProvider>(
                                      context)
                                  .isFavoriteProduct(favoriteProducts![index]),
                              onFavoriteButtonTapped: () {
                                if (Provider.of<FavoriteProductsProvider>(
                                        context,
                                        listen: false)
                                    .isFavoriteProduct(
                                        favoriteProducts[index])) {
                                  Provider.of<FavoriteProductsProvider>(context,
                                          listen: false)
                                      .removeFavoriteProduct(
                                          favoriteProducts[index]);
                                } else {
                                  Provider.of<FavoriteProductsProvider>(context,
                                          listen: false)
                                      .addFavoriteProduct(
                                          favoriteProducts[index]);
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
