import 'package:flutter/material.dart';
import 'package:restaurants_sys/models/product_model.dart';

class CustomProductCard extends StatelessWidget {
  const CustomProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Handle product tap action if needed
        },
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.2),
                      blurRadius: 50,
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
                width: 200,
                height: 150,
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text
                              ('${product.price} L.E'),
                            Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -75,
                left: 20,
                child: Image.asset(
                  'assets/images/pasta.png',
                  height: 150,
                  width: 150,
                ),
              ),
            ],
          ),
        ),
    );
  }
}
