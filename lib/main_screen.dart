import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getway/profile.dart';
import 'package:getway/recent_visits.dart';

import 'data_models/user.dart';
import 'home.dart';

class MainScreen extends StatefulWidget {
  UserModel? user;
  MainScreen({super.key, this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

    var selected = 0;
  

  @override
  Widget build(BuildContext context) {

    final screens = [
      HomeScreen(user: widget.user,),
      RecentVisitScreen(user: widget.user,),
      ProfileScreen(user: widget.user,),
    ];


    return Scaffold(
      body: screens[selected],
      bottomNavigationBar: NavigationBar(
        
        onDestinationSelected: (index) {
          setState(() {
            selected = index;
          });
        },
        selectedIndex: selected,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home',),
          // NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.history), label: 'Recent'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],

      ),
    );
  }
}