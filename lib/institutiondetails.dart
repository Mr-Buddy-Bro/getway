import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/data_models/institution.dart';
import 'package:getway/data_models/report.dart';
import 'package:getway/data_models/room.dart';
import 'package:getway/data_models/user.dart';
import 'package:getway/encrypt.dart';
import 'package:getway/rooms_list.dart';
import 'package:getway/way.dart';
import 'package:getway/widgets.dart';
import 'package:page_transition/page_transition.dart';

import 'my_colors.dart';

class InstDetails extends StatefulWidget {
  InstitutionModel? inst;
  UserModel? user;
  InstDetails(this.inst, {super.key, this.user});
  

  @override
  State<InstDetails> createState() => _InstDetailsState(inst, user);
}

class _InstDetailsState extends State<InstDetails> {
  InstitutionModel? inst;
  UserModel? user;
  List<RoomModel> t_rooms = [];
  List<RoomModel> rooms = [];
  final searchTextController = TextEditingController();
  User? f_user = FirebaseAuth.instance.currentUser;
  _InstDetailsState(this.inst, this.user);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllRooms();
  }
  

  @override
  Widget build(BuildContext context) {
    _addToRecent(inst);

    searchTextController.addListener((() {
        searchInst(searchTextController.text.trim());
    }));

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
                  color : MyColors().primary,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                      child: TitleBar(title: 'Institution details',)
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color.fromARGB(21, 0, 255, 68),
                      blurRadius: .2,
                      spreadRadius: .3
                    )
                  ],
                  borderRadius: BorderRadius.circular(15)
                ),
                margin: EdgeInsets.only(left: 20, right: 20, top: 80),
                child: InputText(hint: 'find the zone', icon: Icon(Icons.search_rounded, color: MyColors().primary,), controller: searchTextController,)
              )
            ],
          ),
          SizedBox(height: 15,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  rooms.length > 0? Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: rooms.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: ((context) => WayScreen(widget.inst!, rooms[index]))));
                              },
                              child: ListTile(tileColor: Colors.grey[200],shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), title: Text(rooms[index].roomLabel),)
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ):SizedBox(),

                  InstCard(inst!),
                  SizedBox(height: 20,),
                  TitleText(text: 'More Details'),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DivCard(image: Image.asset('assets/img/skyscraper.png', scale: 6,), count: widget.inst!.shortName, label: 'Short name',),
                      DivCard(image: Image.asset('assets/img/living-room.png', scale: 6,), count: t_rooms.length.toString(), label: 'No. of rooms',),
                    ],
                  ),
                  SizedBox(height: 25,),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => RoomsList(inst!))));
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Feature will be coming soon'), duration: Duration(milliseconds: 500),));
                    },
                    child: SelectableMenuItem(text: 'Rooms', icon: Icon(Icons.house, color: MyColors().secondary,))
                  ),
                  SizedBox(height: 25,),
                  TitleText(text: 'Description'),
                  SizedBox(height: 15,),
                  DescText(text: inst!.description,),
                  SizedBox(height: 25,),
                  Text('Head of the Institution', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8,),
                  Text(inst!.hoi, style: TextStyle(fontSize: 18, color: Colors.black54),),
                  SizedBox(height: 25,),
                  Text('Contact No.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Text(inst!.contactNo, style: TextStyle(fontSize: 18, color: Colors.black54),),
                      SizedBox(width: 5,),
                      Icon(Icons.call, size: 18, color: MyColors().secondary,)
                    ],
                  ),
                  SizedBox(height: 25,),
                  Text('Address', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8,),
                  Text('${inst!.shortName},\n${inst!.landmark}, ${inst!.city}, ${inst!.district},\n${inst!.pincode}', style: TextStyle(fontSize: 18, color: Colors.black54),),
                  SizedBox(height:30,),
                  
                  ElevatedButton(
                    
                    onPressed: (){
                    user != null?showDialog(
                        context: context, 
                        builder: ((context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            content: Container(
                              height: 160,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleText(text:'Report '+ widget.inst!.shortName+'?'),
                                  SizedBox(height: 20,),
                                  DescText(text: 'On reporting this institution, the details of this institution with a report stamp will be sent to GetWay team and this institution will be evaluated.'),
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text('Cancel', style: TextStyle(color: Colors.green, fontSize: 16),)),
                              ElevatedButton(onPressed: (){
                                _report();
                              }, child: Text('Report'))
                            ],
                          );
                        })
                      ):ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Please login first')));
                  }, 
                  child: Container(width: double.infinity, child: Text('Report', textAlign: TextAlign.center,))
                  ),
                  SizedBox(height: 40,)
                ],
            ),
          ),
          
        ],
      ),
    );
  }
  
  _addToRecent(InstitutionModel? inst)async {
    if(f_user != null){
      try{
        await FirebaseFirestore.instance.collection('Users').doc(MyEncrypter().encrypt(user!.username)).collection('RecentVisits').doc(inst!.username+inst.shortName).set(inst.toJson());
        print('added');
      }catch(e){
        print(e);
      }
    }
  }
  
  searchInst(String text)async {
    if(text.length < 2){
       setState(() {
           rooms.clear();
        });
    }else{
    List<RoomModel> _room = [];
    await FirebaseFirestore.instance.collection('Institution').doc(widget.inst!.docId).collection('Rooms').get().then((snapshot) {
      snapshot.docs.forEach((element) {
        final String roomName = element.data()['roomLabel'].toString().toLowerCase();
        print(text);
        if(roomName.contains(text.toLowerCase())){
          
          final String roomLabel = element.data()['roomLabel'].toString();
          final String description = element.data()['description'].toString();
          final String contactNo = element.data()['contactNo'].toString();
          final String docId = element.data()['docId'].toString();
          final String blockName = element.data()['blockName'].toString();
          final String floor = element.data()['floor'].toString();
          print(roomLabel);
          final room = RoomModel(roomLabel, blockName, floor, contactNo, description, docId);
          _room.add(room);
         
        }
      });
    });
    
    
    setState(() {
      rooms = _room;
      
    });
    }
  }
  
  _getAllRooms()async {
      await FirebaseFirestore.instance.collection('Institution').doc(widget.inst!.docId).collection('Rooms').get().then((snapshot) {
        snapshot.docs.forEach((element) {
          final String roomLabel = element.data()['roomLabel'].toString();
          final String description = element.data()['description'].toString();
          final String contactNo = element.data()['contactNo'].toString();
          final String docId = element.data()['docId'].toString();
          final String blockName = element.data()['blockName'].toString();
          final String floor = element.data()['floor'].toString();
          final room = RoomModel(roomLabel, blockName, floor, contactNo, description, docId);
          setState(() {
            t_rooms.add(room);
          });
        });
      });
  }
  
  _report()async{
    final report = ReportModel(widget.inst!.docId.toString(), MyEncrypter().encrypt(widget.user!.username));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Reporting ${widget.inst!.shortName}')));
    Navigator.pop(context);
    await FirebaseFirestore.instance.collection('Reports').add(report.toJson());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Report received')));
  }
}