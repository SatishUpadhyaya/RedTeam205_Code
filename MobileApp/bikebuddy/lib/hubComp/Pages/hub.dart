import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../../landingComp/Pages/login.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './maps.dart';
import './aboutUs.dart';

// todo - implement other states aside from locked, unlocked
// states:
// disarmed
// armed
// unknown
// stolen

// both futures will catch error (many possible ones) if there's an issue with put or get for each function
// get the bikes that this current user has upon login
Future<dynamic> getBikesRequest(var token) async {
    // print("Got:" + tokenMane["token"].toString());
    try{
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
    catch(e){
      print("Oh no...");
      print(e.toString());

    }
	}

Future<void> putBikeState(var token) async {
  // print("Got:" + tokenMane["token"].toString());
  try{

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
    List<String> statusi = ["disarmed", "armed"];

    // 0 - unlocked
  // 1 - locked, safe
  // 2 - stolen
  // 3 - unknown
    if(bikeState == "armed" || bikeState == "Unknown"){
      index = 0;
    }
    else if(bikeState == "disarmed"){
      index = 1;
    }

    var body = {"Name":bikeName.toString(),"lat":latLng[0].toDouble(),"lng":latLng[1].toDouble(),"state":statusi[index]};
    var secondRep = await http.put(Uri.encodeFull(secURL), body: json.encode(body), headers: header);
    print(secondRep.statusCode);
    print(secondRep.reasonPhrase);
    if(secondRep.statusCode == 200){
      print("State changed to " + statusi[index] + "!");
    }
    else{
      print("Something went wrong, your request did not succeed. Try again.");
    }
  }
  catch(e){
    print("Oh no.");
    print(e.toString());
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
  
  Timer timer;
  final token;
  LatLng position = LatLng(40, 105);
  // current coordinates of the bike
  String name = "";
  bool nameFound = false;
  int lockedId = 3;
  // lockedId - completely based on the state of the lock
  // 0 - unlocked
  // 1 - locked, safe
  // 2 - stolen
  // 3 - unknown
  void printFailure(){
    print("Nothing will happen");
  }
  void changeMapPosition(){
    // every n seconds, gets the user input and update and check for stolen biker
    // we don't want to change the state here unless the bike is seen to be marked as stolen.
    Future<dynamic> received = getBikesRequest(token);
    // take care of when getBikesRequest returns 0 
    received.then((value) =>
    setState((){
      if(value != 0){
        var coords = value["LatLng"];
        position = LatLng(coords[0], coords[1]);
        print("New position is " + position.toString());
        if(value["State"] == "stolen"){
          lockedId = 2;
          // bike is now seen to be stolen
          print("Bike is being STOLEN.");
        }
      }
      else{
        print("There was a wrong status code!");
      
      }
      // otherwise something went wrong
    })
    
    ).catchError((e) => print(e.toString() + " was the error."));
    
  }

  @override
    void initState() {
      super.initState();
      timer = Timer.periodic(Duration(seconds: 10), (Timer t) =>
      this.changeMapPosition()
      );
      // rebuild the widget every five seconds by calling the set state function

      // when value is received via the get request, need to call a function to set state
      // every n seconds, be able to update the timer
      // need to get the bike's latitude/longitude through the previous function
    }
  @override
    void dispose() {
        timer?.cancel();
        super.dispose();
      }
  
  void fixName(bike){
    if(!nameFound){
      // first time getting stats of the bike
      // if the lock status is unknown, user needs to hit the lock button to get it to be the regular sign
      setState(() {
          // armed, disarmed, stolen, unknown
          name = bike["Name"];
          String status = bike["State"];
          if(status == "armed"){
            lockedId = 1;
          }
          else if (status == "disarmed"){
            lockedId = 0;
          }
          else if (status == "stolen"){
            lockedId =  2;
          }
          else{
            // bad key or says unknown
            lockedId = 3;
          }
          nameFound = true;
        });
    }
  }


  // function to switch the color of the lock based on the when the user presses their option.  
  void switchLock(){
    setState(() {
      // can:  
      // switch from unknown to disarmed
      // switch from disarmed to armed
      // switch from armed to disarmed
      // take care of stolen bikes later
      if(lockedId == 3){
        lockedId = 0;
      }
      else if(lockedId == 1){
        lockedId = 0;
      }
      else if(lockedId == 0 ){
        lockedId = 1;
      }
        });
    // switching up locked feature on the state of the widget
  }
  HomePageState(this.token);

	@override 
	Widget build(BuildContext context){
    // rebuilds every time setState function is called - that way we can update the positions of the bike every n seconds
    // new mapsdemo object, takes in new location as a parameter based on where the bike is.
    MapsDemo map = MapsDemo(position, lockedId, name);
    map.createState();
    // put the bike state as well
    // create updated state of the map
    List<Widget> bikeItems = [];
    Future<dynamic> future = getBikesRequest(token);
    future.then((value) => 
    fixName(value))
    .catchError((e) => print(e.toString() + " was the error."));
    // do the changing of the name in fixname if the bike name hasn't been changed

    // have different symbol, symbolColor, splashSymbolColor based on status of bike
    
    IconData symbol;
    Color symbolColor;
    Color splashSymbolColor;
    if(this.lockedId == 0){
      // unlocked
      symbol = Icons.lock_open;
      symbolColor = Colors.green;
    }
    else if(this.lockedId == 1 || this.lockedId == 3){
      // unknown or locked
      symbol = Icons.lock;
      if(this.lockedId == 1){
        symbolColor = Colors.red;
        splashSymbolColor = Colors.red[100];
      }
      else{
        symbolColor = Colors.grey;
        splashSymbolColor = Colors.grey[100];
      }
    }
    else{
      // stolen, id is 2
      symbol = Icons.mood_bad;
      symbolColor = Colors.black;
      splashSymbolColor = Colors.black38;
    }
    var lockButton = new RawMaterialButton(
      onPressed: () {
        // changing the state of the bike.
        putBikeState(token);
        // change state, user can't manually make stolen
        switchLock();

      },
        child: new Icon(
          symbol,
          //Icons.lock,
          color: Colors.white,
          size: 150.0,
        ),
        shape: new CircleBorder(),
        elevation: 2.0,
        fillColor: symbolColor,
        splashColor: splashSymbolColor,
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
        // when rebuilt after being changed, fix this
        child: map
      )
    );

    final sizedBox = new Container(
      margin: new EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: new SizedBox(child: card)
    );

    bikeItems.add(sizedBox);

		return new Scaffold(
      //backgroundColor: Colors.grey,
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
              title: new Text('About Us'),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new AboutUsPage()),);
              },
            ),
            new Divider(),
            new ListTile(leading: new Icon(Icons.person_outline, color: Colors.cyan),
              title: new Text('Sign Out'),
              onTap: () {
                timer?.cancel();
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