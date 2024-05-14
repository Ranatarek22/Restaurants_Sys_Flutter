import 'package:restaurants_sys/models/store_model.dart';

class StoreProductModel {
  final String id;
  final int productPrice;
  final String productId;
  final String storeId;
  final String updatedAt;
  final String createdAt;
  final Store store;

  StoreProductModel({
    required this.id,
    required this.productPrice,
    required this.productId,
    required this.storeId,
    required this.updatedAt,
    required this.createdAt,
    required this.store,
  });

  factory StoreProductModel.fromJson(json) {
    return StoreProductModel(
      id: json['id'],
      productPrice: json['price'],
      productId: json['productId'],
      storeId: json['storeId'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
      store: Store.fromJson(json['store']),
    );
  }
}
