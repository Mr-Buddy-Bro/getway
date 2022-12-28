import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/data_models/institution.dart';
import 'package:getway/edit_rooms.dart';
import 'package:getway/way.dart';
import 'package:getway/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

import 'data_models/user.dart';
import 'encrypt.dart';

class EditInst extends StatefulWidget {
  String? doc_id;
  EditInst({super.key, this.doc_id});

  @override
  State<EditInst> createState() => _EditInstState();
}

class _EditInstState extends State<EditInst> {

  final name_controller = TextEditingController();
  final desc_controller = TextEditingController();
  final hoi_controller = TextEditingController();
  final contactNo_controller = TextEditingController();
  final place_controller = TextEditingController();
  final city_controller = TextEditingController();
  final district_controller = TextEditingController();
  final pinCode_controller = TextEditingController();


  UserModel? user;
  XFile? _image;
  String? photoUrl;

   Future _getImage(InstitutionModel inst) async{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery, maxHeight: 500, maxWidth: 500, imageQuality: 60);
    if(image == null){
      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(('Failed to pick Image')))
                      );
    }else{
      //on pic
      uploadPic(image, inst);
      setState(() {
        _image = image;
      });
      
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('Institution').doc(widget.doc_id).get(),
        builder: (BuildContext context,AsyncSnapshot snapshot) {

          if(!snapshot.hasData) return Loading();
          var doc = snapshot.data;
          final doc_id = doc.id;
          final displayName = doc['displayName'];
          final desc = doc['description'];
          final hoi = doc['hoi'];
          final contactNo = doc['contactNo'];
          final shortName = doc['shortName'];
          final landmark = doc['landmark'];
          final city = doc['city'];
          final district = doc['district'];
          final pincode = doc['pincode'];
          final username = doc['username'];
          photoUrl = doc['photoUrl'];

          final inst = InstitutionModel(displayName, desc, hoi, contactNo, shortName, 
          landmark, city, district, pincode, username, photoUrl!, doc_id);

          name_controller.text = displayName;
          desc_controller.text = desc;
          hoi_controller.text = hoi;
          contactNo_controller.text = contactNo;
          place_controller.text = landmark;
          city_controller.text = city;
          district_controller.text = district;
          pinCode_controller.text = pincode;

          name_controller.addListener(() {
            updateFeild(inst, name_controller.text.trim(), feild: 'displayName');
          },);
          desc_controller.addListener(() {
            updateFeild(inst, desc_controller.text.trim(), feild: 'description');
          },);
          hoi_controller.addListener(() {
            updateFeild(inst, hoi_controller.text.trim(), feild: 'hoi');
          },);
          contactNo_controller.addListener(() {
            updateFeild(inst, contactNo_controller.text.trim(), feild: 'contactNo');
          },);
          place_controller.addListener(() {
            updateFeild(inst, place_controller.text.trim(), feild: 'landmark');
          },);
          city_controller.addListener(() {
            updateFeild(inst, city_controller.text.trim(), feild: 'city');
          },);
          district_controller.addListener(() {
            updateFeild(inst, district_controller.text.trim(), feild: 'district');
          },);
          pinCode_controller.addListener(() {
            updateFeild(inst, pinCode_controller.text.trim(), feild: 'pincode');
          },);

          return ListView(
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
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
                    child: TitleBar(title: 'Edit Institution',)
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: DescText(text: 'Changes will save automatically', alignCenter: true,)
                    ),
                    SizedBox(height: 20,),
                    TitleText(text: 'Name'),
                    SizedBox(height: 10,),
                    InputText(hint: 'Institution name', maxLine: 2, controller: name_controller,),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        _getImage(inst);
                      },
                      child: TopInstCard(name: 'Tap to change',image: photoUrl)
                    ),
                    SizedBox(height: 20,),
                    TitleText(text: 'More Details'),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: ((context) => EditRooms(inst))));
                      },
                      child: SelectableMenuItem(text: 'Rooms', icon: Icon(Icons.house, color: Colors.black54,))
                    ),
                    SizedBox(height: 20,),
      
                    SizedBox(height: 20,),
                    TitleText(text: 'Description'),
                    SizedBox(height: 15,),
                    InputText(hint: 'Description',maxLine: 8, controller: desc_controller,),
                    SizedBox(height: 25,),
                    InputText(hint: 'Name', controller: hoi_controller, label: 'Head od the Institution'),
                    SizedBox(height: 15,),
                    InputText(hint: 'Mobile', controller: contactNo_controller, label: 'Contact No.'),
                    SizedBox(height: 8,),
                    SizedBox(height: 20,),
                    Text('Address', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 15,),
                    InputText(hint: 'Place', controller: place_controller, label: 'Place',),
                    SizedBox(height: 8,),
                    InputText(hint: 'City', controller: city_controller, label: 'City',),
                    SizedBox(height: 8,),
                    InputText(hint: 'Destrict', controller: district_controller, label: 'District',),
                    SizedBox(height: 8,),
                    InputText(hint: 'Pin Code', controller: pinCode_controller, label: 'Pin Code',),
                    SizedBox(height:40,)
                  ],
              ),
            ),
            
          ],
        );
        },
      ),
    );
  }

  uploadPic(XFile image, InstitutionModel inst)async {
    final file = File(image.path);
    try{
      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(('Updating...')))
                      );
      final ref = FirebaseStorage.instance.ref().child('Institutions/${inst.docId}/img/banner');
      await ref.putFile(file);
      final url = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('Institution/').doc(inst.docId).update({'photoUrl':url});
      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(('Photo Updated')))
                      );
      setState(() {
        photoUrl = url;
      });
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(('Failed to update Photo $e')))
                      );
    }
    
  }
  
  updateFeild(InstitutionModel inst, String value, {required String feild})async {
    FirebaseFirestore.instance.collection('Institution').doc(inst.docId).update({feild: value});
    print('updated');
  }
}