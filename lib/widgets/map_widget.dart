// ignore_for_file: must_be_immutable, unused_import

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_route_service/open_route_service.dart';
import 'package:restaurants_sys/models/store_model.dart';

class MapWidget extends StatefulWidget {
  MapWidget({super.key, required this.stores});

  List<Store> stores = [];

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late Future<Polyline> polylineFuture;
  List<Marker> markers = [];
  bool showDirection = false;

  @override
  void initState() {
    super.initState();
    markers = getMarkers();
  }

  List<Marker> getMarkers() {
    return widget.stores.map((store) {
      return Marker(
          point: LatLng(store.latitude, store.longitude),
          width: 80,
          height: 80,
          child: GestureDetector(
            child: const Icon(
              Icons.location_on,
              size: 50.0,
              color: Colors.red,
            ),
          ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(30.1006, 31.380653),
          initialZoom: 10,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(
            markers: markers,
          ),
        ],
      ),
    );
  }
}