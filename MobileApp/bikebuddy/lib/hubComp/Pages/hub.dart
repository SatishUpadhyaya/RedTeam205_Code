import 'package:flutter/material.dart';

class HubPage extends StatefulWidget{
  @override
  State createState() => new HomePageState();
}

class HomePageState extends State<HubPage>{

	@override 
	Widget build(BuildContext context){
		return new Scaffold(
			backgroundColor: Colors.black,
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
							// Welcome header
							new Container(
								width: 2050.0,
								padding: const EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 10.0),
								child: new Card(
									color: Colors.blue,
									child: new Container(
										padding: const EdgeInsets.all(10.0),
										child: new Center (
											child: new Text(
												"Welcome, <firstname>!",
												style: TextStyle(
													fontWeight: FontWeight.bold,
													fontSize: 30.0,
													color: Colors.white,
												)
											)
										)
									)
								)
							),
							// bike sample card 
							new Container(
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
													"<bikename>",
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
							),
							// bike sample card 
							new Container(
								padding: const EdgeInsets.all(10.0),
								child: new Card(
									color: Colors.blue,
									child: new Row(
										children: <Widget> [
											new Container(
												padding: const EdgeInsets.all(10.0),
												child: new IconButton(
													icon: new Icon(Icons.directions_bike),
												),
											),
											new Container(
												padding: const EdgeInsets.all(10.0),
												child: new Text(
													"<bikenameislonger>",
													style: TextStyle(
														fontWeight: FontWeight.bold,
														fontSize: 14.0,
														color: Colors.white,
													)
												),
											),
											new Container(
												padding: const EdgeInsets.all(10.0),
												child: new IconButton(
													icon: new Icon(Icons.lock),
												),
											),
											new Container(
												padding: const EdgeInsets.all(10.0),
												child: new IconButton(
													icon: new Icon(Icons.delete),
												),
											),
										]
									)
								)
							)
						]
					)
				]
			)
		);
	}

}