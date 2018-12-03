import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class MapsDemo extends StatefulWidget {
  final LatLng position;

  MapsDemo(this.position);

  @override
  State createState() => MapsDemoState();
}

class MapsDemoState extends State<MapsDemo> {

  GoogleMapController mapController;
  
  @override
  Widget build(BuildContext context) {
    
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
                options: GoogleMapOptions(cameraPosition: CameraPosition(bearing: 0.0,target: widget.position),
                minMaxZoomPreference: MinMaxZoomPreference(10.0, 100.0),
                tiltGesturesEnabled: true,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                rotateGesturesEnabled: true,
                trackCameraPosition: true),
              ),
            ),
          ),
          
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() { mapController = controller; 
      controller.addMarker(MarkerOptions(position: widget.position));
     });
  }
}