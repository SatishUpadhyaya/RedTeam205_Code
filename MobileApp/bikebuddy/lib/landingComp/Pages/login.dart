// placeholder
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class LoginPage extends StatefulWidget{
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{

  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;
  String userName = "";
  String userPassword = "";






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
      body: new Stack(
        // alignment: AlignmentDirectional.center,
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
                      new Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                      ),
                      new MaterialButton(
                        height: 30.0,
                        minWidth: 225.0,
                        color: Colors.black,
                        textColor: Colors.white,
                        
                          // child: new Icon(Icons.arrow_right),
                          child: new Text("Login",
                            style: new TextStyle(
                            fontSize: 18.0,
                          ),),
                        onPressed: () {
                          // function to post user credentials to API
                          //getPost(context, userCompany.toString(), userPassword.toString());
                        },
                        splashColor: Colors.black,
                      ),

                      new Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                      ),

                      
                      new Container(
                        child: new InkWell(
                        child: new Text("Forgot Username or Password?",
                        style: new TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        )),
                        onTap: () {},
                        ),
                        
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


}// placeholder