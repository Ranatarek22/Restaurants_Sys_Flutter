import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_sys/models/stores.dart';
import 'package:restaurants_sys/models/products.dart';
import 'package:restaurants_sys/utilities/services/Api/all_products.dart';
import 'package:restaurants_sys/utilities/services/Providers/product_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Store store;
  final ProductService productService;

  ProductDetailsScreen({required this.store, required this.productService});

  @override
  Widget build(BuildContext context) {
    context.read<ProductCubit>().fetchProductsForStore(store.id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8C5CB3),
        title: Text(
          store.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<ProductCubit, List<Product>>(
        builder: (context, productList) {
          if (productList.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // Handle product tap action if needed
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Price: \$${product.price.toString()}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
