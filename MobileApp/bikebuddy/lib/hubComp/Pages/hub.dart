/*
* Author: Harold Ainsworth
* CU Boulder 
* Fall 2018
*/


import 'package:flutter/material.dart';



class HubPage extends StatefulWidget{
  @override
  State createState() => new HomePageState();
}

class HomePageState extends State<HubPage>{


	// hard-coded list of bike names for debugging
	List<String> _bikeList = ["MyBitchinBike", "🅱️ike", "MyBitchinBike2", "🅱️ike2", "MyBitchinBike3", "🅱️ike3", "MyBitchinBike4", "🅱️ike4"];
	String _firstName = "Harry";

	Widget _BikeProfile(String bikeName){
		/*
		* Purpose: Builds and returns a bike profile widget for a given bike so that the user can edit the bike and see bike data. 
		* @param - bikeName: the name of the bike. 
		* @return - Widget containing the given bike data.
		*/
		return new Container(
			padding: const EdgeInsets.all(10.0),
			child: new Card(
				color: Colors.blue,
				child: new Row(
					children: <Widget> [
						// bike icon
						new Container(
							padding: const EdgeInsets.all(10.0),
							child: new IconButton(
								icon: new Icon(Icons.directions_bike),
								color: Colors.blue[800],
								onPressed: (){
        							print("Bike info button pressed");
        						}
							),
						),
						// bike name
						new Container(
							padding: const EdgeInsets.all(10.0),
							child: new Text(
								bikeName,
								style: TextStyle(
									fontWeight: FontWeight.bold,
									fontSize: 14.0,
									color: Colors.white,
								)
							),
						),	
						// lock button
						new Container(
							padding: const EdgeInsets.all(10.0),
							child: new IconButton(
								icon: new Icon(Icons.lock),
								color: Colors.blue[800],
								onPressed: (){
        							print("Lock button pressed");
        						}
							),
											),
						// delete button
						new Container(
							padding: const EdgeInsets.all(10.0),
							child: new IconButton(
								icon: new Icon(Icons.delete),
								color: Colors.blue[800],
								onPressed: (){
        							print("Delete button pressed");
        						}
							),
						),
					]
				)
			)
		);
	}

	Widget _getBikeProfiles(){
		/*
		* Purpose: Get list of bike profiles from bikeList and return a ListView of these profiles.
		* @return - ListView of profiles.
		*/
		List<Widget> bikeProfiles = new List<Widget>();
		_bikeList.forEach((name) => bikeProfiles.add(_BikeProfile(name)));
		return new ListView(
			children: bikeProfiles,
		);
	}

	@override 
	Widget build(BuildContext context){
		return new Scaffold(
			appBar: AppBar(
				title: new Text(
					"Welcome, " + _firstName + "!",
					style: TextStyle(
						fontWeight: FontWeight.bold,
						fontSize: 30.0,
						color: Colors.white,
					)
				),
				actions: <Widget>[
					new IconButton(
						color: Colors.blue[800],
						icon: Icon(Icons.person),
						onPressed: (){
        					print("User profile button pressed");
        				}
					)
				]
			),
			body: new Stack(
				fit: StackFit.expand,
				children: <Widget> [

					// background image 
					new Positioned(
              			top: -300.0,
              			child: new Image(
                			image: new AssetImage("lib/images/loginImg.jpg"),
                			fit: BoxFit.fill,
                			color: Colors.black26,
                			colorBlendMode: BlendMode.darken,
              			),
            		),
					
					// BikeProfiles
					_getBikeProfiles()
				]
			),
			floatingActionButton: new FloatingActionButton(
				backgroundColor: Colors.white,
        		child: new Icon(
        			Icons.add,
        			color: Colors.blue,
        		),
        		onPressed: (){
        			print("Add button pressed");
        		}
      		),
		);
	}

}