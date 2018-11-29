import 'package:flutter/material.dart';



class HubPage extends StatefulWidget{
  @override
  State createState() => new HomePageState();
}

class HomePageState extends State<HubPage>{

	Widget BikeProfile(String bikeName){
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
					
					new Column (
						children: <Widget> [
							// bike sample card 
							BikeProfile("MyBitchinBike"),
							// bike sample card 
							BikeProfile("🅱️ike"),
							// bike sample card 
							BikeProfile("MyBitchinBike"),
							// bike sample card 
							BikeProfile("🅱️ike"),
							// bike sample card 
							BikeProfile("MyBitchinBike"),
							// bike sample card 
							BikeProfile("🅱️ike"),
							BikeProfile("MyBitchinBike"),
							// bike sample card 
							BikeProfile("🅱️ike"),
						]
					)
				]
			)
		);
	}

}