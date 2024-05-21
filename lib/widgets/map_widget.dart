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
  LatLng currentLocation = LatLng(30.013056, 31.208853);

  // LatLng startPoint = LatLng(30.13, 31.285);
  LatLng startPoint = LatLng(30.13, 31.285);
  LatLng endPoint = LatLng(30.35, 31.38);

  @override
  void initState() {
    super.initState();
    //polylineFuture = getPolyline(startPoint, endPoint);
    markers = getMarkers();
    // _getCurrentLocation();
  }

  // Future<void> _getCurrentLocation() async {
  //   Position position = await Geolocator.getCurrentPosition();
  //   setState(() {
  //     currentLocation = LatLng(position.latitude, position.longitude);
  //   });
  // }

  List<Marker> getMarkers() {
    return widget.stores.map((store) {
      return Marker(
          point: LatLng(store.latitude, store.longitude),
          width: 80,
          height: 80,
          child: GestureDetector(
            // onTap: () {
            //   _drawRouteToStore(LatLng(store.latitude, store.longitude));
            // },
            child: const Icon(
              Icons.location_on,
              size: 50.0,
              color: Colors.red,
            ),
            // const Icon(
            //   Icons.location_on,
            //   size: 50.0,
            //   color: Colors.red,
            // ),
          ));
    }).toList();
  }

  Future<Polyline> getPolyline(LatLng startPoint, LatLng endPoint) async {
    OpenRouteService client = OpenRouteService(
        apiKey: '5b3ce3597851110001cf62481a79a2f7c4e94d57823756dac37af54e');

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

  Future<void> _drawRouteToStore(LatLng storeLocation) async {
    polylineFuture = getPolyline(currentLocation, storeLocation);
    setState(() {
      showDirection = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: //FutureBuilder<markers>(
        // future: markers,
        // builder: (context, snapshot) {
        //   if (snapshot.connectionState == ConnectionState.waiting) {
        //     return const Center(child: CircularProgressIndicator());
        //   } else if (snapshot.hasError) {
        //     return Center(
        //         child: Text('Error loading polyline: ${snapshot.error}'));
        //   } else if (snapshot.hasData) {
        //     final polyline = snapshot.data ?? Polyline(points: []);
        FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(30.1006, 31.380653),
                initialZoom: 11,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                MarkerLayer(
                  markers: markers,
                ),
                // PolylineLayer(
                //   polylines: [
                //     polyline,
                //   ],
                // ),
              ],
            ),
          // } else {
          //   return const Center(child: Text('No polyline data'));
          // }
        //},
      //),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       polylineFuture = getPolyline(startPoint, endPoint);
      //     });
      //   },
      //   child: const Icon(Icons.add),
      // ),
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