import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../../hubComp/Pages/hub.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL() async {
    const url = 'https://bike.udana.systems/';
    try{
      // if (await canLaunch(url)) {
        await launch(url);
      // } else {
      //   throw 'Could not launch $url';
      // }
    }
    catch(e)
    {
      print("Couldn't open the link because of: "+ e);
    }
  }

class AboutUsPage extends StatefulWidget{
  @override
  State createState() => new AboutUsPageState();
}

class AboutUsPageState extends State<AboutUsPage> with SingleTickerProviderStateMixin{

  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  String bikeBuddy = "BIKE BUDDY";
  String desc = "\nWorking hard to keep your bike safe so that\nyou don't have to!";
  String desc2 = "\nStarted by CU Boulder students to keep\ntheir bikes safe, we wanted to\nhelp others do the same.";
  String pv = "\nPlease visit:";
  String link = "https://bike.udana.systems/";
  String moreinfo = "for more information";

  // some code for taking care of the desired animations 
  @override
  void initState()
  {
    super.initState();
    _iconAnimationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 500)
    );
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.easeOut,
    );
    _iconAnimation.addListener(()=>this.setState((){}));
    _iconAnimationController.forward();
  }


  Widget createPadding(double paddingVal)
  {
    return new Padding(
      padding: EdgeInsets.only(bottom: paddingVal),
    );
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
       appBar: new AppBar(
          title: new Text("About Bike Buddy"),
      ),
      backgroundColor: Colors.amber[200],
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[

          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                child: new Image(
                  image: new AssetImage("lib/images/bbLogo.png"),
                ),
                padding: const EdgeInsets.all(60.0),
              ),
            ],
          ),

          new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
                createPadding(10.0),
              new Container(
                // padding: const EdgeInsets.only(bottom:30.0),
                width: 350.0,
              child: new Card(
                color: Colors.amber[100],
                child: InkWell(
                  splashColor: Colors.yellow,
                  child: new Column(
                    children: <Widget>[
                      new Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      new Container(
                        width: 300.0,
                        child: new Text(
                          bikeBuddy,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                        ),
                      ),
                      new Container(
                        width: 300.0,
                        child: new Text(
                          desc,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      new Container(
                        width: 300.0,
                        child: new Text(
                          desc2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      new Container(
                        width: 300.0,
                        child: new Text(
                          pv,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                      ),
                      new Container(
                        width: 300.0,
                        child:new InkWell(
                            child: new Text(
                              link,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 15.0, color: Colors.blue),
                            ),
                            onTap: () {
                              launchURL();
                            },
                        )
                        
                        ),
                      new Container(
                        width: 300.0,
                        child: new Text(
                          moreinfo,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                       new Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                    ]
                  ),
                  onTap: (){},
                )
              ),
              ),
              
            ]
          )
        ]
      ),
    );
  }


}