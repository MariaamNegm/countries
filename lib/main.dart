import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

      ),
      debugShowCheckedModeBanner: false ,
      home:AnimatedSplashScreen(
        duration: 4000,
        splash: Image.asset("images/splash.jpg",width:double.infinity, fit:BoxFit.cover,),
        nextScreen:HomeScreen(),
        //calling the page which have the tab bar view as next screen
        splashIconSize:double.infinity,
        //make the icon to cover all space around
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor:Colors.black87,
      )
    );
  }
}

