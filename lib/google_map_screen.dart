import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserLocation();
  }

  final TextEditingController _searchController = TextEditingController();
  final String _googleKey = "AIzaSyC-Uu7Kic0MsR77V1SB_SHhfzHLxCmEZ24";
  late final GoogleMapController _mapController;
  int _selectedIndex = 0;
  LatLng _currentLocation = LatLng(0.0, 0.0);
  final Set<Marker> _markers = <Marker>{};

  final Set<Polyline> _polyLine = <Polyline>{
    Polyline(
      polylineId: PolylineId('my-home'),
      points: [
        LatLng(23.821477296806954, 90.40332645177841),
        LatLng(23.81758044461688, 90.40547255426645),
      ],
      color: Colors.deepPurple,
      width: 3,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      jointType: JointType.round,
    ),
  };
  final Set<Circle> _circle = <Circle>{
    Circle(
      circleId: CircleId('most-effected'),
      center: LatLng(23.81758044461688, 90.40547255426645),
      radius: 220,
      strokeColor: Colors.red,
      strokeWidth: 3,
      fillColor: Colors.red.withOpacity(0.3),
      onTap: () {},
    ),
  };
  final Set<Polygon> _polygon = <Polygon>{
    Polygon(
      polygonId: PolygonId('random-polygon'),
      points: [
        LatLng(23.824560036526748, 90.40813263505697),
        LatLng(23.824883917773697, 90.40445230901241),
        LatLng(23.82202784618373, 90.40645893663168),
        LatLng(23.822842470948814, 90.4087870940566),
      ],
      fillColor: Colors.orange.withOpacity(0.3),
      strokeWidth: 3,
      strokeColor: Colors.orange,
      onTap: () {},
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.terrain,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            trafficEnabled: true,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            compassEnabled: true,
            mapToolbarEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _currentLocation,
              zoom: 16,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            markers: _markers,
            onTap: _addMarker,
            polylines: _polyLine,
            circles: _circle,
            polygons: _polygon,
          ),
          Positioned(
            top: 40,
            left: 8,
            right: 8,
            child: Card(
              color: Colors.white,
              shadowColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              child: Column(
                children: [
                  GooglePlaceAutoCompleteTextField(
                    boxDecoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    textEditingController: _searchController,
                    googleAPIKey: _googleKey,
                    inputDecoration: InputDecoration(
                      border: InputBorder.none,

                      prefixIcon: Icon(Icons.location_on, size: 32),
                      prefixIconColor: Colors.teal,
                      suffixIcon: Icon(Icons.mic, size: 30),
                      hintText: 'Search here',
                      hintStyle: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 15,
            right: 16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    _getUserLocation();
                  },
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Icon(Icons.my_location, color: Colors.blue),
                ),
                SizedBox(height: 20),
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.turn_right_outlined, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white38,
        indicatorColor: Colors.teal,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.location_on),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            label: 'You',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            label: 'Contribute',
          ),
        ],
      ),
    );
  }

  Future<void> _getUserLocation() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
      _mapController.animateCamera(
        CameraUpdate.newLatLngZoom(_currentLocation, 16),
      );
    }
  }

  void _addMarker(LatLng positionMarker) {
    final Marker marker = Marker(
      markerId: MarkerId('marker_1'),
      position: positionMarker,
      infoWindow: InfoWindow(title: 'This is InfoWindow', onTap: () {}),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      draggable: true,
    );
    setState(() {
      _markers.add(marker);
    });
  }
}
