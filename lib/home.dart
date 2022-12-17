import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/data_models/user.dart';
import 'package:getway/encrypt.dart';
import 'package:getway/institutiondetails.dart';
import 'package:getway/menubar.dart';
import 'package:getway/widgets.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  UserModel? user = null;
  final f_user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
    
  }

  @override
  Widget build(BuildContext context) {
    if(user != null){
      print(user!.firstName);
    }
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color : Colors.white70,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              showDialog(context: context, builder: ((context) => MyAalert()));
                            },
                            child: Icon(Icons.exit_to_app_rounded, size: 25, color: Color.fromARGB(172, 0, 0, 0),)
                          ),
                          Image.asset('assets/img/logo.png', scale: 8.0,),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MenuBar(user : user)));
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new AssetImage(
                                          'assets/img/profile.png')
                                  )
                              )),
                          ),
                        ],
                      ),
                    ),
                    Text('Get Way', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    SizedBox(height: 60,),
                  ],
                ),
              ),
              InfoCard() //for signed user
              // BannerCard() // for signout
            ],
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal :20.0,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputText(hint: 'Search Institutions, building etc.', icon: Icon(Icons.search),),
                SizedBox(height: 20,),
                TitleText(text: 'Top Institutions',),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
                  height: 180,
                  child: PageView.builder(
                    controller: PageController(viewportFraction: MediaQuery.of(context).size.width > 600?0.8:0.9),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => InstDetails()));
                        },
                        child: TopInstCard(name: 'Naipunnya institute of management and information technology', )
                      );
                    },
                    physics: BouncingScrollPhysics(),
                    
                  ),
          ),
          SizedBox(height:10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TitleText(text: 'Nearby',),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600?4:2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 10
              ),
              itemCount: 10,
              primary: false,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => InstDetails()));
                  },
                  child: NearbyInstCard(text: 'Tite ${index+1} goes here',)
                );
              },
            ),
          )
        ],
      ),
    );
  }
  
  Future _getUser() async{
    late String email;
    late String username;
    late String firstname;
    late String lastname;
    late String password;
    try{
      await FirebaseFirestore.instance.collection('Users').get().then((snapshot) {
            snapshot.docs.forEach((element) {
              email = MyEncrypter().decrypt(element.data()['email'].toString());
              username = MyEncrypter().decrypt(element.data()['username'].toString());
              firstname = MyEncrypter().decrypt(element.data()['firstname'].toString());
              lastname = MyEncrypter().decrypt(element.data()['lastname'].toString());
              password = MyEncrypter().decrypt(element.data()['password'].toString());
              if(f_user!.email == email){
                setState(() {
                  user = UserModel(firstname, lastname, email, username, password);
                });
              }
            });
            
          });
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'errorr : $e')));
    }
    
  }
}