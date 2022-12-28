import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/data_models/room.dart';
import 'package:getway/widgets.dart';

import 'data_models/institution.dart';

class EditWay extends StatefulWidget {
  InstitutionModel inst;
  RoomModel room;
  EditWay(this.inst, this.room, {super.key});

  @override
  State<EditWay> createState() => _EditWayState();
}

class _EditWayState extends State<EditWay> {

  final label_controller = TextEditingController();
  final blockName_controller = TextEditingController();
  final floor_controller = TextEditingController();
  final contactNo_controller = TextEditingController();
  final desc_controller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: StreamBuilder<Object>(
        stream: FirebaseFirestore.instance.collection('Institution').doc(widget.inst.docId).collection('Rooms').doc(widget.room.docId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          
          final label = snapshot.data['roomLabel'];
          final blockName = snapshot.data['blockName'];
          final floor = snapshot.data['floor'];
          final contactNo = snapshot.data['contactNo'];
          final desc = snapshot.data['description'];

          print(label);

          label_controller.text = label;
          blockName_controller.text = blockName;
          floor_controller.text = floor;
          contactNo_controller.text = contactNo;
          desc_controller.text = desc;

          return ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20,), bottomRight: Radius.circular(20))
                ),
                child: TitleBar(title: 'Edit Way to Principal Office', subTitle: 'Naipunnya Institute of Management and Information Technology',),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Text('Make your changes. Changes will\nbe saved automatically', style: TextStyle(fontSize: 18, color: Colors.black45, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
                    SizedBox(height: 30,),
                    InputText(hint: 'Label', label: 'Room label', controller: label_controller,),
                    SizedBox(height: 15,),
                    InputText(hint: 'Block', controller: blockName_controller, label: 'Block name'),
                    SizedBox(height: 15,),
                    InputText(hint: 'Floor', controller: floor_controller, label: 'Floor'),
                    SizedBox(height: 15,),
                    InputText(hint: 'Mobile', controller: contactNo_controller, label: 'Contact No.'),
                    SizedBox(height: 15,),
                    InputText(label: 'Description', hint: 'Description',maxLine: 8, controller: desc_controller,),
                    SizedBox(height: 40,)
                  ],
                ),
              )
            ],
          );
        }
      ),
    );
  }

  updateFeild(InstitutionModel inst, RoomModel room, String value, {required String feild})async {
    FirebaseFirestore.instance.collection('Institution').doc(inst.docId).collection('Rooms').doc(room.docId).update({feild: value});
    print('updated');
  }
}

