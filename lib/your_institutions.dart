
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/add_inst.dart';
import 'package:getway/data_models/institution.dart';
import 'package:getway/data_models/user.dart';
import 'package:getway/edit_inst.dart';
import 'package:getway/widgets.dart';

import 'institutiondetails.dart';

class YourInstitutions extends StatefulWidget {
  UserModel? user;
  YourInstitutions({super.key, this.user});

  @override
  State<YourInstitutions> createState() => _YourInstitutionsState(user);
}

class _YourInstitutionsState extends State<YourInstitutions> {
  UserModel? user;
  _YourInstitutionsState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20,), bottomRight: Radius.circular(20))
            ),
            child: TitleBar(title: 'Your Institutions',),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(text: 'Institutions you added'),
                GestureDetector(
                  onTap: () {
                    
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text((Random().nextInt(12).toString())))
                    //   );
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => AddInstitution(user : user))));
                  },
                  child: PrimaryButton(text: 'Add +', mini: true,)
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
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

                  final inst = InstitutionModel(displayName, desc, hoi, 
                  contactNo, shortName, landmark, city, district, pincode, 
                  username, photoUrl);
                  if(inst.username == user!.username)
                  institutions.add(inst);
                }
                return institutions.length > 0? GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 600?4:2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 8,
                    childAspectRatio: .8
                  ),
                  itemCount: institutions.length,
                  itemBuilder: (context, index) {                    
                    return NearbyInstCard(text: institutions[index].displayName, photoUrl: institutions[index].photoUrl,);
                  },
                ):DescText(text: 'You haven\'t added any Institutions yet', alignCenter: true,);
              }),
              
            ),
            
          ),
          SizedBox(height: 20,),
          DescText(text: 'Click on Add+\nbutton to add an Institution', alignCenter: true,)
        ],
      ),
    );
  }
  
  
 
}