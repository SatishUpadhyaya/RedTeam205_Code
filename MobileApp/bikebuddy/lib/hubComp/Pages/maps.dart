import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

// Map demo widget
class MapsDemo extends StatefulWidget {
  final LatLng position;
  final int lockedNum;
  // options:
  // 0 - unlocked
  // 1 - locked
  // 2 - stolen
  // 3 - unknown
  final String label;
  
  MapsDemo(this.position, this.lockedNum, this.label);

  @override
  State createState() => MapsDemoState();
}

// map demo state
class MapsDemoState extends State<MapsDemo> {
  // map controller that will be used to control the map
  GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    // rebuilds everytime
    if (mapController != null){
      // gets built every time the createState function is called
      // everytime a new coordinate is fed, update the map accordingly with the map controller
      // based on locked id, change qualities of the marker.
      double markerColor;

      if(widget.lockedNum == 0){
        markerColor = BitmapDescriptor.hueGreen;
      }
      else if(widget.lockedNum == 1){
        markerColor = BitmapDescriptor.hueRed;
      }
      else if(widget.lockedNum == 2){
        markerColor = BitmapDescriptor.hueOrange;
      }
      else{
        markerColor = BitmapDescriptor.hueBlue;
      }

      print(widget.label);
      mapController.clearMarkers();
      mapController.addMarker(MarkerOptions(
        position: widget.position,
      icon: BitmapDescriptor.defaultMarkerWithHue(
        markerColor),
        infoWindowText: InfoWindowText(widget.label, "bike")));

      //mapController.updateMapOptions(GoogleMapOptions(cameraPosition: CameraPosition(bearing: 0.0,target: widget.position)));
      CameraUpdate cam = CameraUpdate.newCameraPosition(CameraPosition(bearing: 0.0,target: widget.position));
      mapController.animateCamera(cam);
      
    }
  
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
                trackCameraPosition: true,
                compassEnabled: true),

              ),
            ),
          ),
          
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    print(widget.lockedNum);
    double initMarker;
      if(widget.lockedNum == 0){
        initMarker = BitmapDescriptor.hueGreen;
      }
      else if(widget.lockedNum == 1){
        initMarker = BitmapDescriptor.hueRed;
      }
      else if(widget.lockedNum == 2){
        initMarker = BitmapDescriptor.hueOrange;
      }
      else{
        initMarker = BitmapDescriptor.hueBlue;
      }
    setState(() { mapController = controller; 
      controller.addMarker(MarkerOptions(
        position: widget.position,
      icon: BitmapDescriptor.defaultMarkerWithHue(
        initMarker),
      infoWindowText: InfoWindowText(widget.label, "bike")
        ));
     });
  }
}