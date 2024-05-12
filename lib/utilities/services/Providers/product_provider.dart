import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_sys/models/products.dart';
import 'package:restaurants_sys/utilities/services/Api/all_products.dart';
class ProductCubit extends Cubit<List<Product>> {
  final ProductService productService = ProductService();

  ProductCubit() : super([]);

  Future<void> fetchProductsForStore(String storeId) async {
    final products = await productService.getAllProductsForStore(storeId);
    emit(products);
  }
}
