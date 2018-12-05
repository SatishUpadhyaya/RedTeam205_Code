import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import './login.dart';

Future<void> getPost(BuildContext context, dynamic name, dynamic password, dynamic email) async
{
  var bodyText = {"username":name.toString(),"password":password.toString(),"email":email.toString()};

  final res = await http.post('https://bikebuddy.udana.systems/api/createacc', body: bodyText,);

  if(res.statusCode == 200)
  {
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
  else
  {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Sign Up Attempt Failed!'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Invalid Username, Password, or Email'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Try Again'),
              onPressed: () {
                Navigator.of(context).pop();
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
                        child: new TextField(
                          decoration: new InputDecoration(
                            labelText: "Email",
                          ),
                          onChanged: (String inEmail){
                            setState((){
                              userEmail = inEmail;
                            });
                          },
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 25.0),
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
                          getPost(context, userName.toString(), userPassword.toString(), userEmail.toString());
                        },
                        splashColor: Colors.black,
                      ),

                      new Padding(
                        padding: const EdgeInsets.only(top: 25.0),
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