import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late final GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Google Maps',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: CameraPosition(
          target: LatLng(23.80476174079768, 90.41571724439906),
          zoom: 16,
        ),
        onMapCreated: (GoogleMapController controller){
          _mapController = controller;
        },

        onTap: (LatLng latLng){
          print('Tapped on $latLng');
        },
        onLongPress: (LatLng latLng){
           print('Long Pressed at $latLng');
        },
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        trafficEnabled: true,
        zoomControlsEnabled: true,
      ),
    );
  }
}

