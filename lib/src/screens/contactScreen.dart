import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:practica2/src/utils/configuration.dart';
import 'package:url_launcher/url_launcher.dart';

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
      floatingActionButton: _boomMenu(),
    );
  }

  _boomMenu() {
    return BoomMenu(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 20),
      overlayColor: Colors.black,
      overlayOpacity: 0.7,
      children: [
        MenuItem(
          title: "Email",
          child: Icon(Icons.email),
          titleColor: Colors.green[850],
          subtitle: "edu.dan68@gmail.com",
          subTitleColor: Colors.grey[850],
          backgroundColor: Colors.grey[50],
          onTap: () {
            _sendEmail();
          },
        ),
        MenuItem(
          title: "Phone Number",
          child: Icon(Icons.phone),
          titleColor: Colors.green[850],
          subtitle: "4611842703",
          subTitleColor: Colors.grey[850],
          backgroundColor: Colors.grey[50],
          onTap: () {
            _callPhone();
          },
        ),
        MenuItem(
          title: "Message Number",
          child: Icon(Icons.phone),
          titleColor: Colors.green[850],
          subtitle: "4611842703",
          subTitleColor: Colors.grey[850],
          backgroundColor: Colors.grey[50],
          onTap: () {
            _sendMessage();
          },
        ),
      ],
    );
  }

  _callPhone() async {
    const tel = 'tel:4611842703';
    if (await canLaunch(tel)) {
      await launch(tel);
    } else {
      throw 'Could not launch $tel';
    }
  }

  _sendMessage() async {
    const sms = 'sms:4611842703';
    if (await canLaunch(sms)) {
      await launch(sms);
    } else {
      throw 'Could not launch $sms';
    }
  }

  _sendEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'edu.dan68@gmail.com',
      query: 'subject=Send Email&body=Hola desde movies flutter',
    );

    var email = params.toString();
    if (await canLaunch(email)) {
      await launch(email);
    } else {
      throw 'Could not launch $email';
    }
  }
}
