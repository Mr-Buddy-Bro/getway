import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/data_models/institution.dart';
import 'package:getway/data_models/user.dart';
import 'package:getway/encrypt.dart';
import 'package:getway/way.dart';
import 'package:getway/widgets.dart';
import 'package:page_transition/page_transition.dart';

class InstDetails extends StatefulWidget {
  InstitutionModel? inst;
  UserModel? user;
  InstDetails(this.inst, {super.key, this.user});
  

  @override
  State<InstDetails> createState() => _InstDetailsState(inst, user);
}

class _InstDetailsState extends State<InstDetails> {
  InstitutionModel? inst;
  UserModel? user;
  User? f_user = FirebaseAuth.instance.currentUser;
  _InstDetailsState(this.inst, this.user);
  

  @override
  Widget build(BuildContext context) {
    _addToRecent(inst);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Stack(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color : Colors.white70,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                      child: TitleBar(title: 'Instituttion details',)
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color.fromARGB(11, 0, 0, 0),
                      blurRadius: 5,
                      spreadRadius: 1
                    )
                  ],
                  borderRadius: BorderRadius.circular(15)
                ),
                margin: EdgeInsets.only(left: 20, right: 20, top: 80),
                child: InputText(hint: 'find the zone', icon: Icon(Icons.search_rounded),)
              )
            ],
          ),
          SizedBox(height: 15,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InstCard(inst!),
                  SizedBox(height: 20,),
                  TitleText(text: 'More Details'),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DivCard(image: Image.asset('assets/img/skyscraper.png', scale: 6,), count: 3, label: 'No. of blocks',),
                      DivCard(image: Image.asset('assets/img/living-room.png', scale: 6,), count: 12, label: 'No. of roomss',),
                    ],
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => WayScreen())));
                    },
                    child: SpecButton(text: 'Demo')
                  ),
                  SizedBox(height: 20,),
                  TitleText(text: 'Description'),
                  SizedBox(height: 15,),
                  DescText(text: inst!.description,),
                  SizedBox(height: 25,),
                  Text('Head of the Institution', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8,),
                  Text(inst!.hoi, style: TextStyle(fontSize: 18, color: Colors.black54),),
                  SizedBox(height: 25,),
                  Text('Contact No.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Text(inst!.contactNo, style: TextStyle(fontSize: 18, color: Colors.black54),),
                      SizedBox(width: 5,),
                      Icon(Icons.call, size: 18, color: Colors.green,)
                    ],
                  ),
                  SizedBox(height: 25,),
                  Text('Address', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8,),
                  Text('${inst!.shortName},\n${inst!.landmark}, ${inst!.city}, ${inst!.district},\n${inst!.pincode}', style: TextStyle(fontSize: 18, color: Colors.black54),),
                  SizedBox(height:40,)
                ],
            ),
          ),
          
        ],
      ),
    );
  }
  
  _addToRecent(InstitutionModel? inst)async {
    if(f_user != null){
      try{
        await FirebaseFirestore.instance.collection('Users').doc(MyEncrypter().encrypt(user!.username)).collection('RecentVisits').doc(inst!.username+inst.shortName).set(inst.toJson());
        print('added');
      }catch(e){
        print(e);
      }
    }
  }
}