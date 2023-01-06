import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/data_models/institution.dart';
import 'package:getway/institutiondetails.dart';
import 'package:getway/my_colors.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class LinkText extends StatelessWidget {
  final String text;
  final double size;
  const LinkText({required this.text, this.size = 16,super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: Colors.green, fontSize: size), textAlign: TextAlign.center,);

  }
}

class InputText extends StatelessWidget {
  final String hint;
  final String text;
  final String? label;
  final Icon? icon;
  final bool pass;
  final bool email;
  final int maxLine;
  final TextEditingController? controller;
  const InputText({required this.hint, this.icon = null, this.email=false, this.pass = false,this.controller, super.key, this.text='', this.maxLine=1, this.label});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: MyColors().inputText
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        maxLines: maxLine,
        controller: controller,
        autocorrect: false,
        autofillHints: null,
        obscureText: pass,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis,),
        cursorColor: MyColors().primary,
        showCursor: true,
        cursorWidth:1.0,
        keyboardType: email?TextInputType.emailAddress:TextInputType.text,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: icon,
          prefixStyle: TextStyle(),
          hintText: hint,
          label: label!=null?Text(label!):null,
          hintStyle: TextStyle(fontSize: 18, color: Color.fromARGB(144, 0, 0, 0),)
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final bool mini;
  const PrimaryButton({this.mini=false, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors().primary,
        borderRadius: BorderRadius.circular(50)
      ),
      padding: EdgeInsets.symmetric(vertical: mini?10:15, horizontal: mini?20:30),
      width: mini?null:double.infinity,
      child: Text(text, style: TextStyle(fontSize: mini?18:20, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center,),
    );
  }
}

class TitleText extends StatelessWidget {
  final String text;
  const TitleText({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style:TextStyle(fontSize: 20,fontWeight: FontWeight.w500, ));
  }
}

class TopInstCard extends StatelessWidget {
  final String name;
  final int? count;
  final String? image;
  const TopInstCard({this.count, required this.name,this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Color.fromARGB(0, 0, 0, 0),
                          blurRadius: 8.0,
                          offset: Offset(0.0, 1)
                      ),
                    ],
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: NetworkImage(image!,), fit: BoxFit.cover)
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/img/gradient.png',), fit: BoxFit.fill)
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 230,
                  child: Text(name, style: TextStyle(fontSize: 16, color: Colors.white), maxLines: 2,)
                ),
                Container(
                  child: count!=null?Row(
                    children: [
                      Icon(Icons.visibility, color: Colors.white, size: 18,),
                      SizedBox(width: 3,),
                      Text(count.toString(), style: TextStyle(fontSize: 16, color: Colors.white), maxLines: 2,),
                    ],
                  ):null
                ),
                // Text(name, style: TextStyle(fontSize: 16, color: Colors.white), maxLines: 2,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NearbyInstCard extends StatelessWidget {
  final String text;
  final String? photoUrl;
  NearbyInstCard({required this.text, this.photoUrl = null, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
         boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Color.fromARGB(0, 0, 0, 0),
                          blurRadius: 5.0,
                          spreadRadius: 2,
                          offset: Offset(0.0, 0.75)
                      ),
                    ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: photoUrl == null? NetworkImage('https://images.pexels.com/photos/573130/pexels-photo-573130.jpeg?cs=srgb&dl=pexels-zulian-yuliansyah-573130.jpg') : NetworkImage(photoUrl!),
          fit: BoxFit.cover
        )
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/gridgradient.png'),
            fit: BoxFit.cover
            
          ),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(text, style: TextStyle(color: Colors.white, fontSize: 16, overflow: TextOverflow.ellipsis), textAlign: TextAlign.center, maxLines: 2,),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleBar extends StatelessWidget {
  final String title;
  final String? subTitle;
  const TitleBar({required this.title, this.subTitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.white,)
              ),
              SizedBox(width: 30,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 300, child: Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis, color: Colors.white),)),
                  subTitle != null? Container(width: 300, child: Text(subTitle!, style: TextStyle(fontSize: 16, color: Colors.white, overflow: TextOverflow.ellipsis),)):SizedBox(),
                ],
              ),
            ],
          );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                margin: EdgeInsets.only(top: 115, right: 15, left: 15),
                decoration: BoxDecoration(
                  color : Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(blurRadius: 3.0, color: Color.fromARGB(32, 0, 255, 30), spreadRadius: 0.0),
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                      child: Container(
                        width: 150,
                        child: Column(
                          children: [
                            Text('Last visit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 65, 203, 70)),),
                            SizedBox(height: 5,),
                            Text('Naipunnya institute of management and information Technology',maxLines: 1, style: TextStyle(fontSize: 16, color: Colors.black, overflow: TextOverflow.ellipsis,),textAlign: TextAlign.center,),
                            SizedBox(height: 5,),
                            Text('Mon 6:32 pm',maxLines: 1, style: TextStyle(overflow: TextOverflow.ellipsis,),textAlign: TextAlign.center,)
                          ],
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                      child: Container(
                        height: 100,
                        child: Image.asset('assets/img/sample_place.jpg',)
                      ),
                    )
                  ],
                ),
              );
  }
}

class BannerCard extends StatefulWidget {
  BannerCard({super.key});

  @override
  State<BannerCard> createState() => _BannerCardState();
}

class _BannerCardState extends State<BannerCard> {
  String bannerUrl = '';
  @override
  Widget build(BuildContext context) {

     
    _getBanner();

    return Container(
      height: 110,
      margin: EdgeInsets.only(top: 10, right: 15, left: 15),
      decoration: BoxDecoration(
        color : Colors.white,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(bannerUrl,),
          fit: BoxFit.cover
        )
      ),
    );
  }

  _getBanner() async{
    final url = await FirebaseStorage.instance.ref().child('Common/banner.jpg').getDownloadURL();
    setState(() {
      bannerUrl = url;
    });
  }
}

