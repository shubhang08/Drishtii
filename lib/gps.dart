import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class GPS extends StatefulWidget {
  const GPS({Key? key}) : super(key: key);

  @override
  State<GPS> createState() => _GPSState();
}

class _GPSState extends State<GPS> {

  Position? _position;

  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _position = position;
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Location"),
        centerTitle: true,
        backgroundColor: Color(0xFF3C3E52),

      ),
      backgroundColor: Color(0xBE3C3E52),
      body: Container(

        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(

                child: _position != null ? Text('Current Location: ' + _position.toString(),style: TextStyle(color: Colors.white,fontSize: 20),) : Text('No Location Data',style: TextStyle(color: Colors.white,fontSize: 20)),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(onPressed: _getCurrentLocation, icon: Icon(Icons.location_on),label: Text('Where AM I'),)
            ],
          ),
        ),
      ),

    );
  }
}
