import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/edit_rooms.dart';
import 'package:getway/way.dart';
import 'package:getway/widgets.dart';
import 'package:page_transition/page_transition.dart';

class EditInst extends StatefulWidget {
  const EditInst({super.key});

  @override
  State<EditInst> createState() => _EditInstState();
}

class _EditInstState extends State<EditInst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color : Colors.white70,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                  child: TitleBar(title: 'Edit Institution',)
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(text: 'Name'),
                  SizedBox(height: 15,),
                  InputText(hint: 'Institution name', text: 'Naipunnya Institute of management and Information Technology', maxLine: 2,),
                  SizedBox(height: 20,),
                  TopInstCard(name: '',),
                  SizedBox(height: 20,),
                  TitleText(text: 'More Details'),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => EditRooms())));
                    },
                    child: SelectableMenuItem(text: 'Rooms', icon: Icon(Icons.house, color: Colors.black54,))
                  ),
                  SizedBox(height: 20,),

                  SizedBox(height: 20,),
                  TitleText(text: 'Description'),
                  SizedBox(height: 15,),
                  InputText(hint: 'Description',maxLine: 8, text: 'What is a text meme?A meme is a virally transmitted image embellished with text, usually sharing pointed commentary on cultural symbols, social ideas, or current events. A meme is typically a photo or video, although sometimes it can be a block of text.',),
                  SizedBox(height: 25,),
                  InputText(hint: 'Name', text: 'Fr. Paul Kaithotungal', label: 'Head od the Institution'),
                  SizedBox(height: 15,),
                  InputText(hint: 'Mobile', text: '+91 8943194516', label: 'Contact No.'),
                  SizedBox(height: 8,),
                  SizedBox(height: 20,),
                  Text('Address', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15,),
                  InputText(hint: 'Short name', text: 'NIMIT', label: 'Short name',),
                  SizedBox(height: 8,),
                  InputText(hint: 'Place', text: 'Pongam', label: 'Place',),
                  SizedBox(height: 8,),
                  InputText(hint: 'City', text: 'Koratty', label: 'City',),
                  SizedBox(height: 8,),
                  InputText(hint: 'Destrict', text: 'Thrissur', label: 'Destrict',),
                  SizedBox(height: 8,),
                  InputText(hint: 'Pin Code', text: '683581', label: 'Pin Code',),
                  SizedBox(height:40,)
                ],
            ),
          ),
          
        ],
      ),
    );
  }
}