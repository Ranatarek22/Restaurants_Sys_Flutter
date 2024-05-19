
import 'package:restaurants_sys/models/product_model.dart';
import '../helpers/api_config.dart';



class ProductsService {

  Future<List<ProductModel>> getAllProducts() async {
    List<dynamic> data = await ApiConfig().get(endpoint: 'api/products');

    List<ProductModel> productsList = [];
    for (int i = 0; i < data.length; i++) {
      productsList.add(ProductModel.fromJson(data[i]));
    }
    return productsList;
  }


  Future<List<ProductModel>> getAllProductsForStore({required String storeId}) async {
        List<dynamic> data = await ApiConfig().get(endpoint: 'api/stores/$storeId/products');

        List<ProductModel> productsForStore = [];
        for (int i = 0; i < data.length; i++) {
          productsForStore.add(ProductModel.fromJson(data[i]));
        }
        return productsForStore;
    }

  Future<List<ProductModel>> searchForProduct({required String productName}) async {
    List<ProductModel> allProducts = await getAllProducts();
    List<ProductModel> productList = [];
    for (int i = 0; i < allProducts.length; i++) {
      if(allProducts[i].name.toLowerCase().startsWith(productName.toLowerCase())) {
        productList.add(allProducts[i]);
      }
    }
    return productList;
  }
}
