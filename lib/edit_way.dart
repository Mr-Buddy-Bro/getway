import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/widgets.dart';

class EditWay extends StatefulWidget {
  const EditWay({super.key});

  @override
  State<EditWay> createState() => _EditWayState();
}

class _EditWayState extends State<EditWay> {
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
                InputText(hint: 'Label', label: 'Room label', text: 'Pricipal Office',),
                SizedBox(height: 15,),
                InputText(hint: 'Block', text: 'Main', label: 'Block name'),
                SizedBox(height: 15,),
                InputText(hint: 'Floor', text: '2 nd', label: 'Floor'),
                SizedBox(height: 15,),
                InputText(hint: 'Mobile', text: '+91 8943194516', label: 'Contact No.'),
                SizedBox(height: 15,),
                InputText(label: 'Description', hint: 'Description',maxLine: 8, text: 'What is a text meme?A meme is a virally transmitted image embellished with text, usually sharing pointed commentary on cultural symbols, social ideas, or current events. A meme is typically a photo or video, although sometimes it can be a block of text.',),
                SizedBox(height: 40,)
              ],
            ),
          )
        ],
      ),
    );
  }
}

