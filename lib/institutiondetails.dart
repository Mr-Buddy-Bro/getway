import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/way.dart';
import 'package:getway/widgets.dart';
import 'package:page_transition/page_transition.dart';

class InstDetails extends StatefulWidget {
  const InstDetails({super.key});

  @override
  State<InstDetails> createState() => _InstDetailsState();
}

class _InstDetailsState extends State<InstDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Stack(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color : Colors.white70,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                      child: TitleBar(title: 'Instituttion details',)
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color.fromARGB(11, 0, 0, 0),
                      blurRadius: 5,
                      spreadRadius: 1
                    )
                  ],
                  borderRadius: BorderRadius.circular(15)
                ),
                margin: EdgeInsets.only(left: 20, right: 20, top: 80),
                child: InputText(hint: 'find the zone', icon: Icon(Icons.search_rounded),)
              )
            ],
          ),
          SizedBox(height: 15,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InstCard(),
                  SizedBox(height: 20,),
                  TitleText(text: 'More Details'),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DivCard(image: Image.asset('assets/img/skyscraper.png', scale: 6,), count: 3, label: 'No. of blocks',),
                      DivCard(image: Image.asset('assets/img/living-room.png', scale: 6,), count: 12, label: 'No. of roomss',),
                    ],
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => WayScreen())));
                    },
                    child: SpecButton(text: 'Demo')
                  ),
                  SizedBox(height: 20,),
                  TitleText(text: 'Description'),
                  SizedBox(height: 15,),
                  DescText(text: 'What is a text meme?A meme is a virally transmitted image embellished with text, usually sharing pointed commentary on cultural symbols, social ideas, or current events. A meme is typically a photo or video, although sometimes it can be a block of text.',),
                  SizedBox(height: 25,),
                  Text('Head of the Institution', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8,),
                  Text('Fr. Paul Kaithotunkal', style: TextStyle(fontSize: 18, color: Colors.black54),),
                  SizedBox(height: 25,),
                  Text('Contact No.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Text('+91 8943194516', style: TextStyle(fontSize: 18, color: Colors.black54),),
                      SizedBox(width: 5,),
                      Icon(Icons.call, size: 18, color: Colors.green,)
                    ],
                  ),
                  SizedBox(height: 25,),
                  Text('Address', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8,),
                  Text('NIMIT,\nPongam, Koratty, Thrissur,\n683581', style: TextStyle(fontSize: 18, color: Colors.black54),),
                  SizedBox(height:40,)
                ],
            ),
          ),
          
        ],
      ),
    );
  }
}