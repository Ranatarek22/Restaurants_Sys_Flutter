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
  //late Future<Polyline> polylineFuture;

  //List<Marker> markers = [];
  bool showDirection = false;

  // LatLng endPoint = LatLng(30.35, 31.38);

  @override
  void initState()  {
    super.initState();
    // LatLng currentLocation = _getCurrentLocation();
    // LatLng endPoint = LatLng(widget.store.latitude, widget.store.longitude);
    //polylineFuture = getPolyline(currentLocation, endPoint);
    //markers = getMarkers();
    //_getCurrentLocation();
  }

  Future<LatLng> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    LatLng currentLocation = LatLng(position.latitude, position.longitude);
    return currentLocation;
  }

  // List<Marker> getMarkers() {
  //   return widget.stores.map((store) {
  //     return Marker(
  //         point: LatLng(store.latitude, store.longitude),
  //         width: 80,
  //         height: 80,
  //         child: GestureDetector(
  //           // onTap: () {
  //           //   _drawRouteToStore(LatLng(store.latitude, store.longitude));
  //           // },
  //           child: const Icon(
  //             Icons.location_on,
  //             size: 50.0,
  //             color: Colors.red,
  //           ),
  //           // const Icon(
  //           //   Icons.location_on,
  //           //   size: 50.0,
  //           //   color: Colors.red,
  //           // ),
  //         ));
  //   }).toList();
  // }

  Future<Polyline> getPolyline(LatLng startPoint, LatLng endPoint) async {
    OpenRouteService client = OpenRouteService(
        apiKey: '5b3ce3597851110001cf624832d534f20d944dd696c19e5654882d91');

    double startLat = startPoint.latitude;
    double startLng = startPoint.longitude;
    double endLat = endPoint.latitude;
    double endLng = endPoint.longitude;

    // Form Route between coordinates
    final List<ORSCoordinate> routeCoordinates =
        await client.directionsRouteCoordsGet(
      startCoordinate: ORSCoordinate(latitude: startLat, longitude: startLng),
      endCoordinate: ORSCoordinate(latitude: endLat, longitude: endLng),
    );

    // Print the route coordinates
    routeCoordinates.forEach(print);

    // Map route coordinates to a list of LatLng (requires google_maps_flutter package)
    // to be used in the Map route Polyline.
    final List<LatLng> routePoints = routeCoordinates
        .map((coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
        .toList();

    // Create Polyline (requires Material UI for Color)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Polyline>(
        future: _drawRouteToStore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error loading polyline: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final polyline = snapshot.data!;
            return FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(30.1006, 31.380653),
                initialZoom: 11,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                // MarkerLayer(
                //   markers: markers,
                // ),
                PolylineLayer(
                  polylines: [
                    polyline,
                  ],
                ),
              ],
            );
          } else {
            return Center(child: Text('No polyline data'));
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       polylineFuture = getPolyline(startPoint, endPoint);
      //     });
      //   },
      //   child: const Icon(Icons.add),
    );
  }
}

// getCoordinates() async {
//   var response =
//       await http.get(getRouteUrl('30.03,31.282', '30.0332,31.302'));

//   print(response.statusCode);
//   setState(() {
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       listOfPoints = data['features'][0]['geometry']['coordinates'];
//       points = listOfPoints
//           .map((e) => LatLng(e[1].toDouble(), e[0].toDouble()))
//           .toList();
//     } else {
//       print('Failed to get route');
//     }
//   });
// }
