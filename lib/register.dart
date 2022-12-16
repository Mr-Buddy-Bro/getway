import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/widgets.dart';
import 'package:page_transition/page_transition.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                InputText(hint: 'Enter your first name', icon: Icon(Icons.label)),
                SizedBox(height: 10,),
                InputText(hint: 'Enter your last name', icon: Icon(Icons.label),),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, PageTransition(child: RegisterScreen2(), type: PageTransitionType.rightToLeft));
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
  const RegisterScreen2({super.key});

  @override
  State<RegisterScreen2> createState() => _RegisterScreen2State();
}

class _RegisterScreen2State extends State<RegisterScreen2> {
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
                InputText(hint: 'Enter your email address', icon: Icon(Icons.email_rounded), email: true),
                SizedBox(height: 10,),
                InputText(hint: 'Enter a username', icon: Icon(Icons.person),),
                SizedBox(height: 10,),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, PageTransition(child: RegisterScreen3(), type: PageTransitionType.rightToLeft));
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
  const RegisterScreen3({super.key});

  @override
  State<RegisterScreen3> createState() => _RegisterScreen3State();
}

class _RegisterScreen3State extends State<RegisterScreen3> {
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
                InputText(hint: 'Enter a password', icon: Icon(Icons.key_rounded), pass: true,),
                SizedBox(height: 10,),
                InputText(hint: 'Confirm password', icon: Icon(Icons.key_rounded)),
                SizedBox(height: 10,),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    // Navigator.push(context, PageTransition(child: RegisterScreen3(), type: PageTransitionType.rightToLeft));
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
}

