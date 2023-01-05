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
import 'package:getway/network_calls/profilecall.dart';
import 'package:getway/widgets.dart';
import 'package:page_transition/page_transition.dart';

import 'data_models/institution.dart';
import 'my_colors.dart';

class HomeScreen extends StatefulWidget {
  UserModel? user;
  HomeScreen({super.key, this.user=null});

  @override
  State<HomeScreen> createState() => _HomeScreenState(user);
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? user;
  List<InstitutionModel> institutions = [];
  final searchTextController = TextEditingController();
  User? f_user = FirebaseAuth.instance.currentUser;
  
  _HomeScreenState(this.user);
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    if(f_user != null){
      _getUser();
    }
    
  }

  @override
  Widget build(BuildContext context) {

    searchTextController.addListener((() {
        searchInst(searchTextController.text.trim());
    }));
     
   
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 251, 249),
      body: StreamBuilder(
        stream: user != null? FirebaseFirestore.instance.collection('Users').doc(MyEncrypter().encrypt(user!.username)).snapshots():null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var photoUrl = '';
          if(snapshot.hasData) {
            photoUrl = user != null?snapshot.data['photoUrl']:'';
          }
          return ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(16, 158, 158, 158),
                                blurRadius: 3,
                                spreadRadius: .3,
                                offset: Offset(0, 5)
                              ),
                              
                            ],
                        color: MyColors().primary,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: ((context) => MyAalert()));
                                  },
                                  child: Icon(
                                    Icons.exit_to_app_rounded,
                                    size: 25,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  )),
                              Image.asset(
                                'assets/img/logo_white.png',
                                width: 50,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MenuBar(user: user,)));
                                },
                                child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            image: new NetworkImage(
                                                photoUrl.length > 0? photoUrl:'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg')))),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Get Way',
                          style:
                              TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                  // InfoCard() //for signed user
                  // user != null?InfoCard():BannerCard()
                  BannerCard()
                  // BannerCard() // for signout
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: InputText(
                            hint: 'Search Institutions, building etc.',
                            icon: Icon(Icons.search, color: MyColors().primary,),
                            controller: searchTextController,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: MyColors().shadow,
                                blurRadius: 3,
                                spreadRadius: .3,
                                offset: Offset(0, 3)
                              ),
                              
                            ],
                            borderRadius: BorderRadius.circular(15)
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        institutions.length > 0? Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: institutions.length,
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: ((context) => InstDetails(institutions[index]))));
                                    },
                                    child: ListTile(tileColor: Colors.grey[200],shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), title: Text(institutions[index].displayName + " - "+institutions[index].shortName),)
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 20,),
                          ],
                        ):SizedBox(),
                        
                        TitleText(
                          text: 'Top Institutions',
                        ),
                      ],
                    ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Institution').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(!snapshot.hasData) return Loading();
                      List<InstitutionModel> institutions = [];
                      DocumentSnapshot doc;
                      for(doc in snapshot.data.docs){
                        final displayName = doc['displayName'];
                        final desc = doc['description'];
                        final hoi = doc['hoi'];
                        final contactNo = doc['contactNo'];
                        final shortName = doc['shortName'];
                        final landmark = doc['landmark'];
                        final city = doc['city'];
                        final district = doc['district'];
                        final pincode = doc['pincode'];
                        final username = doc['username'];
                        final photoUrl = doc['photoUrl'];
                        final docId = doc['docId'];
      
                        final inst = InstitutionModel(displayName, desc, hoi, 
                        contactNo, shortName, landmark, city, district, pincode, 
                        username, photoUrl, docId);
                        // if(inst.username == user!.username)
                        institutions.add(inst);
                      }
                    
                    return Container(
                      height: 180,
                      child: PageView.builder(
                        controller: PageController(
                            viewportFraction:
                                MediaQuery.of(context).size.width > 600 ? 0.8 : 0.9),
                        itemCount: institutions.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InstDetails(institutions[index], user: user)));
                              },
                              child: TopInstCard(
                                name: institutions[index].displayName,
                                image: institutions[index].photoUrl
                              ));
                        },
                        physics: BouncingScrollPhysics(),
                      ),
                    );
                  }
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TitleText(
                  text: 'Nearby',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Institution').snapshots(),
                  builder: ((BuildContext context, AsyncSnapshot snapshot) {
                    if(!snapshot.hasData) return Text('Loading');
                    List<InstitutionModel> institutions = [];
                    DocumentSnapshot doc;
                    for(doc in snapshot.data.docs){
                      final displayName = doc['displayName'];
                      final desc = doc['description'];
                      final hoi = doc['hoi'];
                      final contactNo = doc['contactNo'];
                      final shortName = doc['shortName'];
                      final landmark = doc['landmark'];
                      final city = doc['city'];
                      final district = doc['district'];
                      final pincode = doc['pincode'];
                      final username = doc['username'];
                      final photoUrl = doc['photoUrl'];
                      final docId = doc['docId'];
      
                      final inst = InstitutionModel(displayName, desc, hoi, 
                      contactNo, shortName, landmark, city, district, pincode, 
                      username, photoUrl, docId);
                      // if(inst.username == user!.username)
                      institutions.add(inst);
                    }
                    institutions.sort((a, b) => a.pincode.compareTo(b.pincode),);
                    return GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).size.width > 600?4:2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 8,
                        childAspectRatio: .8
                      ),
                      itemCount: institutions.length,
                      itemBuilder: (context, index) {                    
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: ((context) => InstDetails(institutions[index], user: user))));
                          },
                          child: NearbyInstCard(text: institutions[index].displayName, photoUrl: institutions[index].photoUrl,)
                        );
                      },
                    );
                  }),
                  
                ),
              )
            ],
          );
        }
      ),
    );
  }
  
  _getUser() async{
    final muser = f_user != null? await ProfileCall().getUser(context):null;
    setState(() {
      user = muser;
    });
  }
  
  searchInst(String text)async{
    if(text.length < 2){
       setState(() {
           institutions.clear();
        });
    }else{
    List<InstitutionModel> _institution = [];
    await FirebaseFirestore.instance.collection('Institution').get().then((snapshot) {
      snapshot.docs.forEach((element) {
        final String instName = element.data()['displayName'].toString().toLowerCase();
        print(text);
        if(instName.contains(text.toLowerCase())){
          final String displayName = element.data()['displayName'].toString();
          final String description = element.data()['description'].toString();
          final String hoi = element.data()['hoi'].toString();
          final String contactNo = element.data()['contactNo'].toString();
          final String shortName = element.data()['shortName'].toString();
          final String landmark = element.data()['landmark'].toString();
          final String city = element.data()['city'].toString();
          final String district = element.data()['district'].toString();
          final String pincode = element.data()['pincode'].toString();
          final String username = element.data()['username'].toString();
          final String photoUrl = element.data()['photoUrl'].toString();
          final String docId = element.data()['docId'].toString();
          final inst = InstitutionModel(displayName, description, hoi, contactNo, shortName, landmark, city, 
                        district, pincode, username, photoUrl, docId);
          _institution.add(inst);
         
        }
      });
    });
    
    
    setState(() {
      institutions = _institution;
      
    });
    }
  }
}
