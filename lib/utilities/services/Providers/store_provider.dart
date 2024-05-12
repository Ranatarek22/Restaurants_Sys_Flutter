import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurants_sys/models/stores.dart';

import 'package:restaurants_sys/utilities/services/Api/all_store.dart';

// Store Cubit
class StoreCubit extends Cubit<List<Store>> {
  final AllStores allStores = AllStores();

  StoreCubit() : super([]);

  Future<void> fetchStores() async {
    final stores = await allStores.getAllStores();
    emit(stores);
  }
}
