import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:getway/login.dart';
import 'package:getway/main_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/services.dart';

import 'home.dart';
import 'my_colors.dart';
import 'network_calls/profilecall.dart';

Future main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: MyColors().primary,
    statusBarIconBrightness: Brightness.light
  ));
  runApp(const MyApp());
}

Color brandColor = MyColors().primary;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? light, ColorScheme? dark) {

       ColorScheme lightDynamicScheme;
       ColorScheme darkDynamicScheme;

       if(light != null && dark != null){
        lightDynamicScheme = light.harmonized()..copyWith();
        lightDynamicScheme = lightDynamicScheme.copyWith(secondary: brandColor);
        darkDynamicScheme = dark.harmonized()..copyWith();
        darkDynamicScheme = darkDynamicScheme.copyWith(secondary: brandColor);

       }else{
        lightDynamicScheme = ColorScheme.fromSeed(seedColor: brandColor);
        darkDynamicScheme = ColorScheme.fromSeed(seedColor: brandColor, brightness: Brightness.dark);
       }

        return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Roboto',
            useMaterial3: true,
            colorScheme: lightDynamicScheme,
          ),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      }
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
    checkUser();
    
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
            child: Image.asset('assets/img/logo_light.png', width: 250,),
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

  Future checkUser() async{
    final user = await FirebaseAuth.instance.currentUser;
      Timer(Duration(seconds: 1),() {
        if(user != null){
          getUser();
        }else{
          Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.bottomToTop, child: LoginScreen()));
        }
      });
    }
    
      getUser()async {
        final muser = await ProfileCall().getUser(context);
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => HomeScreen(user : muser))));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => MainScreen(user: muser,))));
      }
}