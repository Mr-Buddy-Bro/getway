import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/register.dart';
import 'package:getway/widgets.dart';
import 'package:page_transition/page_transition.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: 10,),
              Image.asset('assets/img/logo.png', scale: 4,),
              SizedBox(height: 20,),
              Text('Login', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              Text('Use your\ncredentials to login to your account', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
              SizedBox(height:35,),
              InputText(hint: 'Username/Email id', icon: Icon(Icons.person),),
              SizedBox(height: 10,),
              InputText(hint: 'Password', icon: Icon(Icons.key_rounded), pass: true),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                child: LinkText(text: 'Forgot password?', size: 16,)
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  // Navigator.pushReplacement(context, PageTransition(child: HomeScreen(), type: PageTransitionType.bottomToTop));
                },
                child: PrimaryButton(text: 'Login',)
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, PageTransition(child: RegisterScreen(), type: PageTransitionType.topToBottom));
                },
                child: Center(child: LinkText(text: 'Do not have an account? Create new'))
                ),
              SizedBox(height: 50,),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, PageTransition(child: HomeScreen(), type: PageTransitionType.bottomToTop));
                },
                child: Text('SKIP',textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54, decoration: TextDecoration.underline),)
              ),
              SizedBox(height: 50,),
              Center(child: LinkText(text: 'Privacy policy')),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}

