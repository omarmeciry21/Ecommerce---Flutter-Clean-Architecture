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
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.grey[200],
                  child: Image.network(
                    product.image,
                    height: 175,
                    width: MediaQuery.of(context).size.width * 0.4,
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          )
                        ]),
                    padding: EdgeInsets.all(4),
                    child: Icon(isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline_rounded),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          product.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          product.price.toStringAsFixed(2) + 'EGP',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
        ),
      ],
    );
  }
}
