import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/data_models/user.dart';
import 'package:getway/encrypt.dart';
import 'package:getway/institutiondetails.dart';
import 'package:getway/widgets.dart';

import 'data_models/institution.dart';

class RecentVisitScreen extends StatefulWidget {
  final UserModel? user;
  const RecentVisitScreen({super.key, this.user});

  @override
  State<RecentVisitScreen> createState() => _RecentVisitScreenState();
}

class _RecentVisitScreenState extends State<RecentVisitScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Users').doc(MyEncrypter().encrypt(widget.user!.username)).collection('RecentVisits').snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
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
            return ListView(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20,), bottomRight: Radius.circular(20))
                  ),
                  child: TitleBar(title: 'Recent visits',),
                ),
                SizedBox(height: 30,),
                DescText(text: 'Your visits in the last 30 days', alignCenter: true,),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(text: 'Institutions'),
                      SizedBox(height: 10,),
                      institutions.isEmpty? Container(width: double.infinity, child: DescText(text: 'No recent visits', alignCenter: true,)):
                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: institutions.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction)async {
                              await FirebaseFirestore.instance.collection('Users').doc(MyEncrypter().encrypt(widget.user!.username))
                              .collection('RecentVisits').doc(institutions[index].username+institutions[index].shortName).delete();
                              
                              ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: MySnackBar(msg: 'Removed')));
                              
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: ((context) => InstDetails(institutions[index]))));
                                },
                                child: InstCard(institutions[index])
                              )
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
    );
  }
}