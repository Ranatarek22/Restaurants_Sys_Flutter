import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_sys/models/store_model.dart';
import 'package:restaurants_sys/models/product_model.dart';
import 'package:restaurants_sys/utilities/cubits/get_store_products_states.dart';
import 'package:restaurants_sys/widgets/custom_product_card.dart';
import '../utilities/cubits/get_store_products_cubit.dart';

class StoreProductsScreen extends StatelessWidget {
  final Store store;

  StoreProductsScreen({required this.store});

  @override
  Widget build(BuildContext context) {
    context.read<ProductsCubit>().fetchProductsForStore(storeId: store.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          store.name,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32.0,
          horizontal: 16.0,
        ),
        child: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductsSuccessState) {
              List<ProductModel> productsList = state.products;
              if (productsList.isEmpty) {
                return Center(
                  child: Text(
                    'Sorry,\nThere are no products available here at this moment.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32),
                  ),
                );
              } else {
                return GridView.builder(
                  clipBehavior: Clip.none,
                  itemCount: productsList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 30,
                  ),
                  itemBuilder: (context, item) {
                    return CustomProductCard(
                      product: productsList[item],
                    );
                  },
                );
              }
            } else {
              return Center(
                child: Text(
                  'Oops,there was an error.Try again later.',
                  style: TextStyle(fontSize: 32),
                  textAlign: TextAlign.center,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
