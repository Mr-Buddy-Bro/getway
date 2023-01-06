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
  HomeScreen({super.key, this.user = null});

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

    if (f_user != null) {
      _getUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    searchTextController.addListener((() {
      searchInst(searchTextController.text.trim());
    }));
    print(user!.photoUrl);
    final photoUrl = user!.photoUrl;

    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 248, 251, 249),
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Get Way'),
            Image.asset(
              'assets/img/logo.png',
              width: 40,
            ),
            
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            showDialog(context: context, builder:(context) {
              return AlertDialog(
                title: Text('Exit'),
                content: Text('Do you want to exit the app'),
                actions: [
                  OutlinedButton(
                    onPressed: (){
                      Navigator.pop(context);
                  }, 
                  child: Text('No')
                  ),
                  ElevatedButton(
                    onPressed: (){
                      exit(0);
                  }, 
                  child: Text('Exit')
                  )
                ],
              );
            },);
          },
          icon: Icon(Icons.exit_to_app)
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MenuBar(
                            user: user,
                          )));
            },
            child: Container(
                width: 40.0,
                height: 40.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: new NetworkImage(photoUrl.length > 0
                            ? photoUrl
                            : 'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg')))),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: StreamBuilder(
          stream: user != null
              ? FirebaseFirestore.instance
                  .collection('Users')
                  .doc(MyEncrypter().encrypt(user!.username))
                  .snapshots()
              : null,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var photoUrl = '';
            if (snapshot.hasData) {
              photoUrl = user != null ? snapshot.data['photoUrl'] : '';
            }
            return ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    onTap: () {
                      showSearch(
                          context: context, delegate: MySearchDelegate());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: MyColors().inputText
                          ),
                      child: Row(children: [
                        Icon(
                          Icons.search,
                        ),
                        SizedBox(width: 10,),
                        Text('Search Institutions, building etc.', style: TextStyle(fontSize: 18),)
                      ]),
                    ),
                  ),
                ),
                BannerCard(),
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
                      stream: FirebaseFirestore.instance
                          .collection('Institution')
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) return Loading();
                        List<InstitutionModel> institutions = [];
                        DocumentSnapshot doc;
                        for (doc in snapshot.data.docs) {
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

                          final inst = InstitutionModel(
                              displayName,
                              desc,
                              hoi,
                              contactNo,
                              shortName,
                              landmark,
                              city,
                              district,
                              pincode,
                              username,
                              photoUrl,
                              docId);
                          // if(inst.username == user!.username)
                          institutions.add(inst);
                        }

                        return Container(
                          height: 180,
                          child: PageView.builder(
                            controller: PageController(
                                viewportFraction:
                                    MediaQuery.of(context).size.width > 600
                                        ? 0.8
                                        : 0.9),
                            itemCount: institutions.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => InstDetails(
                                                institutions[index],
                                                user: user)));
                                  },
                                  child: TopInstCard(
                                      name: institutions[index].displayName,
                                      image: institutions[index].photoUrl));
                            },
                            physics: BouncingScrollPhysics(),
                          ),
                        );
                      }),
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
                    stream: FirebaseFirestore.instance
                        .collection('Institution')
                        .snapshots(),
                    builder: ((BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) return Text('Loading');
                      List<InstitutionModel> institutions = [];
                      DocumentSnapshot doc;
                      for (doc in snapshot.data.docs) {
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

                        final inst = InstitutionModel(
                            displayName,
                            desc,
                            hoi,
                            contactNo,
                            shortName,
                            landmark,
                            city,
                            district,
                            pincode,
                            username,
                            photoUrl,
                            docId);
                        // if(inst.username == user!.username)
                        institutions.add(inst);
                      }
                      institutions.sort(
                        (a, b) => a.pincode.compareTo(b.pincode),
                      );
                      return GridView.builder(
                        shrinkWrap: true,
                        primary: false,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                MediaQuery.of(context).size.width > 600 ? 4 : 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 8,
                            childAspectRatio: .8),
                        itemCount: institutions.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => InstDetails(
                                            institutions[index],
                                            user: user))));
                              },
                              child: NearbyInstCard(
                                text: institutions[index].displayName,
                                photoUrl: institutions[index].photoUrl,
                              ));
                        },
                      );
                    }),
                  ),
                )
              ],
            );
          }),
    );
  }

  _getUser() async {
    final muser = f_user != null ? await ProfileCall().getUser(context) : null;
    setState(() {
      user = muser;
    });
  }

  searchInst(String text) async {
    if (text.length < 2) {
      setState(() {
        institutions.clear();
      });
    } else {
      List<InstitutionModel> _institution = [];
      await FirebaseFirestore.instance
          .collection('Institution')
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((element) {
          final String instName =
              element.data()['displayName'].toString().toLowerCase();
          print(text);
          if (instName.contains(text.toLowerCase())) {
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
            final inst = InstitutionModel(
                displayName,
                description,
                hoi,
                contactNo,
                shortName,
                landmark,
                city,
                district,
                pincode,
                username,
                photoUrl,
                docId);
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

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else
              query = '';
          },
          icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> sug = [
      'Naipunnya Institute of Management and Information Technology',
      'Littile Flower Hospital, Angamaly'
    ];
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: sug.length,
            itemBuilder: ((context, index) {
              return ListTile(
                title: Text(
                  sug[index],
                  style: TextStyle(color: Colors.black54),
                ),
                subtitle: Text('College'),
                onTap: () {
                  query = sug[index];
                },
              );
            })),
      ],
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Container(),
    );
  }
}
