import 'dart:async';

import 'package:flutter/material.dart';
import 'package:getway/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.grey[100],
    statusBarIconBrightness: Brightness.dark
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), 
      () => Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.bottomToTop, child: LoginScreen()))
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 50, height: 100,),
          Center(
            child: Image.asset('assets/img/logo.png', width: 150,),
          ),
          Column(
            children: [
              Text('Powered by', style: TextStyle(fontSize: 16, color: Colors.black54),),
              Text('WideCity', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 57, 205, 62)),),
              SizedBox(height: 80,)
          ],
          )
          
        ],
      ),
    );
  }
}