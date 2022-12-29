import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/my_colors.dart';
import 'package:getway/widgets.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: MyColors().primary,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20,), bottomRight: Radius.circular(20))
            ),
            child: TitleBar(title: 'Privacy & policy',),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Common').doc('priv_pol').snapshots(),
            builder: ((BuildContext context, AsyncSnapshot snapshot) {
              final text = snapshot.data['text'];
              print(text);
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(text, style: TextStyle(fontSize: 16),),
              );
            })
          )
        ],
      ),
    );
  }
  
 
}