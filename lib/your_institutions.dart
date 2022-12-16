import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/add_inst.dart';
import 'package:getway/edit_inst.dart';
import 'package:getway/widgets.dart';

import 'institutiondetails.dart';

class YourInstitutions extends StatefulWidget {
  const YourInstitutions({super.key});

  @override
  State<YourInstitutions> createState() => _YourInstitutionsState();
}

class _YourInstitutionsState extends State<YourInstitutions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20,), bottomRight: Radius.circular(20))
            ),
            child: TitleBar(title: 'Your Institutions',),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(text: 'Institutions you added'),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => AddInstitution())));
                  },
                  child: PrimaryButton(text: 'Add +', mini: true,)
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 8,
                childAspectRatio: .8
              ),
              itemCount: 3,
              itemBuilder: ((context, index) {
                return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditInst()));
                    },
                    child: NearbyInstCard(text: 'Tite ${index+1} goes here',)
                  );
              })
            ),
          )
        ],
      ),
    );
  }
}