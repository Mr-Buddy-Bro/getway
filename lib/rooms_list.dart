import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/add_room.dart';
import 'package:getway/data_models/institution.dart';
import 'package:getway/data_models/room.dart';
import 'package:getway/edit_way.dart';
import 'package:getway/my_colors.dart';
import 'package:getway/way.dart';
import 'package:getway/widgets.dart';

class RoomsList extends StatefulWidget {
  InstitutionModel inst;
  RoomsList(this.inst, {super.key});

  @override
  State<RoomsList> createState() => _RoomsListState();
}

class _RoomsListState extends State<RoomsList> {

  List<RoomModel> rooms = [];

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
              color : MyColors().primary,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                  child: TitleBar(title: 'Rooms', subTitle: 'Naipunnya Institution of management and information technology',)
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                SizedBox(height: 15,),
                TitleText(text: 'All Rooms'),
                SizedBox(height: 20,),
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Institution').doc(widget.inst.docId).collection('Rooms').snapshots(),
                  builder: (BuildContext context,AsyncSnapshot snapshot) {
                    if(!snapshot.hasData) return Loading();
                    DocumentSnapshot doc;

                      for(doc in snapshot.data.docs){
                        final label = doc['roomLabel'];
                        final blockName = doc['blockName'];
                        final floor = doc['floor'];
                        final contactNo = doc['contactNo'];
                        final desc = doc['description'];
                        final docId = doc['docId'];

                        final _room = RoomModel(label, blockName, floor, contactNo, desc, docId);
                        rooms.add(_room);
                      }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: ((context) => WayScreen(widget.inst, rooms[index]))));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            margin: EdgeInsets.only(bottom: 10),
                            child: SelectableMenuItem(text: rooms[index].roomLabel,),
                          ),
                        );
                      },
                    );
                  }
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          
          Center( child: DescText(text: 'Rooms in this\ninstitution will show here', alignCenter: true,))
        ],
      ),
    );
  }
}