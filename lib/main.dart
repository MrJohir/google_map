import 'package:flutter/material.dart';
import 'google_map_screen.dart';

void main() {
  runApp(const GoogleMaps());
}

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: GoogleMapScreen());
  }
}


