import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/widgets.dart';

class WayScreen extends StatefulWidget {
  const WayScreen({super.key});

  @override
  State<WayScreen> createState() => _WayScreenState();
}

class _WayScreenState extends State<WayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
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
                BolckCard(blockName: 'Main',),
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Center( 
                      child: Column(
                        children: [
                          SizedBox(height: 15,),
                          Image.asset('assets/img/down.png', scale: 20,),
                          SizedBox(height: 15,),
                          Center(child: TraceCard(keyName: 'Floor', value: '2nd',))
                        ],
                      ));
                        
                  },                 
                ),
                SizedBox(height: 30,),
                TitleText(text: 'Contact No.'),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('+91 8943194516', style: TextStyle(fontSize: 18),),
                    SizedBox(width: 8,),
                    Icon(Icons.call, size: 22, color: Colors.green,)
                  ],
                ),
                SizedBox(height: 30,),
                TitleText(text: 'Description'),
                SizedBox(height: 15,),
                DescText(text: 'What is a text meme?A meme is a virally transmitted image embellished with text, usually sharing pointed commentary on cultural symbols, social ideas, or current events. A meme is typically a photo or video, although sometimes it can be a block of text.'),
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
                    maxLines: 50,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type your suggestion here',
                      hintStyle: TextStyle(color: Colors.black45),
                      counter: Text('0/200', style: TextStyle(color: Colors.black54),)
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                SpecButton(text: 'Submit'),
                SizedBox(height: 40,)
              ],
            ),
          )
        ],
      ),
    );
  }
}

