import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_sys/screens/stores.dart';
import 'package:restaurants_sys/utilities/services/Providers/product_provider.dart';
import 'package:restaurants_sys/utilities/services/Providers/store_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StoreCubit>(create: (_) => StoreCubit()..fetchStores()),
        BlocProvider<ProductCubit>(create: (_) => ProductCubit()),
      ],
      child: MaterialApp(
        home: StoreScreen(),
      ),
    );
  }
}
