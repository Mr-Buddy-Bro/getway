import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/add_room.dart';
import 'package:getway/edit_way.dart';
import 'package:getway/widgets.dart';

class EditRooms extends StatefulWidget {
  const EditRooms({super.key});

  @override
  State<EditRooms> createState() => _EditRoomsState();
}

class _EditRoomsState extends State<EditRooms> {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: ((context) => AddRoom())));
                      },
                      child: PrimaryButton(text: 'Add+', mini: true,)
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                TitleText(text: 'All Rooms'),
                SizedBox(height: 20,),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: ((context) => EditWay())));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        margin: EdgeInsets.only(bottom: 10),
                        child: SelectableMenuItem(text: 'Room No. ${index+1}',),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Center( child: DescText(text: 'Click on Add+ button\nto add a new room', alignCenter: true,))
        ],
      ),
    );
  }
}