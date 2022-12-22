import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/data_models/user.dart';
import 'package:getway/login.dart';
import 'package:getway/privacy_policy.dart';
import 'package:getway/profile.dart';
import 'package:getway/recent_visits.dart';
import 'package:getway/widgets.dart';
import 'package:getway/your_institutions.dart';

import 'network_calls/profilecall.dart';

class MenuBar extends StatefulWidget {
  UserModel? user;
  MenuBar({super.key, this.user = null});

  @override
  State<MenuBar> createState() => _MenuBarState(user);
}

class _MenuBarState extends State<MenuBar> {
  UserModel? user;

  _MenuBarState(this.user);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
    // FirebaseFirestore.instance.collection('Users').
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 20,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                user == null
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => LoginScreen())))
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => ProfileScreen(user: user))));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: 90.0,
                          height: 90.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: new NetworkImage(user != null? user!
                                              .photoUrl.length >
                                          0
                                      ? user!.photoUrl
                                      : 'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg':'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg')))),
                      SizedBox(
                        height: 10,
                      ),
                      SpecButton(
                        text: user != null ? 'Profile' : 'Log In',
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          user != null
                              ? user!.username.toUpperCase()
                              : 'Username'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          user != null
                              ? user!.email
                              : 'name@example.com'.toLowerCase(),
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(218, 92, 182, 95))),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      user != null?
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    RecentVisitScreen(user: user)))):ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Please login first')));
                      },
                    child: SelectableMenuItem(
                      text: 'Recent visits',
                      icon: Icon(Icons.loop_rounded),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Color.fromARGB(58, 76, 175, 79),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        user != null?
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    YourInstitutions(user: user)))):ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Please login first')));
                      },
                      child: SelectableMenuItem(
                        text: 'Your institutions',
                        icon: Icon(Icons.house),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Color.fromARGB(58, 76, 175, 79),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    PrivacyPolicy())));
                    },
                    child: SelectableMenuItem(
                      text: 'Privacy policy',
                      icon: Icon(Icons.privacy_tip_rounded),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // SelectableMenuItem(text: 'Switch account', icon: Icon(Icons.repeat_rounded), arrow: false,),
                  // SizedBox(height: 40,),
                  GestureDetector(
                    onTap: (){
                      // Share.share('Join Get Way');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Feature will come soon')));
                    },
                    child: SelectableMenuItem(
                      text: 'Refer a friend',
                      icon: Icon(Icons.share_rounded),
                      arrow: false,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
            Text(
              'Notification',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(156, 0, 0, 0)),
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Common').doc('notification').snapshots(),
              builder: (BuildContext context,AsyncSnapshot snapshot) {
                return DescText(text: snapshot.data['text']);
              },
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  _getUser() async {
    final _user = await ProfileCall().getUser(context);
    setState(() {
      user = user;
    });
  }
}
