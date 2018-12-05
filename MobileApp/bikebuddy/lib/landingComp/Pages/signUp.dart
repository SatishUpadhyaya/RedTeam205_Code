import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import './login.dart';
import 'dart:convert';

Future<void> addBike(dynamic username, dynamic password, dynamic bikeName) async
{
    try
    {
      // adds a bike for the user
      var bodTx = {"username": username.toString(), "password": password.toString()};
      final res = await http.post('https://bikebuddy.udana.systems/api/login', body: bodTx);
      //Get the token
      if(res.statusCode == 200){
        var resDecode = json.decode(res.body);
        print("\""+resDecode["token"]+"\"");
        var header = {"Authorization":"Token "+resDecode["token"].toString(),
          "Accept": "application/json",
          "content-type": "application/json"};
        var body = json.encode({"Name": bikeName.toString()});
        print(body);
        //Add the bike
        final req = await http.post('https://bikebuddy.udana.systems/bikes/addBike', headers: header, body: body);
        print(json.decode(req.body));
      }
      else{
        print("Something went wrong...");
      }
     
    }
    catch(e)
    {
      print("Unable to add bike because of " + e.toString());
    }
}

Future<void> getPost(BuildContext context, dynamic name, dynamic password, dynamic email, dynamic bikeName) async
{
  // takes inputs from the user based on the 
  bool failed = false;
  bool invalidEmail = !(RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email.toString()));
  print(invalidEmail);
  // simple regex expression to look for correct form for emails.
  if(name == "" || password == "" || email == "" || bikeName == "" || invalidEmail){
    failed = true;
  }
  // can't add in an empty bike to the user's account!
  var bodyText = {"username":name.toString(),"password":password.toString(),"email":email.toString()};

  final res = await http.post('https://bikebuddy.udana.systems/api/createacc', body: bodyText);

  if(res.statusCode == 200 && !(invalidEmail))
  {
    // if there's a good response and the email is valid
    await addBike(name, password, bikeName);
    return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Success!'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('User account was successfully created'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Sign In'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => new LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }
  else if(res.statusCode != 200 || failed)
  {
    // either response code is bad or there was no input there
    return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Sign Up Attempt Failed!'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Error with Password, Email, and/or Username.'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Try Again'),
              onPressed: () {
                //Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => new SignUpPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class SignUpPage extends StatefulWidget{
  @override
  State createState() => new SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> with SingleTickerProviderStateMixin{

  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;
  String userName = "";
  String userPassword = "";
  String userEmail = "";
  String bikeName = "";

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
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Positioned(
              top: -300.0,
              child: new Image(
                image: new AssetImage("lib/images/loginImg.jpg"),
                fit: BoxFit.fill,
                color: Colors.black26,
                colorBlendMode: BlendMode.darken,
              ),
            ),

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
                padding: const EdgeInsets.only(bottom:30.0),
                width: 300.0,
              child: new Card(
                color: Colors.amber[200],
                child: InkWell(
                  splashColor: Colors.yellow,
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        width: 225.0,
                        height: 50.0,
                        child: new TextField(
                            decoration: new InputDecoration(
                              labelText: "Username",
                            ),
                            keyboardType: TextInputType.text,

                            onChanged: (String name){
                              setState(() {
                                userName = name;         
                              });
                            },
                          ),
                      ),
                      new Container(
                        width: 225.0,
                        height: 50.0,
                        child: new TextField(
                          decoration: new InputDecoration(
                            labelText: "Password",
                          ),
                          onChanged: (String inPassword){
                            setState((){
                              userPassword = inPassword;
                            });
                          },
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                      ),
                      new Container(
                        width: 225.0,
                        height: 50.0,
                        child: new TextField(
                          decoration: new InputDecoration(
                            labelText: "Email",
                          ),
                          onChanged: (String inEmail){
                            setState((){
                              userEmail = inEmail;
                            });
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      new Container(
                        width: 225.0,
                        height: 50.0,
                        child: new TextField(
                          decoration: new InputDecoration(
                            labelText: "New Bike Name",
                          ),
                          onChanged: (String inBikeName){
                            setState((){
                              bikeName = inBikeName;
                            });
                          },
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                      ),
                      new MaterialButton(
                        height: 30.0,
                        minWidth: 225.0,
                        color: Colors.black,
                        textColor: Colors.white,
                            child: new Text("Sign Up!",
                            style: new TextStyle(
                            fontSize: 18.0,
                          ),),
                        onPressed: () {
                          // function to post user credentials to API
                          getPost(context, userName.toString(), userPassword.toString(), userEmail.toString(), bikeName.toString());
                        },
                        splashColor: Colors.black,
                      ),

                      new Padding(
                        padding: const EdgeInsets.only(top: 18.0),
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