// This is a basic Flutter widget test.
// using it for bike buddy
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

//User	Acceptance	Test	
//Plans
//Create	a	document	that	describes	how	at	least	three features within	your	
//finished	product	will	be	tested.		The	test	plan	should	include	specific	test	
// (user	acceptance	test	cases) that	describe	the	data	and	the	user	
//activity	that	will	be	executed	in	order	to	verify	proper	functionality	of	the	
//feature.
//Automated	Test	Cases Provide	a	link	to	the	tool	you	use	to	automate	testing,	or	explain	how	to	run	
//the	automated	test	cases	or	schedule	time	with	the	TAs	to	demonstrate	your	
//automated	tests.	 Provide	a	copy	of	the	output	showing	the	results	of	the	
//automated	test	cases	running.	

// test login
// sign in 
// change status



import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:test/test.dart';
import 'package:bikebuddy/main.dart';
import '../lib/hubComp/Pages/hub.dart';
void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  
}
