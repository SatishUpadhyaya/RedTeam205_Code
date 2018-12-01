import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class MapsDemo extends StatefulWidget {
  final LatLng posOf;

  MapsDemo(this.posOf);

  @override
  State createState() => MapsDemoState();
}

class MapsDemoState extends State<MapsDemo> {

  GoogleMapController mapController;
  
  @override
  Widget build(BuildContext context) {
    
    LatLng midpoint = LatLng((widget.posOf.latitude +widget.posOf.latitude)/2.0, (widget.posOf.longitude +widget.posOf.longitude)/2.0);

    return Padding(
      padding: EdgeInsets.fromLTRB(0.0,15.0,0.0,0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: SizedBox(
              width: 400.0,
              height: 200.0,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                options: GoogleMapOptions(cameraPosition: CameraPosition(bearing: 0.0,target: midpoint),minMaxZoomPreference: MinMaxZoomPreference(10.0, 100.0)),
              ),
            ),
          ),
          
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() { mapController = controller; 
      controller.addMarker(MarkerOptions(position: widget.posOf));
     });
  }
}