class InstCard extends StatelessWidget {
  InstitutionModel inst;
  InstCard(this.inst, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors().primary,
        borderRadius: BorderRadius.circular(20)
      ),
      padding: EdgeInsets.only(left: 20,top: 8, right: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 160,
                child: Text(inst.displayName, style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis, color: Colors.white), maxLines: 3,)
              ),
              SizedBox(height: 10,),
              Container(
                height: 15,
                width: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 15,
                      width: 15,
                      margin: EdgeInsets.only(right: 3),
                      child: index!=3? Image.asset('assets/img/star.png'):Image.asset('assets/img/rating.png')
                    );
                  },
                ),
              )
            ],
          ),
          Container(
            height: 110,
            width: 130,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(inst.photoUrl), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(15),
              color: Color.fromARGB(255, 255, 255, 255)
            ),
          )
        ],
      ),
    );
  }
}

class DivCard extends StatelessWidget {
  final Image image;
  final String count;
  final String label;
  const DivCard({required this.image, required this.count, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            image,
            SizedBox(height: 10,),
            Container(width: 100, child: Text(count.toString(), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis,)),
            SizedBox(height: 10,),
            Text(label, style: TextStyle(fontSize: 18),)
          ],
        ),
      ),
    );
  }
}

class DescText extends StatelessWidget {
  final String text;
  final bool alignCenter;
  const DescText({required this.text, super.key, this.alignCenter = false});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 16, color: Colors.black54), textAlign: alignCenter?TextAlign.center:TextAlign.start,);
  }
}

class SpecButton extends StatelessWidget {
  final String text;
  final bool warning;
  const SpecButton({required this.text, this.warning = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Color.fromARGB(8, 0, 0, 0),
                        blurRadius: 5,
                        spreadRadius: 1
                      )
        ],
        borderRadius: BorderRadius.circular(5),
        color: warning? Color.fromARGB(255, 255, 237, 237): Color.fromARGB(95, 241, 255, 242)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
        child: Text(text, style: TextStyle(color: warning? Color.fromARGB(255, 186, 43, 33): Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold, fontSize: 16),textAlign: TextAlign.center,),
      ),
    );
  }
}

class SelectableMenuItem extends StatelessWidget {
  final String text;
  final Icon? icon;
  final bool arrow;
  const SelectableMenuItem({required this.text, this.icon,this.arrow = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            icon != null?icon! : SizedBox(),
            SizedBox(width: 10,),
            TitleText(text: text)
          ],
        ),
        arrow?Icon(Icons.arrow_forward_ios_rounded, size: 18, color: MyColors().secondary,):SizedBox()
      ],
    );
  }
}
class BolckCard extends StatelessWidget {
  final String blockName;
  const BolckCard({this.blockName = 'Main', super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Block name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                TitleText(text: blockName),
              ],
            ),
            SizedBox(width: 40,),
            Container(height: 80, width: 1, color: Color.fromARGB(60, 76, 239, 84),),
            SizedBox(width: 20,),
            Image.asset('assets/img/skyscraper.png', scale: 6,),
          ],
        ),
      ),
    );
  }
}

class TraceCard extends StatelessWidget {
  final String keyName;
  final String value;
  final bool bg;
  const TraceCard({this.bg=true, required this.keyName, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: bg?Colors.white:null,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Text('$keyName : ', style: TextStyle(fontSize: 20,),),
                Text('$value', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CircleImage extends StatelessWidget {
  final AssetImage image;
  final double size;
  const CircleImage({required this.image, this.size=50,  super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            width: size,
            height: size,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: image
                )
            )
          );
  }
}

class MyAalert extends StatelessWidget {
  const MyAalert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      title: Text('Exit!', style: TextStyle(color: Colors.redAccent),),
      content: Text('Do you want to exit?'),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('No', style: TextStyle(fontSize: 18),),
          
        ),
        ElevatedButton(onPressed: (){
          SystemNavigator.pop();
        }, child: Text('Yes', style: TextStyle(fontSize: 18,),),),
      ],
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white
    );
  }
}

class MySnackBar extends StatelessWidget {
  final String msg;
  const MySnackBar({required this.msg, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(msg),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Lottie.asset('assets/lottie/loading.json')),
    );
  }
}

// Container(
//                           child: InputText(
//                             hint: 'Search Institutions, building etc.',
//                             icon: Icon(Icons.search, color: MyColors().primary,),
//                             controller: searchTextController,
//                           ),
//                           decoration: BoxDecoration(
//                             boxShadow: [
//                               BoxShadow(
//                                 color: MyColors().shadow,
//                                 blurRadius: 3,
//                                 spreadRadius: .3,
//                                 offset: Offset(0, 3)
//                               ),
                              
//                             ],
//                             borderRadius: BorderRadius.circular(15)
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         institutions.length > 0? Column(
//                           children: [
//                             ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: institutions.length,
//                               itemBuilder: ((context, index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.all(2.0),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       Navigator.push(context, MaterialPageRoute(builder: ((context) => InstDetails(institutions[index]))));
//                                     },
//                                     child: ListTile(tileColor: Colors.grey[200],shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), title: Text(institutions[index].displayName + " - "+institutions[index].shortName),)
//                                   ),
//                                 );
//                               }),
//                             ),
//                             SizedBox(height: 20,),
//                           ],
//                         ):SizedBox(),