import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/data_models/institution.dart';
import 'package:getway/data_models/room.dart';
import 'package:getway/edit_rooms.dart';
import 'package:getway/my_colors.dart';
import 'package:getway/widgets.dart';

class AddRoom extends StatefulWidget {
  InstitutionModel inst;
  AddRoom(this.inst, {super.key});

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {

  late RoomModel room;
  final label_controller = TextEditingController();
  final blockName_controller = TextEditingController();
  final floor_controller = TextEditingController();
  final contactNo_controller = TextEditingController();
  final desc_controller = TextEditingController();

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
            child: TitleBar(title: 'New Room', subTitle: 'Naipunnya Institute of Management and Information Technology',),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text('Please Provide the neccassory\ninformations below', style: TextStyle(fontSize: 18, color: Colors.black45, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
                SizedBox(height: 30,),
                InputText(hint: 'Label', label: 'Room label', controller: label_controller,),
                SizedBox(height: 15,),
                InputText(hint: 'Block', label: 'Block name', controller: blockName_controller,),
                SizedBox(height: 15,),
                InputText(hint: 'Floor',  label: 'Floor', controller: floor_controller,),
                SizedBox(height: 15,),
                InputText(hint: 'Mobile',  label: 'Contact No.', controller: contactNo_controller,),
                SizedBox(height: 15,),
                InputText(label: 'Description', hint: 'Description',maxLine: 8, controller: desc_controller,),
                SizedBox(height: 40,),
                GestureDetector(
                  onTap: ()async {
                    final label = label_controller.text.trim();
                    final blockName = blockName_controller.text.trim();
                    final floor = floor_controller.text.trim();
                    final contactNo = contactNo_controller.text.trim();
                    final desc = desc_controller.text.trim();

                    if(label.isNotEmpty && blockName.isNotEmpty && floor.isNotEmpty && contactNo.isNotEmpty && desc.isNotEmpty){

                      if(desc.length > 20){
                        room = RoomModel(label, blockName, floor, contactNo, desc, widget.inst.shortName+label);
                        await FirebaseFirestore.instance.collection('Institution').doc(widget.inst.docId).collection('Rooms').doc(widget.inst.shortName+label).set(room.toJson());
                        Navigator.pop(context, MaterialPageRoute(builder: ((context) => EditRooms(widget.inst))));
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Description should have atleast 20 characters')));
                      }

                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Please fill all details')));
                    }
                    // Navigator.pop(context, MaterialPageRoute(builder: ((context) => EditRooms())));
                  },
                  child: PrimaryButton(text: 'Add Room')
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

