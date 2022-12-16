import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/edit_rooms.dart';
import 'package:getway/widgets.dart';

class AddRoom extends StatefulWidget {
  const AddRoom({super.key});

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
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
              color: Colors.white,
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
                InputText(hint: 'Label', label: 'Room label',),
                SizedBox(height: 15,),
                InputText(hint: 'Block', label: 'Block name'),
                SizedBox(height: 15,),
                InputText(hint: 'Floor',  label: 'Floor'),
                SizedBox(height: 15,),
                InputText(hint: 'Mobile',  label: 'Contact No.'),
                SizedBox(height: 15,),
                InputText(label: 'Description', hint: 'Description',maxLine: 8,),
                SizedBox(height: 40,),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, MaterialPageRoute(builder: ((context) => EditRooms())));
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

