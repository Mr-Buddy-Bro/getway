
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/encrypt.dart';
import 'package:getway/my_colors.dart';
import 'package:getway/network_calls/profilecall.dart';
import 'package:getway/register.dart';
import 'package:getway/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final email_controller = TextEditingController();
  final pass_controller = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: 50,),
              Image.asset('assets/img/logo.png', height: 130,),
              if(loading)Lottie.asset('assets/lottie/loading.json', height: 50)else SizedBox(height: 50,),
              Text('Login', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              Text('Use your\ncredentials to login to your account', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
              SizedBox(height:35,),
              InputText(hint: 'Username/Email id', icon: Icon(Icons.person), controller : email_controller),
              SizedBox(height: 10,),
              InputText(hint: 'Password', icon: Icon(Icons.key_rounded), pass: true, controller: pass_controller,),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                child: LinkText(text: 'Forgot password?', size: 16,)
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  // Navigator.pushReplacement(context, PageTransition(child: HomeScreen(), type: PageTransitionType.bottomToTop));
                  _signIn();
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
                child: Text('SKIP',textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: MyColors().secondary, decoration: TextDecoration.underline),)
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
  
  void _signIn() {
    final emailOrUsername = email_controller.text.trim();
    final passsword = pass_controller.text.trim();

    if(emailOrUsername.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: MySnackBar(msg: 'Invalid email/username'))
      );
    }else if(passsword.isEmpty){
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: MySnackBar(msg: 'Please enter your password'))
      );
    }else{
      setState(() {
        loading = true;
      });
      //sign in
      if(emailOrUsername.contains('@')){
        _signInWithEmailAndPass(emailOrUsername, passsword);
      }else{
        //get email from database for the username
        _getEmailFromUsername(emailOrUsername, passsword);
      }
    }

    
  }
  
  Future _signInWithEmailAndPass(String email, String pass) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
      final _user = await ProfileCall().getUser(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => HomeScreen(user: _user,))));
      setState(() {
        loading = false;
      });
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: MySnackBar(msg: 'Invalid credentials'))
      );
      setState(() {
        loading = false;
      });
      
    }
    
  }
  
  _getEmailFromUsername(String emailOrUsername, String passsword) async {
    final ref = FirebaseFirestore.instance.collection('Users').get().then((snapshot){
      snapshot.docs.forEach((element) { 
        if(element.id == MyEncrypter().encrypt(emailOrUsername)){
          final _email = MyEncrypter().decrypt(element['email'].toString());
          print(_email);
          _signInWithEmailAndPass(_email, passsword);
        }
      });
      setState(() {
        loading = false;
      });
    });
  }

  
}

