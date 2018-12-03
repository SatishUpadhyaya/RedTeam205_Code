import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../../landingComp/Pages/login.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './maps.dart';

// function to use the readings from the gps sensor to determine the placement on the map for the user's bike.

Future<void> updatePosition(var token) async{
  // based on position from api, update the google map and 
  // google map controller.
  

}

// get the bikes that this current user has upon login
Future<dynamic> getBikesRequest(var token) async {
    // print("Got:" + tokenMane["token"].toString());
		String url = "https://bikebuddy.udana.systems/bikes";
    var header = {"Authorization":"Token "+ token["token"],
    "Accept": "application/json",
    "content-type": "application/json"};
		var response = await http.get(Uri.encodeFull(url), headers: header);
    if(response.statusCode == 200){
      Map<dynamic, dynamic> respD = json.decode(response.body);
      print(respD["Bikes"][0]);
      return respD["Bikes"][0];
    }
    else{
      print("Something went wrong...");
      return 0;
    }
	}

Future<void> putBikeState(var token) async {
  // print("Got:" + tokenMane["token"].toString());
  String url = "https://bikebuddy.udana.systems/bikes";
  String secURL = "https://bikebuddy.udana.systems/bikes/changeBike";
  var header = {"Authorization":"Token "+token["token"],
    "Accept": "application/json",
    "content-type": "application/json"};

  var response = await http.get(Uri.encodeFull(url), headers: header);  

  Map<dynamic, dynamic> respD = json.decode(response.body);
  
  var bikeName = respD["Bikes"][0]["Name"];
  var bikeState = respD["Bikes"][0]["State"];
  dynamic latLng = respD["Bikes"][0]["LatLng"];
  int index;
  List<String> statusi = ["armed", "disarmed"];
  if(bikeState == "armed"){
    index = 1;
  }
  else{
    index = 0;
  }
  var body = {"Name":bikeName.toString(),"lat":latLng[0].toDouble(),"lng":latLng[1].toDouble(),"state":statusi[index]};
  var secondRep = await http.put(Uri.encodeFull(secURL), body: json.encode(body), headers: header);
  print(secondRep.statusCode);
  print(secondRep.reasonPhrase);
  if(secondRep.statusCode == 200){
    print("State changed to " + statusi[index] + "!");

  }
  else{
    print("Something went wrong...");
  }
  // later have code for other states.
}

class HubPage extends StatefulWidget{
  final token;
  HubPage(this.token);
  @override
  State createState() => new HomePageState(token);
}



class HomePageState extends State<HubPage>{
  final token;
  String name = "";
  bool nameFound = false;
  bool locked = false;
  void fixName(bike){
    if(!nameFound){
      // first time getting stats of the bike
      setState(() {
          name = bike["Name"];
          String status = bike["State"];
          if(status == "armed"){
            locked = true;

          }
          else{
            locked = false;

          }
          nameFound = true;
        });
    }
    
  }
  // function to switch the color of the lock based on the when the user presses their option.  
  void switchLock(){
    setState(() { 
      locked = !locked;
        });
    // siwtching up locked feature on the state of the widget


  }
  HomePageState(this.token);
  LatLng posOf = LatLng(10.22, 10.22);

	@override 
	Widget build(BuildContext context){

    List<Widget> bikeItems = [];
    Future<dynamic> future = getBikesRequest(token);
    future.then((value) => fixName(value));
    // do the changing of the name in fixname if the bike name hasn't been changed
  
    //-------------------------------------------------------------- Zero Card ---------------------------------------------------
    var lockButton = new RawMaterialButton(
      onPressed: () {
        // locking vs unlocking bike
        putBikeState(token);
        // change state
        switchLock();

      },

        child: new Icon(

          this.locked ? Icons.lock : Icons.lock_open,
          //Icons.lock,
          color: Colors.white,
          size: 150.0,
        ),
        shape: new CircleBorder(),
        elevation: 2.0,
        fillColor: this.locked ? Colors.red : Colors.green,
        splashColor: this.locked ? Colors.red[100]: Colors.green[100],
        // fillColor: Colors.red,
        padding: const EdgeInsets.all(30.0),
    );

    final lockButtonContainer = new Container(
      margin: new EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: new SizedBox(child: lockButton)
    );

    bikeItems.add(lockButtonContainer);
    // container 
    var bikeMapLabel = new Text(name, style: TextStyle(color: Colors.black, fontSize: 20.0),);

    final bikeMapLabelContainer = new Container(
      margin: new EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: new SizedBox(child: bikeMapLabel)

    );
    bikeItems.add(bikeMapLabelContainer);

    var card = new Card(
      child: InkWell(
        splashColor: Colors.green,
        child: MapsDemo(posOf)
      )
    );

    final sizedBox = new Container(
      margin: new EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: new SizedBox(child: card)
    );

    bikeItems.add(sizedBox);


		return new Scaffold(
      appBar: new AppBar(
            title: new Text("Bike Buddy"),
      ),
       drawer: new Drawer(
        child: new ListView(
          children: <Widget> [
            new Container(
              child: ListTile(
              leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,),
                      onPressed: ()
                      {
                        Navigator.pop(context);
                      },),
              title: new Text("Bike Buddy", style: TextStyle(color: Colors.white, fontSize: 18.0),),
            ),
            color: Colors.blue,
            ),
            new ListTile(
              leading: new Icon(Icons.poll, color: Colors.blueAccent),
              title: new Text('Change Password'),
              onTap: () {
                // getPostOrder(context, userToken);
              },
            ),
            new Divider(),
            new ListTile(leading: new Icon(Icons.person_outline, color: Colors.cyan),
              title: new Text('Sign Out'),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new LoginPage()),);
              },
            ),
          ],
        )
      ),

      body:  new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            children: bikeItems,
          ),
          
        ]
      ),
    );
	}

}