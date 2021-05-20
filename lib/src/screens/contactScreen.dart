import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:practica2/src/utils/configuration.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({Key key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();
    CameraPosition _myPosition = CameraPosition(
      target: LatLng(20.5417018, -100.8130878),
      zoom: 20.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
        backgroundColor: Configuration.colorHeader,
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _myPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
