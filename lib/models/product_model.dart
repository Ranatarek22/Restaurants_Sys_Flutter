import 'package:flutter/cupertino.dart';
import 'package:restaurants_sys/models/store_product_model.dart';

class ProductModel {
  final String id;
  final String name;
  final int? price;
  final String updatedAt;
  final String createdAt;
  final String? storeLinkId;
  final List<StoreProductModel>? stores;

  ProductModel({
    required this.id,
    required this.name,
    @required this.price,
    required this.updatedAt,
    required this.createdAt,
    @required this.storeLinkId,
    @required this.stores,
    required store,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // Parse the list of stores into a list of StoreProductModel objects
    List<StoreProductModel>? storeProducts = [];
    if (json['stores'] != null) {
      storeProducts = List<StoreProductModel>.from(json['stores']
          .map((storeJson) => StoreProductModel.fromJson(storeJson)));
    }

    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
      storeLinkId: json['storeLinkId'],
      stores: storeProducts,
      store: null,
    );
  }
}
