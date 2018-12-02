import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../../landingComp/Pages/login.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './maps.dart';

Future<dynamic> getBikesRequest(var tokenMane) async {
    // print("Got:" + tokenMane["token"].toString());
		String url = "http://bikebuddy.udana.systems/bikes";

    var header = {"Authorization":"Token "+tokenMane["token"]};
    print(header);

		var response = await http.get(Uri.encodeFull(url), headers: header);
		print(response.body);

    Map<dynamic, dynamic> respD = json.decode(response.body);
    print(respD["Bikes"][0]);

    return respD["Bikes"][0];
	}

  Future<void> putBikeState(var tokenMane) async {
    // print("Got:" + tokenMane["token"].toString());
		String url = "http://bikebuddy.udana.systems/bikes";
    String secURL = "http://bikebuddy.udana.systems/bikes/changeBike";
    var header = {"Authorization":"Token "+tokenMane["token"]};
    print(header);

		var response = await http.get(Uri.encodeFull(url), headers: header);
		print(response.body);

    Map<dynamic, dynamic> respD = json.decode(response.body);
    
    var bikeName = respD["Bikes"][0]["Name"];
    var bikeState = respD["Bikes"][0]["State"];
    dynamic latLng = respD["Bikes"][0]["LatLng"];

    print(bikeName);
    print(bikeState);
    print(latLng);

    if(bikeState == "armed")
    {
      //put state as disarmed
      var bod = {"Name":bikeName.toString(),"lat":latLng[0].toDouble(),"lng":latLng[1].toDouble(),"state":"disarmed"};
      print(bod);
      await http.put(Uri.encodeFull(secURL), body: json.encode(bod), headers: header);
      print("State changed to disarmed");
    }
    else
    {
      //put state as armed
      var bod = {"Name":bikeName.toString(),"lat":latLng[0].toDouble(),"lng":latLng[1].toDouble(),"state":"armed"};
      print(bod);
      await http.put(Uri.encodeFull(secURL), body: json.encode(bod), headers: header);
      print("State changed to armed");
    }
	}

class HubPage extends StatefulWidget{
  final tokenMane;
  HubPage(this.tokenMane);

  @override
  State createState() => new HomePageState(tokenMane);
}

class HomePageState extends State<HubPage>{
  final tokenMane;
  HomePageState(this.tokenMane);
  LatLng posOf = LatLng(10.22, 10.22);

	@override 
	Widget build(BuildContext context){

    List<Widget> cardList = [];

    //-------------------------------------------------------------- Zero Card ---------------------------------------------------
    var zeroCard = new RawMaterialButton(
      onPressed: () {
        putBikeState(tokenMane);
      },
    
        child: new Icon(
          Icons.lock_open,
          // Icons.lock,
          color: Colors.white,
          size: 150.0,
        ),
        shape: new CircleBorder(),
        elevation: 2.0,
        fillColor: Colors.green,
        // fillColor: Colors.red,
        padding: const EdgeInsets.all(30.0),
    );

    final zeroSizedBox = new Container(
      margin: new EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: new SizedBox(child: zeroCard,)
    );

    cardList.add(zeroSizedBox);
//----------------------------------------------------------- ^^ Zero Card ^^ ------------------------------------------------

//-------------------------------------------------------------- First Card ---------------------------------------------------
    var card = new Card(
      child: InkWell(
        splashColor: Colors.green,
        child: new Column(
          children: <Widget>[
            new ListTile(
              leading: new Icon(Icons.looks),
              title: new Text("My Bike's Location"),
              trailing: new Icon(Icons.looks),
            ),
            MapsDemo(posOf),
          ]
        ),
        onTap: () {
                // getPostDrone(context, userToken);
              },
      )
    );

    final sizedBox = new Container(
      margin: new EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: new SizedBox(child: card,)
    );

    cardList.add(sizedBox);
//----------------------------------------------------------- ^^ First Card ^^ ------------------------------------------------

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
          new Positioned(
            child: new Material(
              color:Colors.white,
              child: new ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(25.0),
                children: cardList,
              )
            )
          ), 
        ]
      ),
    );
	}

}