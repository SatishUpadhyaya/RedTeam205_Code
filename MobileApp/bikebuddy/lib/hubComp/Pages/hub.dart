import 'package:flutter/material.dart';



class HubPage extends StatefulWidget{
  @override
  State createState() => new HomePageState();
}

class HomePageState extends State<HubPage>{


	// hard-coded list of bike names for debugging
	List<String> _bikeNames = ["MyBitchinBike", "🅱️ike", "MyBitchinBike2", "🅱️ike2", "MyBitchinBike3", "🅱️ike3", "MyBitchinBike4", "🅱️ike4"];

	Widget BikeProfile(String bikeName){
		/*
		* Purpose: Builds a bike profile widget for a given bike so that the user can edit the bike and see bike data. 
		* @param - bikeName: the name of the bike. 
		* @return - widget containing the given bike data.
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
							),
											),
						// delete button
						new Container(
							padding: const EdgeInsets.all(10.0),
							child: new IconButton(
								icon: new Icon(Icons.delete),
							),
						),
					]
				)
			)
		);
	}

	Widget getBikeProfiles(){
		/*
		* 
		*/
		List<Widget> bikeProfiles = new List<Widget>();
		_bikeNames.forEach((name) => bikeProfiles.add(BikeProfile(name)));
		return new ListView(
			children: bikeProfiles,
		);
	}

	@override 
	Widget build(BuildContext context){
		return new Scaffold(
			appBar: AppBar(
				title: new Text(
					"Welcome, <firstname>!",
					style: TextStyle(
						fontWeight: FontWeight.bold,
						fontSize: 30.0,
						color: Colors.white,
					)
				),
				actions: <Widget>[
					new IconButton(
						icon: Icon(Icons.person),
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
					getBikeProfiles()
				]
			)
		);
	}

}