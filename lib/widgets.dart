import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getway/institutiondetails.dart';
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
  const InputText({required this.hint, this.icon = null, this.email=false, this.pass = false, super.key, this.text='', this.maxLine=1, this.label});

  @override
  Widget build(BuildContext context) {

    final _nameController = TextEditingController();
    _nameController.text = text;


    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(255, 255, 255, 255)
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        maxLines: maxLine,
        controller: _nameController,
        autocorrect: false,
        autofillHints: null,
        obscureText: pass,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis,),
        cursorColor: Colors.green,
        showCursor: true,
        cursorWidth:1.0,
        keyboardType: email?TextInputType.emailAddress:TextInputType.text,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: icon,
          prefixStyle: TextStyle(),
          hintText: hint,
          label: label!=null?Text(label!):null,
          hintStyle: TextStyle(fontSize: 18, color: Colors.black45,)
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
        color: Color.fromARGB(255, 76, 194, 80),
        borderRadius: BorderRadius.circular(50)
      ),
      padding: EdgeInsets.symmetric(vertical: mini?10:15, horizontal: mini?20:30),
      width: mini?null:double.infinity,
      child: Text(text, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center,),
    );
  }
}

class TitleText extends StatelessWidget {
  final String text;
  const TitleText({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style:TextStyle(fontSize: 20, color: Color.fromARGB(197, 0, 0, 0)));
  }
}

class TopInstCard extends StatelessWidget {
  final String name;
  final int? count;
  const TopInstCard({this.count, required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Color.fromARGB(74, 0, 0, 0),
                          blurRadius: 8.0,
                          offset: Offset(0.0, 1)
                      ),
                    ],
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: AssetImage('assets/img/sample_place.jpg',), fit: BoxFit.cover)
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
  const NearbyInstCard({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
         boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Color.fromARGB(36, 0, 0, 0),
                          blurRadius: 5.0,
                          spreadRadius: 2,
                          offset: Offset(0.0, 0.75)
                      ),
                    ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage('assets/img/sample_place.jpg'),
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
                child: Icon(Icons.arrow_back_ios_new_rounded, size: 20,)
              ),
              SizedBox(width: 30,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 300, child: Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),)),
                  subTitle != null? Container(width: 300, child: Text(subTitle!, style: TextStyle(fontSize: 16, color: Colors.black54, overflow: TextOverflow.ellipsis),)):SizedBox(),
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
                margin: EdgeInsets.only(top: 130, right: 30, left: 30),
                decoration: BoxDecoration(
                  color : Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(blurRadius: 3.0, color: Color.fromARGB(255, 245, 245, 245), spreadRadius: 0.0),
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
                            Text('Naipunnya institute of management and information Technology',maxLines: 1, style: TextStyle(fontSize: 16, color: Colors.black87, overflow: TextOverflow.ellipsis,),textAlign: TextAlign.center,),
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

class BannerCard extends StatelessWidget {
  const BannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(top: 130, right: 30, left: 30),
      decoration: BoxDecoration(
        color : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(blurRadius: 3.0, color: Color.fromARGB(255, 245, 245, 245), spreadRadius: 0.0),
        ],
        image: DecorationImage(
          image: AssetImage('assets/img/sample_place.jpg',),
          fit: BoxFit.cover
        )
      ),
    );
  }
}

class InstCard extends StatelessWidget {
  const InstCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
                child: Text('Naipunnya Institute of Managment and Information Teechnology', style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis), maxLines: 3,)
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
              image: DecorationImage(image: AssetImage('assets/img/sample_place.jpg'), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(15),
              color: Colors.red
            ),
          )
        ],
      ),
    );
  }
}

class DivCard extends StatelessWidget {
  final Image image;
  final int count;
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
            Text(count.toString(), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),),
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
        color: warning? Color.fromARGB(255, 255, 237, 237): Color.fromRGBO(241, 255, 242, 1)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
        child: Text(text, style: TextStyle(color: warning? Color.fromARGB(255, 186, 43, 33): Colors.green, fontWeight: FontWeight.bold, fontSize: 16),textAlign: TextAlign.center,),
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
        arrow?Icon(Icons.arrow_forward_ios_rounded, size: 18,):SizedBox()
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
      title: Text('Exit!'),
      content: Text('Do you want to exit?'),
      actions: [
        TextButton(onPressed: (){}, child: Text('No', style: TextStyle(fontSize: 18),), ),
        TextButton(onPressed: (){}, child: Text('Yes', style: TextStyle(fontSize: 18),), )
      ],
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white
    );
  }
}