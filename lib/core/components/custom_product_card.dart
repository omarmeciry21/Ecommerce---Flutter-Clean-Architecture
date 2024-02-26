import 'package:ecommerce/core/models/product_model.dart';
import 'package:flutter/material.dart';

class CustomProductCard extends StatelessWidget {
  const CustomProductCard(
      {super.key,
      required this.product,
      this.isFavorite = false,
      required this.onFavoriteButtonTapped});
  final ProductModel product;
  final bool isFavorite;
  final void Function()? onFavoriteButtonTapped;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 160,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Stack(
            children: [
              Container(
                height: 175,
                width: MediaQuery.of(context).size.width * 0.4,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: InkWell(
                  onTap: onFavoriteButtonTapped,
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Icon(isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline_rounded),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          product.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          product.price.toStringAsFixed(2) + 'EGP',
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
        ),
      ],
    );
  }
}
