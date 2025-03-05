import 'package:flutter/material.dart';
import 'package:google_map/ui/screens/google_map_screen.dart';

class GoogleMaps extends StatelessWidget {
  const GoogleMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleMapScreen(),
    );
  }
}
