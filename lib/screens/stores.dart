import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_sys/models/stores.dart';
import 'package:restaurants_sys/screens/product_details.dart';
import 'package:restaurants_sys/utilities/services/Api/all_products.dart';
import 'package:restaurants_sys/utilities/services/Providers/store_provider.dart';

class StoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8C5CB3),
        title: Text(
          'Stores',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<StoreCubit, List<Store>>(
        builder: (context, storeList) {
          return ListView.builder(
            itemCount: storeList.length,
            itemBuilder: (context, index) {
              final store = storeList[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                        store: store,
                        productService: ProductService(),
                      ),
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      title: Text(
                        store.name,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
