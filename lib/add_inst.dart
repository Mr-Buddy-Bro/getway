import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/data_models/institution.dart';
import 'package:getway/data_models/user.dart';
import 'package:getway/home.dart';
import 'package:getway/widgets.dart';
import 'package:getway/your_institutions.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class AddInstitution extends StatefulWidget {
  UserModel? user;
  AddInstitution({super.key, this.user});

  @override
  State<AddInstitution> createState() => _AddInstitutionState();
}

class _AddInstitutionState extends State<AddInstitution> {
  String count = '0';
  final displayNameController = TextEditingController();

  final descriptionController = TextEditingController();

  final hioController = TextEditingController();

  final contactNoController = TextEditingController();

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
            child: TitleBar(title: 'New Institution',),
          ),
          SizedBox(height: 20,),
          Text('Enter the new institution details\nby filling the following fields below.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(text: 'Institution details'),
                SizedBox(height: 20,),
                InputText(hint: 'Institution name', icon: Icon(Icons.house, color: Colors.green,), controller: displayNameController,),
                SizedBox(height: 10,),
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    maxLength: 400,
                    controller: descriptionController,
                    onChanged: (text){
                      final c = descriptionController.text.length;
                      setState(() {
                        count = c.toString();
                      });
                    },
                    maxLines: 50,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description',
                      hintStyle: TextStyle(color: Colors.black45),
                      counter: Text('$count/400', style: TextStyle(color: Colors.black54),)
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                InputText(hint: 'Head of the Institution', icon: Icon(Icons.person, color: Colors.green,), controller: hioController,),
                SizedBox(height: 10,),
                InputText(hint: 'Contact No.', icon: Icon(Icons.call, color: Colors.green,), controller: contactNoController,),
                SizedBox(height: 40,),
                GestureDetector(
                  onTap: () {
                    final displayName = displayNameController.text.trim();
                    final description = descriptionController.text.trim();
                    final hoi = hioController.text.trim();
                    final contactNo = contactNoController.text.trim();

                    if(displayName.isNotEmpty && description.isNotEmpty && hoi.isNotEmpty && contactNo.isNotEmpty){
                      if(description.length > 100){
                        final inst = InstitutionModel(displayName, description, hoi, contactNo, '', '', '', '', '', widget.user!.username, '', null);
                        Navigator.push(context, MaterialPageRoute(builder: ((context) => AddInstitution2(inst, widget.user))));
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Description must be atleast 50 characters')));
                      }
                      
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Please fill all details')));
                    }
                  },
                  child: PrimaryButton(text: 'Next')
                ),
                SizedBox(height: 40,),

              ],
            ),
          )
        
        ],
      ),
    );
  }
}

class AddInstitution2 extends StatelessWidget {
  InstitutionModel inst;
  UserModel? user;
  AddInstitution2(this.inst, this.user, {super.key});

  @override
  Widget build(BuildContext context) {

    final shortNameController = TextEditingController();
    final landmarkController = TextEditingController();
    final cityController = TextEditingController();
    final districtController = TextEditingController();
    final pincodeController = TextEditingController();

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
            child: TitleBar(title: 'Address',),
          ),
          SizedBox(height: 20,),
          Text('Enter the new institution Address\nby filling the following fields below.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(text: 'Institution Address'),
                SizedBox(height: 20,),
                InputText(hint: 'Institution short name', icon: Icon(Icons.house, color: Colors.green,), controller: shortNameController,),
                SizedBox(height: 10,),
                InputText(hint: 'Landmark',icon: Icon(Icons.landslide, color: Colors.green,), controller: landmarkController,),
                SizedBox(height: 20,),
                InputText(hint: 'City',icon: Icon(Icons.location_city_rounded, color: Colors.green,), controller: cityController,),
                SizedBox(height: 10,),
                InputText(hint: 'District', icon: Icon(Icons.terrain, color: Colors.green,),controller: districtController,),
                SizedBox(height: 20,),
                InputText(hint: 'Pin code', icon: Icon(Icons.pin, color: Colors.green,),controller: pincodeController,),
                SizedBox(height: 40,),
                GestureDetector(
                  onTap: () {
                    final shortName = shortNameController.text.trim();
                    final landmark = landmarkController.text.trim();
                    final city = cityController.text.trim();
                    final district = districtController.text.trim();
                    final pincode = pincodeController.text.trim();

                    if(shortName.isNotEmpty && landmark.isNotEmpty && city.isNotEmpty && district.isNotEmpty && pincode.isNotEmpty){
                      final _inst = InstitutionModel(inst.displayName, inst.description, inst.hoi, inst.contactNo, shortName, landmark, city, district, pincode,inst.username, '', null);
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => AddInstitution3(_inst, user))));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MySnackBar(msg: 'Please fill all details')));
                    }
                    
                  },
                  child: PrimaryButton(text: 'Next')
                ),
                SizedBox(height: 40,),

              ],
            ),
          )
        
        ],
      ),
    );
  }
}

class AddInstitution3 extends StatefulWidget{
  InstitutionModel inst;
  UserModel? user;
  AddInstitution3(this.inst, this.user, {super.key});

  @override
  State<AddInstitution3> createState() => _AddInstitution3State(inst, user);
}

class _AddInstitution3State extends State<AddInstitution3> {
  final bool pic_selected = false;
  // File? _image;
  XFile? _image;
  InstitutionModel inst;
  UserModel? user;
  _AddInstitution3State(this.inst, this.user);

  Future _getImage() async{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery, maxHeight: 600, maxWidth: 600, imageQuality: 60);
    if(image == null){
      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(('Something went wrong! Please try again')))
                      );
    }else{
      //on pic
      setState(() {
        _image = image;
      });
      
    }
    
  }

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
            child: TitleBar(title: 'Graphics',),
          ),
          SizedBox(height: 30,),
          Text('Add the institutions Graphical details\nby filling the following fields below.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(child: TitleText(text: 'Institution Graphics')),
                SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                  child: GestureDetector(
                    onTap: () {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text(('ok')))
                      // );
                      _getImage();
                      
                    },
                    child: _image==null?SpecButton(text: 'Select institution photo'):Image.file(File(_image!.path)),
                    )
                ),
                SizedBox(height: 40,),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: ((context) => AddInstitution3())));
                  },
                  child: GestureDetector(
                    onTap: () async{
                         _upload(_image, inst, user!);
                      
                    },
                    child: PrimaryButton(text: 'Finish',)
                  )
                ),
                SizedBox(height: 80,),
                LinkText(text: 'Privacy policy'),
                SizedBox(height: 40,),
              ],
            ),
          )
        
        ],
      ),
    );
  }
  
  Future _upload(XFile? image, InstitutionModel inst, UserModel user)async {
    final path = 'Institutions/${inst.username+inst.shortName}/img/banner';
    final file = File(image!.path);

  try{
    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(('Uploading...')))
                      );
    await FirebaseStorage.instance.ref().child(path).putFile(file);
    final url = await FirebaseStorage.instance.ref().child('Institutions/${inst.username+inst.shortName}/img/banner').getDownloadURL();
    final institution = InstitutionModel(inst.displayName, inst.description, inst.hoi, inst.contactNo, inst.shortName, inst.landmark, inst.city, inst.district, 
    inst.pincode, inst.username, url, inst.username+inst.shortName);
    await FirebaseFirestore.instance.collection('Institution').doc(inst.username+inst.shortName).set(institution.toJson());
    
    Navigator.push(context, MaterialPageRoute(builder: ((context) => YourInstitutions(user: user,))));
    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(('New Institution added')))
                      );
  }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(('error: $e')))
                      );
  }
    
  }
  
 
}