import 'package:flutter/cupertino.dart';

class Store {
  final String id;
  final String name;
  final String type;
  final double latitude;
  final double longitude;
  final String updatedAt;
  final String createdAt;
  final List<dynamic>? users;

  Store({
    required this.id,
    required this.name,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.updatedAt,
    required this.createdAt,
    @required this.users,
  });

  factory Store.fromJson(json) {
    return Store(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
      users: json['users'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
      'users': users,
    };
  }
}
