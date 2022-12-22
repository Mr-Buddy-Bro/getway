
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/data_models/user.dart';
import 'package:getway/encrypt.dart';
import 'package:getway/login.dart';
import 'package:getway/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  UserModel? user;
  ProfileScreen({super.key, this.user = null});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState(user);
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? user;
  XFile? _image;
  String? photoUrl;
  _ProfileScreenState(this.user);

  Future _getImage() async{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery, maxHeight: 500, maxWidth: 500, imageQuality: 60);
    if(image == null){
      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(('Failed to pick Image')))
                      );
    }else{
      //on pic
      uploadPic(image);
      setState(() {
        _image = image;
      });
      
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').doc(MyEncrypter().encrypt(user!.username)).snapshots(),
        builder: (BuildContext context,AsyncSnapshot snapshot) {
          photoUrl = snapshot.data['photoUrl'];
          print(photoUrl);
          return ListView(
          children: [
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TitleBar(title: 'Profile'),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: _getImage,
              child: Column(
                children: [
                  Container(
                            width: 130.0,
                            height: 130.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: new NetworkImage(
                                                user!.photoUrl.length > 0?photoUrl!:'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg',),
                                    
                                  )
                                )
                          ),
                ],
              ),
            ),
      
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${user!.firstName} ${user!.lastName}'.toUpperCase(), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                Icon(Icons.edit_note_rounded)
              ],
            ),
            SizedBox(height: 8,),
            LinkText(text: user!.email, size: 18,),
            SizedBox(height: 30,),
            TraceCard(keyName: 'Level', value: '1', bg: false,),
            // TraceCard(keyName: 'Mobile', value: '+91 8943194516', bg: false,),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  children: [
                    SelectableMenuItem(text: 'Help', icon: Icon(Icons.help_outline_rounded),),
                    SizedBox(height: 8,),
                    Divider(color: Color.fromARGB(48, 76, 175, 79),),
                    SizedBox(height: 8,),
                    SelectableMenuItem(text: 'Request account deletion', icon: Icon(Icons.no_accounts_rounded),),
                  ],
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Container(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => LoginScreen())));
                  },
                  child: SpecButton(text: 'Sign out', warning: true,)
                )
              ),
            )
          ],
        );
        },

      ),
    );
  }
  
  uploadPic(XFile image)async {
    final file = File(image.path);
    try{
      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(('Updating...')))
                      );
      final ref = FirebaseStorage.instance.ref().child('Users/${user!.username}/profile');
      await ref.putFile(file);
      final url = await ref.getDownloadURL();

      final en_username = MyEncrypter().encrypt(user!.username);
      await FirebaseFirestore.instance.collection('Users/').doc(en_username).update({'photoUrl':url});
      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(('Profile Updated')))
                      );
      setState(() {
        photoUrl = url;
      });
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(('Failed to update Profile')))
                      );
    }
    
  }
}