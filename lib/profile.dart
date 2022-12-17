import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/data_models/user.dart';
import 'package:getway/login.dart';
import 'package:getway/widgets.dart';

class ProfileScreen extends StatefulWidget {
  UserModel? user;
  ProfileScreen({super.key, this.user = null});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState(user);
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? user;
  
  _ProfileScreenState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: [
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TitleBar(title: 'Profile'),
          ),
          SizedBox(height: 20,),
          CircleImage(image: AssetImage('assets/img/profile.png'), size: 140,),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${user!.firstName} ${user!.lastName}'.toUpperCase(), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              SizedBox(width: 10,),
              Icon(Icons.edit_note_rounded)
            ],
          ),
          SizedBox(height: 8,),
          LinkText(text: user!.email, size: 18,),
          SizedBox(height: 30,),
          TraceCard(keyName: 'Level', value: '1', bg: false,),
          // TraceCard(keyName: 'Mobile', value: '+91 8943194516', bg: false,),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  SelectableMenuItem(text: 'Help', icon: Icon(Icons.help_outline_rounded),),
                  SizedBox(height: 8,),
                  Divider(color: Color.fromARGB(48, 76, 175, 79),),
                  SizedBox(height: 8,),
                  SelectableMenuItem(text: 'Request account deletion', icon: Icon(Icons.no_accounts_rounded),),
                ],
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Container(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => LoginScreen())));
                },
                child: SpecButton(text: 'Sign out', warning: true,)
              )
            ),
          )
        ],
      ),
    );
  }
}