import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late final GoogleMapController _mapController;
  int _selectedIndex = 0;

  final Set<Marker> _markers = <Marker>{
    Marker(
      markerId: MarkerId('my-home'),
      position: LatLng(23.819481190679497, 90.40947441011667),
      infoWindow: InfoWindow(title: 'My Home', onTap: () {}),
      onTap: () {},
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      draggable: true,
      onDragStart: (LatLng startLatLng) {
        print('Start LatLng $startLatLng');
      },
      onDragEnd: (LatLng endLatLng) {
        print('End LatLng $endLatLng');
      },
    ),
    Marker(
      markerId: MarkerId('my-office'),
      position: LatLng(23.821477296806954, 90.40332645177841),
      infoWindow: InfoWindow(title: 'My Office', onTap: () {}),
      onTap: () {},
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      draggable: true,
      onDragStart: (LatLng startLatLng) {
        print('Start LatLng $startLatLng');
      },
      onDragEnd: (LatLng endLatLng) {
        print('End LatLng $endLatLng');
      },
    ),
    Marker(
      markerId: MarkerId('my-club'),
      position: LatLng(23.81758044461688, 90.40547255426645),
      infoWindow: InfoWindow(title: 'My Club', onTap: () {}),
      onTap: () {},
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      draggable: true,
      onDragStart: (LatLng startLatLng) {
        print('Start LatLng $startLatLng');
      },
      onDragEnd: (LatLng endLatLng) {
        print('End LatLng $endLatLng');
      },
    ),
  };

  final Set<Polyline> _polyLine = <Polyline>{
    Polyline(
      polylineId: PolylineId('my-home'),
      points: [
        LatLng(23.819481190679497, 90.40947441011667),
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
            zoomControlsEnabled: true,
            compassEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(23.819402364100583, 90.40612634271383),
              zoom: 16,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },

            onTap: (LatLng latLng) {
              print('Tapped on $latLng');
            },
            onLongPress: (LatLng latLng) {
              print('Long Pressed at $latLng');
            },
            markers: _markers,
            polylines: _polyLine,
            circles: _circle,
            polygons: _polygon,
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(48),
                    ),
                    color: Colors.white,
                    child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.location_on)],
                        ),
                        SizedBox(width: 24),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text('Search here')],
                        ),
                        SizedBox(width: 90),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.mic)],
                        ),
                        SizedBox(width: 28),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [CircleAvatar()],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      _currentMyLocation();
                    },
                    child: Icon(Icons.my_location, color: Colors.black),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(width: 16),
                  FloatingActionButton(
                    onPressed: () {},
                    child: Icon(Icons.turn_right_outlined, color: Colors.white),
                    backgroundColor: Colors.teal,
                  ),
                  SizedBox(width: 16),
                ],
              ),
              SizedBox(height: 24),
            ],
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

  void _currentMyLocation() {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(23.819402364100583, 90.40612634271383),
          zoom: 16,
        ),
      ),
    );
  }
}
