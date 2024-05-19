import 'package:restaurants_sys/models/store_model.dart';
import '../helpers/api_config.dart';

class StoresService {
  Future<List<Store>> getAllStores() async {
    List<dynamic> data = await ApiConfig().get(endpoint: 'api/stores');

    // print(data);
    List<Store> storelist = [];
    for (int i = 0; i < data.length; i++) {
      storelist.add(Store.fromJson(data[i]));
    }
    return storelist;
  }

  Future<List<Store>> getAllStoresForProduct(
      {required String productId}) async {
    List<dynamic> data =
        await ApiConfig().get(endpoint: 'api/stores?productId=$productId');

    List<Store> storelist = [];
    for (int i = 0; i < data.length; i++) {
      storelist.add(Store.fromJson(data[i]));
    }
    return storelist;
  }
}
