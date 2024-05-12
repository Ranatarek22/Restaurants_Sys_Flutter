import 'dart:convert';

import 'package:restaurants_sys/models/stores.dart';
import 'package:restaurants_sys/utilities/services/all_store.dart';
import 'package:http/http.dart' as http;

class AllStores {
  Future<List<Store>> getAllStores() async {
    http.Response response = await http
        .get(Uri.parse('https://mobile-flutter-backend.vercel.app/api/stores'));
    List<dynamic> data = jsonDecode(response.body);

    List<Store> storelist = [];
    for (int i = 0; i < data.length; i++) {
      storelist.add(Store.fromJson(data[i]));
    }
    return storelist;
  }
}
