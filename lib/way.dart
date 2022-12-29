import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/data_models/institution.dart';
import 'package:getway/data_models/room.dart';
import 'package:getway/data_models/suggestion.dart';
import 'package:getway/my_colors.dart';
import 'package:getway/network_calls/profilecall.dart';
import 'package:getway/widgets.dart';

import 'data_models/user.dart';

class WayScreen extends StatefulWidget {
  InstitutionModel inst;
  RoomModel room;
  
  WayScreen(this.inst, this.room, {super.key});

  @override
  State<WayScreen> createState() => _WayScreenState();
}

class _WayScreenState extends State<WayScreen> {
  UserModel? user;

  final sug_controller = TextEditingController();
  var count = 0;

  @override
  Widget build(BuildContext context) {

      _getUser();

    sug_controller.addListener(() {
      setState(() {
        count = sug_controller.text.length;
      });
    },);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
              color: MyColors().primary,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20,), bottomRight: Radius.circular(20))
            ),
            child: TitleBar(title: 'Way to the zone', subTitle: 'Naipunnya Institute of Management and Information Technology',),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(text: 'Flow graph'),
                SizedBox(height: 20,),
                BolckCard(blockName: widget.room.blockName,),
                Center( 
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      Image.asset('assets/img/down.png', scale: 20, color: MyColors().secondary,),
                      SizedBox(height: 15,),
                      Center(child: TraceCard(keyName: 'Floor', value: widget.room.floor,))
                    ],
                  )
                ),
                Center( 
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      Image.asset('assets/img/down.png', scale: 20, color: MyColors().secondary,),
                      SizedBox(height: 15,),
                      Center(child: TraceCard(keyName: 'Room label', value: widget.room.roomLabel,))
                    ],
                  )
                ),
                SizedBox(height: 30,),
                TitleText(text: 'Contact No.'),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text(widget.room.contactNo, style: TextStyle(fontSize: 18),),
                    SizedBox(width: 8,),
                    Icon(Icons.call, size: 22, color: MyColors().secondary,)
                  ],
                ),
                SizedBox(height: 30,),
                TitleText(text: 'Description'),
                SizedBox(height: 15,),
                DescText(text: widget.room.description),
                SizedBox(height: 20,),
                TitleText(text: 'Suggest an update'),
                SizedBox(height: 15,),
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    maxLength: 200,
                    controller: sug_controller,
                    maxLines: 50,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type your suggestion here',
                      hintStyle: TextStyle(color: Colors.black45),
                      counter: Text('$count/200', style: TextStyle(color: Colors.black54),)
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: ()async {
                    final msg = sug_controller.text.trim();
                    if(msg.isNotEmpty){
                      if(user != null){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Sending'), duration: Duration(milliseconds: 1000)));
                        final sug = SuggestionModel(user!.username+widget.inst.shortName+'_sug', msg, user!.firstName+" "+user!.lastName);
                        await FirebaseFirestore.instance.collection('Institution').doc(widget.inst.docId).collection('Rooms').doc(widget.room.docId)
                        .collection('Suggestions').doc(widget.room.roomLabel+Random().nextInt(8).toString()+'_sug').set(sug.toJson());
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Thanks for your suggestion'), duration: Duration(milliseconds: 1000)));
                        sug_controller.text = '';
                      }
                      
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Type your suggestion first'), duration: Duration(milliseconds: 1000)));
                    }
                  },
                  child: PrimaryButton(text: 'Submit', mini: true,)
                ),
                SizedBox(height: 40,)
              ],
            ),
          )
        ],
      ),
    );
  }
    _getUser()async{
    print('user');
    user = await ProfileCall().getUser(context);
  }
}

