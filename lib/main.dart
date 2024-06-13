import 'dart:async';
import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:untitled3/toldirish.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Position> determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("error");
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    Position position = await determinePosition();
    print(position.latitude);
    print(position.longitude);
  }

  late GoogleMapController _controller;
  final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(41.359086, 69.293880), zoom: 12);
  final Set<Polyline> _polyline = {};

  List<Marker> markers = [];

  List<LatLng> latlng = [
    LatLng(41.359086, 69.293880),
    LatLng(40.38421, 71.78432),
    LatLng(40.52861, 70.9425)
  ];






  @override
  void initState() {
    super.initState();
    for (int i = 0; i < latlng.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: latlng[i],
          infoWindow: InfoWindow(
            title: "Really  Place ",
            snippet: "5  start",
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );

      setState(() {});
      _polyline.add(
        Polyline(polylineId: PolylineId("1"), points: latlng),
      );
    }
  }

  addMarker(cordinate) {
    int id = Random().nextInt(100);
    setState(() {
      markers.add(Marker(
        position: cordinate,
        markerId: MarkerId(id.toString()),
        infoWindow: InfoWindow(title: "Locate"),
      ));
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        mapType: MapType.normal,
        myLocationEnabled: true,
        polylines: _polyline,
        onMapCreated: (controller) {
          setState(() {
            _controller = controller;
          });
        },
        markers: markers.toSet(),
        onTap: (cordinate) {
          _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
          addMarker(cordinate);
        },
      ),

      floatingActionButton: Container(
        height: 50,
        width: 350,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Toldirish(),
            ));
          },
          child: Text("Toldirish",style: TextStyle(color: Colors.blue,fontSize: 24),),

        ),
      ),
    );

  }
}
