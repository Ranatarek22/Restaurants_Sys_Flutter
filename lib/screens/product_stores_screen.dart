// store_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_sys/models/product_model.dart';
import 'package:restaurants_sys/models/store_model.dart';
import 'package:restaurants_sys/widgets/custom_store_card.dart';

import '../utilities/cubits/product_search_cubit.dart';
import '../utilities/cubits/product_search_states.dart';
import '../utilities/services/stores_service.dart';

class ProductStoresScreen extends StatelessWidget {
  const ProductStoresScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductSearchCubit, ProductSearchState>(
      builder: (context, state) {
        if (state is SearchSuccessState) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Stores have ${product.name}'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: FutureBuilder(
                future:
                    StoresService().getAllStoresForProduct(productId: product.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      'Error: ${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 32),
                    ));
                  } else {
                    final storeList = snapshot.data ?? [];
                    return GridView.builder(
                      clipBehavior: Clip.none,
                      itemCount: storeList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .8,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 30,
                      ),
                      itemBuilder: (context, item) {
                        return CustomStoreCard(product: product,store: storeList[item],);
                      },
                    );
                  }
                },
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Stores'),
            ),
            body: Center(
              child: Text('Please select a product.'),
            ),
          );
        }
      },
    );
  }
}
