import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_sys/screens/home_screen.dart';
import 'package:restaurants_sys/utilities/cubits/get_store_products_cubit.dart';
import 'package:restaurants_sys/utilities/cubits/product_search_cubit.dart';
import 'package:restaurants_sys/utilities/cubits/stores_cubit.dart';
import 'package:restaurants_sys/utilities/cubits/them_cubit.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<StoreCubit>(create: (_) => StoreCubit()..fetchStores()),
        BlocProvider<ProductsCubit>(create: (_) => ProductsCubit()),
        BlocProvider<ProductSearchCubit>(create: (_) => ProductSearchCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeState.themeData,
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
