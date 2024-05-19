import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_sys/models/store_model.dart';
import 'package:restaurants_sys/screens/store_products_screen.dart';
import 'package:restaurants_sys/utilities/services/stores_service.dart';

import '../utilities/cubits/them_cubit.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stores',
        ),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<ThemeCubit>(context).toggleTheme();
            },
            icon: Icon(Icons.dark_mode),
          ),
        ],
      ),
      body: FutureBuilder<List<Store>>(
        future: StoresService().getAllStores(),
        builder: (context, storeList) {
          if (storeList.hasData) {
            return ListView.builder(
              itemCount: storeList.data!.length,
              itemBuilder: (context, index) {
                final store = storeList.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StoreProductsScreen(
                          store: store,
                        ),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          store.type == 'CAFE'
                              ? 'assets/images/cafe.png'
                              : 'assets/images/rest.png',
                        ),
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
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
