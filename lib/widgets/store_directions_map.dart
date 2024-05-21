// ignore_for_file: unused_local_variable

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_route_service/open_route_service.dart';
import 'package:restaurants_sys/models/store_model.dart';

class StoreDirectionsMap extends StatefulWidget {
  StoreDirectionsMap({super.key, required this.store});

  final Store store;

  @override
  State<StoreDirectionsMap> createState() => _StoreDirectionsMapState();
}

class _StoreDirectionsMapState extends State<StoreDirectionsMap> {
  late Future<Polyline> _polylineFuture;
  late Future<double> _distanceFuture;

  bool showDirection = false;

  @override
  void initState() {
    super.initState();
    _polylineFuture = _drawRouteToStore();
    _distanceFuture = _calculateDistance();
  }

  Future<LatLng> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    LatLng currentLocation = LatLng(position.latitude, position.longitude);
    LatLng staticLoc = const LatLng(29.9906266, 31.1853446);
    return staticLoc;
  }

  Future<Polyline> getPolyline(LatLng startPoint, LatLng endPoint) async {
    OpenRouteService client = OpenRouteService(
      apiKey: '5b3ce3597851110001cf624832d534f20d944dd696c19e5654882d91',
    );

    double startLat = startPoint.latitude;
    double startLng = startPoint.longitude;
    double endLat = endPoint.latitude;
    double endLng = endPoint.longitude;

    final List<ORSCoordinate> routeCoordinates =
        await client.directionsRouteCoordsGet(
      startCoordinate: ORSCoordinate(latitude: startLat, longitude: startLng),
      endCoordinate: ORSCoordinate(latitude: endLat, longitude: endLng),
    );

    final List<LatLng> routePoints = routeCoordinates
        .map((coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
        .toList();

    final Polyline routePolyline = Polyline(
      points: routePoints,
      color: Colors.green,
      strokeWidth: 5,
    );

    return routePolyline;
  }

  Future<Polyline> _drawRouteToStore() async {
    LatLng currentLocation = await _getCurrentLocation();
    LatLng endPoint = LatLng(widget.store.latitude, widget.store.longitude);
    Polyline polylineFuture = await getPolyline(currentLocation, endPoint);
    setState(() {
      showDirection = true;
    });
    return polylineFuture;
  }

  Future<double> _calculateDistance() async {
    LatLng currentLocation = await _getCurrentLocation();
    LatLng endPoint = LatLng(widget.store.latitude, widget.store.longitude);

    double distanceInMeters = Geolocator.distanceBetween(
      currentLocation.latitude,
      currentLocation.longitude,
      endPoint.latitude,
      endPoint.longitude,
    );

    return distanceInMeters / 1000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Directions'),
      ),
      body: FutureBuilder(
        future: Future.wait([_polylineFuture, _distanceFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final polyline = snapshot.data![0] as Polyline;
            final distance = snapshot.data![1] as double;
            return Column(
              children: [
                Expanded(
                  child: FlutterMap(
                    options: const MapOptions(
                      initialCenter: LatLng(29.9906266, 31.1853446),
                      initialZoom: 10.25,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      ),
                      PolylineLayer(
                        polylines: [polyline],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Distance to store: ${distance.toStringAsFixed(2)} km'),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
