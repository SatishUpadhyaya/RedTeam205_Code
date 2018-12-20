
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:test/test.dart';
import 'package:bikebuddy/main.dart';
import '../lib/hubComp/Pages/hub.dart';
import '../lib/landingComp/Pages/login.dart';

import '../lib/landingComp/Pages/signUp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';





// rudimentary implementation of the fixname bike test function.
int fixNameTest(status){

  if(status == "armed"){
    return 1;
  }
  else if(status == "disarmed"){
    return 0;
  }
  else if (status == "stolen"){
    return 2;
  }
  else{
    return 3;
  }

    
}


Future<dynamic> putBikeStateTest(var token) async {
  // print("Got:" + tokenMane["token"].toString());
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
      print("Things are looking good!");
    }
    else{
      print("Something went wrong, your request did not succeed. Try again.");
    }
    return secondRep.statusCode;
  }
  // later have code for other states.

// function to switch the lock

int switchLockTest(lockedNum){
  if(lockedNum == 3){
    lockedNum = 0;
  }
  else if(lockedNum == 1){
    lockedNum = 0;
  }
  else if(lockedNum == 0){
    lockedNum = 1;
  }
  return lockedNum;
    
}



// posts for a login request 

Future<dynamic> getPost(dynamic name, dynamic password) async
{
  var bodyText = {"username": name.toString(),"password": password.toString()};
  // var bodyTextJson = json.encode(bodyText);

  final res = await http.post('https://bikebuddy.udana.systems/api/login', body: bodyText,);

  var resDecode = json.decode(res.body);
  print("JWT TOKEN BELOW:");
  print(resDecode);
  print("RES CODE BELOW:");
  print("${res.statusCode}");
  return res.statusCode;
}





Future<dynamic> signInPost(dynamic name, dynamic password, dynamic email, dynamic bikeName) async
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

  // posts the email to the create account page
  final res = await http.post('https://bikebuddy.udana.systems/api/createacc', body: bodyText);

  if(res.statusCode == 200 && !(invalidEmail))
  {
    return 1;
    // success
    // if there's a good response and the email is valid
    // only will add bike here
  }
  else if(res.statusCode != 200 || failed)
  {
    // either response code is bad or there was no input there\
    // failure in some way
    return 0;
  }
}

void main(){

  // initial test
  test('First unit test', () {
      expect(1, 1);
      // initial testing test 
    });

  // number check, common sense check

  test('A common sense check.', () {
    var answer = 42;
    expect(answer, 42);
  });


// testing different inputs for the login function.
  test('Testing out the login function', (){
    Future<dynamic> reception = getPost("poopyBoy", "123");
    reception.then((value) => 
    expect(value, 404))
    .catchError((e) => print(e.toString() + " was the error."));

    Future<dynamic> reception1 = getPost("satish", "khanal2845");
    reception.then((value) => 
    expect(value, 200))
    .catchError((e) => print(e.toString() + " was the error."));

    Future<dynamic> reception2 = getPost("lol", "joe");
    reception.then((value) => 
    expect(value, 404))
    .catchError((e) => print(e.toString() + " was the error."));

    Future<dynamic> reception3 = getPost("satish1", "khanal28451");
    reception.then((value) => 
    expect(value, 404))
    .catchError((e) => print(e.toString() + " was the error."));

  });


/// testing out different inputs for the sign up function
  test('Testing out the sign up function', (){
    Future<dynamic> result = signInPost("Matthew", "002", "matthew.h.strong@gmail.com", "The Punisher");
    result.then((value) =>
    expect(value, 1)
    )
    .catchError((e) => print(e.toString() + " was the error."));

    Future<dynamic> result1 = signInPost("Matthew", "002", "phony@", "The Finisher");
    result.then((value) =>
    expect(value, 0)
    )
    .catchError((e) => print(e.toString() + " was the error."));

    Future<dynamic> result2 = signInPost("babyJoe", "012", "phony@colorado.edu", "The Beaster and Feaster");
    result.then((value) =>
    expect(value, 1)
    )
    .catchError((e) => print(e.toString() + " was the error."));

    Future<dynamic> result3 = signInPost("satish", "909", "phony@colorado.edu", "The Beaster and Feaster");
    result.then((value) =>
    expect(value, 0)
    )
    .catchError((e) => print(e.toString() + " was the error."));

  });

// testing the lock function

  test('Switching the lock tests', () {
    // 3 0 
    // 1 0 
    // 0 1
      int first = switchLockTest(0);
      expect(first, 1);

      int another = switchLockTest(3);
      expect(another, 0);

      int third = switchLockTest(1);
      expect(third, 0);
      // initial testing test 
    });

  test('Testing the Put Bike State', (){

    Future<dynamic> result = putBikeStateTest("1232jkkdjkfdfds9fsd9");
    result.then((value) =>
    expect(value, 400)
    )
    .catchError((e) => print(e.toString() + " was the error."));


    Future<dynamic> result1 = putBikeStateTest("1232jkkdjkfdfds9fsd9dsa");
    result.then((value) =>
    expect(value, 200)
    )
    .catchError((e) => print(e.toString() + " was the error."));


  });


// testing the lock functionality function
  test('Testing the Switching Numbers Function', (){

    int armedSwitch = fixNameTest("armed");

    expect(armedSwitch, 1);


    int disArmedSwitch = fixNameTest("disarmed");

    expect(disArmedSwitch, 0);

    int stolenSwitch = fixNameTest("stolen");

    expect(stolenSwitch, 2);

    int unknownSwitch = fixNameTest("unkown");

    expect(unknownSwitch, 3);

  });


}


