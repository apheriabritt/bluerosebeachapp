import 'package:flutter/material.dart';

class Storys

{

  String date,description,image1,image2,image3,image4,image5,time;
  int order,storyid;

  Storys(this.date,this.description,this.image1,this.image2,this.image3,this.image4,this.image5,this.time,this.order,this.storyid);


}

class Shops

{

  String date,description,image1,image2,image3,image4,image5,time;
  int order,shopid;

  Shops(this.date,this.description,this.image1,this.image2,this.image3,this.image4,this.image5,this.time,this.order,this.shopid);


}

var gradientBox = BoxDecoration(
  boxShadow: [BoxShadow(
    color: Colors.white.withOpacity(0.2),
    offset: Offset(0.0, 1.0), //(x,y)
    blurRadius: 0.0,
  )],
  borderRadius: BorderRadius.only(
    topLeft: const Radius.circular(40.0),
    topRight: const Radius.circular(40.0),
    bottomRight: const Radius.circular(40.0),
    bottomLeft: const Radius.circular(40.0),
  ),
  gradient: LinearGradient(colors: [Color(0xff98C7E3),Color(0xff1B8DC9)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.1,1.0]),
);