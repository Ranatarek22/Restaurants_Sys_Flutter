import 'package:restaurants_sys/models/product_model.dart';

class ProductSearchState {}

class SearchInitialState extends ProductSearchState {}

class SearchLoadingState extends ProductSearchState {}

class SearchSuccessState extends ProductSearchState {
  final List<ProductModel> products;
  SearchSuccessState(this.products);
}

class SearchFailureState extends ProductSearchState {
  final String errorMessage;
  SearchFailureState({required this.errorMessage});
}
