import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_sys/utilities/cubits/get_store_products_states.dart';
import '../../models/product_model.dart';
import '../services/products_service.dart';
class ProductsCubit extends Cubit<ProductsState> {
  final ProductsService _productsService = ProductsService();

  ProductsCubit() : super(ProductsInitialState());

  Future<void> fetchProductsForStore({required String storeId}) async {
    emit(ProductsLoadingState());
    try {
      final List<ProductModel> products = await _productsService.getAllProductsForStore(
          storeId: storeId);
      emit(ProductsSuccessState(products));
    } catch (e) {
      print(e);
      emit(ProductsFailureState(errorMessage: 'Failed to fetch products.'));
    }
  }
}
