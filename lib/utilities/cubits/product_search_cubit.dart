import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_sys/utilities/cubits/product_search_states.dart';
import '../services/products_service.dart';

class ProductSearchCubit extends Cubit<ProductSearchState> {
  final ProductsService _productsService = ProductsService();

  ProductSearchCubit() : super(SearchInitialState());

  void searchProducts({required String query}) async {
    emit(SearchLoadingState());
    if (query.isEmpty) {
      emit(SearchSuccessState([]));
      return;
    }
    try {
      final products = await _productsService.searchForProduct(productName: query);
      emit(SearchSuccessState(products));
    } catch (e) {
      emit(SearchFailureState(errorMessage: 'Failed to fetch products.'));
    }
  }
}
