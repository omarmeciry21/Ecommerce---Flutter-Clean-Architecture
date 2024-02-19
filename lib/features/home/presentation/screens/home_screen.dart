import 'package:ecommerce/core/models/product_model.dart';
import 'package:ecommerce/features/home/data/repo/home_repo.dart';
import 'package:ecommerce/core/components/custom_product_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ProductModel>> productListResponseFuture;
  @override
  void initState() {
    super.initState();
    productListResponseFuture = HomeRepo.getProducts();
  }

  List<ProductModel> products = List.generate(
      10,
      (index) => ProductModel.fromJson({
            "id": 1,
            "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
            "price": 109.95,
            "description":
                "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
            "category": "men's clothing",
            "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
            "rating": {"rate": 3.9, "count": 120}
          }));

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_outline_rounded, size: 32),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              FutureBuilder<List<ProductModel>>(
                  future: productListResponseFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    if (snapshot.hasData) {
                      return Expanded(
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
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return CustomProductCard(
                                product: snapshot.data![index],
                              );
                            },
                          ),
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
