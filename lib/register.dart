import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/data_models/user.dart';
import 'package:getway/encrypt.dart';
import 'package:getway/home.dart';
import 'package:getway/widgets.dart';
import 'package:page_transition/page_transition.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  late UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[150],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 80,),
                Image.asset('assets/img/logo.png', height: 40,),
                SizedBox(height: 20,),
                Text('Hi,\nCreate a free account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                SizedBox(height: 15,),
                Text('Create your own account\nfor free to continue. Explore institution without any\nrestrictions. ', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
                SizedBox(height:35,),
                InputText(hint: 'Enter your first name', icon: Icon(Icons.label), controller: fnameController,),
                SizedBox(height: 10,),
                InputText(hint: 'Enter your last name', icon: Icon(Icons.label), controller: lnameController),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    final fname = fnameController.text.trim();
                    final lname = lnameController.text.trim();
                    if(fname.isNotEmpty && lname.isNotEmpty){
                      user = UserModel(fname, lname, '', '', '', '');
                      Navigator.push(context, PageTransition(child: RegisterScreen2(user: user,), type: PageTransitionType.rightToLeft));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Please enter you first name and last name')));
                    }
                  },
                  child: PrimaryButton(text: 'Next',)
                ),
                SizedBox(height: 15,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: LinkText(text: 'Already have an account? Login')
                  ),
                SizedBox(height: 30,),
                LinkText(text: 'Privacy policy'),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterScreen2 extends StatefulWidget {
  final UserModel user;
  const RegisterScreen2({required this.user, super.key});

  @override
  State<RegisterScreen2> createState() => _RegisterScreen2State(user);
}

class _RegisterScreen2State extends State<RegisterScreen2> {
  final UserModel _user;
  final email_controller = TextEditingController();
  final username_controller = TextEditingController();
  
  _RegisterScreen2State(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[150],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 80,),
                Image.asset('assets/img/logo.png', height: 40,),
                SizedBox(height: 20,),
                Text('Good job,\nchoose an email and username', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                SizedBox(height: 15,),
                Text('Enter an email address\nand a username to access your account later. ', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
                SizedBox(height:35,),
                InputText(hint: 'Enter your email address', icon: Icon(Icons.email_rounded), email: true, controller: email_controller),
                SizedBox(height: 10,),
                InputText(hint: 'Enter a username', icon: Icon(Icons.person), controller: username_controller,),
                SizedBox(height: 10,),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    final email = email_controller.text.toLowerCase().trim();
                    final username = username_controller.text.toLowerCase().trim();
                    if(email.isNotEmpty && username.isNotEmpty){
                      final user = UserModel(_user.firstName, _user.lastName, email, username, '', '');
                      Navigator.push(context, PageTransition(child: RegisterScreen3(user: user), type: PageTransitionType.rightToLeft));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Please enter you email and username')));
                    }
                  },
                  child: PrimaryButton(text: 'Next',)
                ),
                SizedBox(height: 15,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: LinkText(text: 'Go back')
                  ),
                SizedBox(height: 20,),
                LinkText(text: 'Privacy policy'),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterScreen3 extends StatefulWidget {
  final UserModel user;
  const RegisterScreen3({super.key, required this.user});

  @override
  State<RegisterScreen3> createState() => _RegisterScreen3State(user);
}

class _RegisterScreen3State extends State<RegisterScreen3> {
  final UserModel _user;
  final passController = TextEditingController();
  final rePassController = TextEditingController();

  _RegisterScreen3State(this._user);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[150],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 80,),
                Image.asset('assets/img/logo.png', height: 40,),
                SizedBox(height: 20,),
                Text('Great,\nSecure your account with a strong password', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                SizedBox(height: 15,),
                Text('Enter an email address\nand a username to access your account later. ', textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
                SizedBox(height:35,),
                InputText(hint: 'Enter a password', icon: Icon(Icons.key_rounded), pass: true, controller: passController,),
                SizedBox(height: 10,),
                InputText(hint: 'Confirm password', icon: Icon(Icons.key_rounded), controller: rePassController,),
                SizedBox(height: 10,),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    final pass = passController.text.trim();
                    final rePass = rePassController.text.trim();
                    if(pass.length > 6 && rePass.isNotEmpty){
                      if(pass == rePass){
                        final user = UserModel(_user.firstName, _user.lastName, _user.email, _user.username, pass, '');
                        _signUp(user);
                      }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Password do not match')));
                      } 
                      // Navigator.push(context, PageTransition(child: RegisterScreen3(user: _user), type: PageTransitionType.rightToLeft));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Not a valid password')));
                    }
                  },
                  child: PrimaryButton(text: 'Continue',)
                ),
                SizedBox(height: 15,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: LinkText(text: 'Go back')
                  ),
                SizedBox(height: 20,),
                LinkText(text: 'Privacy policy'),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Future _signUp(UserModel user) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Please wait...')));
    late final UserModel f_user;
    
    try{
      f_user = UserModel(MyEncrypter().encrypt(user.firstName), MyEncrypter().encrypt(user.lastName),
       MyEncrypter().encrypt(user.email), MyEncrypter().encrypt(user.username), MyEncrypter().encrypt(user.password), '');
      
      print(f_user.toJson());
      await FirebaseFirestore.instance.collection('Users').doc(f_user.username).set(f_user.toJson());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password: user.password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => HomeScreen())));
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Try another username')));
      print(e);
    }
    
  }
}

