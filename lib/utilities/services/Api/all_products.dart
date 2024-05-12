import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurants_sys/models/products.dart';

class ProductService {
  Future<List<Product>> getAllProducts() async {
    http.Response response = await http.get(
        Uri.parse('https://mobile-flutter-backend.vercel.app/api/products'));
    List<dynamic> data = jsonDecode(response.body);

    List<Product> productList = [];
    for (int i = 0; i < data.length; i++) {
      productList.add(Product.fromJson(data[i]));
    }
    return productList;
  }

  Future<List<Product>> getAllProductsForStore(String storeId) async {
    try {
      http.Response response = await http.get(
        Uri.parse('https://mobile-flutter-backend.vercel.app/api/products'),
      );

      if (response.statusCode == 200) {
        List<dynamic> productsData = jsonDecode(response.body);

        List<Product> productsForStore = [];
        for (int i = 0; i < productsData.length; i++) {
          var productData = productsData[i];
          List<dynamic> storesData = productData['stores'];

          for (int j = 0; j < storesData.length; j++) {
            var storeData = storesData[j];
        
            if (storeData['storeId'] == storeId) {
             
              int price = storeData['price'];
              Product product = Product.fromJson({
                'id': productData['id'],
                'name': productData['name'],
                'price': price,
              });

              productsForStore.add(product);

              break;
            }
          }
        }

        print('Products for store: $productsForStore');
        return productsForStore;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');

      throw e;
    }
  }
}
