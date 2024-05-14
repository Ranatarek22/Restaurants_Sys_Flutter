import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_sys/models/store_model.dart';

import 'package:restaurants_sys/utilities/services/stores_service.dart';

// Store Cubit
class StoreCubit extends Cubit<List<Store>> {
  final StoresService allStores = StoresService();

  StoreCubit() : super([]);

  Future<void> fetchStores() async {
    final stores = await allStores.getAllStores();
    emit(stores);
  }
}
