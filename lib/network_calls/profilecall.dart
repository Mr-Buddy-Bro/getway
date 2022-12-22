import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getway/data_models/user.dart';

import '../encrypt.dart';
import '../widgets.dart';

class ProfileCall{
  User? user;
   Future getUser(context) async {
    this.user = FirebaseAuth.instance.currentUser;
    late String email;
    late String username;
    late String firstname;
    late String lastname;
    late String password;
    late String photoUrl;
    late UserModel myUser;
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((element) {
          email = MyEncrypter().decrypt(element.data()['email'].toString());
          username =
              MyEncrypter().decrypt(element.data()['username'].toString());
          firstname =
              MyEncrypter().decrypt(element.data()['firstname'].toString());
          lastname =
              MyEncrypter().decrypt(element.data()['lastname'].toString());
          password =
              MyEncrypter().decrypt(element.data()['password'].toString());
          photoUrl =
              element.data()['photoUrl'].toString();

          if(email == this.user!.email){
            myUser = UserModel(firstname, lastname, email, username, password, photoUrl);
          }
        });
      });
      return myUser;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: MySnackBar(msg: 'errorr : $e')));
    }
  }
}