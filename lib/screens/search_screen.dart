import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_sys/screens/product_stores_screen.dart';

import '../models/product_model.dart';
import '../utilities/cubits/product_search_cubit.dart';
import '../utilities/cubits/product_search_states.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<ProductModel> productList = [];
  String searchedProductId = '';

  bool _isMapView = false;

  void _toggleView() {
    setState(() {
      _isMapView = !_isMapView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(
          alignment: const Alignment(1.0, 1.0),
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color:
                      _controller.text.length > 0 ? Colors.black : Colors.grey,
                ),
                hintText: 'Search for a product...',
                hintStyle: TextStyle(fontSize: 20),
              ),
              onChanged: (query) {
                setState(() {
                  context
                      .read<ProductSearchCubit>()
                      .searchProducts(query: query);
                });
              },
              controller: _controller,
            ),
            _controller.text.length > 0
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _controller.clear();
                        context
                            .read<ProductSearchCubit>()
                            .searchProducts(query: _controller.text);
                      });
                    })
                : Container(
                    height: 0.0,
                  ),
          ],
        ),
      ),
      body: BlocBuilder<ProductSearchCubit, ProductSearchState>(
        builder: (context, state) {
          if (state is SearchSuccessState) {
            productList = state.products;
            return Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ListView.separated(
                itemCount: productList.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final product = productList[index];
                  return ListTile(
                    title: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductStoresScreen(
                            product: product,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else if (state is SearchFailureState) {
            return Center(child: Text(state.errorMessage));
          } else if (state is SearchLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
