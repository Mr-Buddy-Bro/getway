import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/home.dart';
import 'package:getway/widgets.dart';
import 'package:getway/your_institutions.dart';
import 'package:image_picker/image_picker.dart';

class AddInstitution extends StatefulWidget {
  const AddInstitution({super.key});

  @override
  State<AddInstitution> createState() => _AddInstitutionState();
}

class _AddInstitutionState extends State<AddInstitution> {
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
                InputText(hint: 'Institution name', icon: Icon(Icons.house, color: Colors.green,),),
                SizedBox(height: 10,),
                InputText(hint: 'No. of blocks',),
                SizedBox(height: 10,),
                InputText(hint: 'No. of rooms',),
                SizedBox(height: 10,),
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
                InputText(hint: 'Head of the Institution', icon: Icon(Icons.person, color: Colors.green,),),
                SizedBox(height: 10,),
                InputText(hint: 'Contact No.', icon: Icon(Icons.call, color: Colors.green,),),
                SizedBox(height: 40,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => AddInstitution2())));
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

class AddInstitution2 extends StatefulWidget {
  const AddInstitution2({super.key});

  @override
  State<AddInstitution2> createState() => _AddInstitution2State();
}

class _AddInstitution2State extends State<AddInstitution2> {
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
                InputText(hint: 'Institution short name', icon: Icon(Icons.house, color: Colors.green,),),
                SizedBox(height: 10,),
                InputText(hint: 'Landmark',icon: Icon(Icons.landslide, color: Colors.green,)),
                SizedBox(height: 20,),
                InputText(hint: 'City',icon: Icon(Icons.location_city_rounded, color: Colors.green,)),
                SizedBox(height: 10,),
                InputText(hint: 'District', icon: Icon(Icons.terrain, color: Colors.green,),),
                SizedBox(height: 20,),
                InputText(hint: 'Pin code', icon: Icon(Icons.pin, color: Colors.green,),),
                SizedBox(height: 40,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => AddInstitution3())));
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

class AddInstitution3 extends StatefulWidget {
  const AddInstitution3({super.key});

  @override
  State<AddInstitution3> createState() => _AddInstitution3State();
}

class _AddInstitution3State extends State<AddInstitution3> {
  final bool pic_selected = false;
  File? _image;

  Future _getImage() async{
    
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(image == null){
      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(('null')))
                      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(('ok')))
                      );
    }
    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(('finish')))
                      );
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
                    child: SpecButton(text: 'Select institution photo')
                    )
                ),
                SizedBox(height: 40,),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: ((context) => AddInstitution3())));
                  },
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => YourInstitutions())));
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
  
 
}