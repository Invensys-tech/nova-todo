import 'package:flutter/material.dart';

class Drawerpage extends StatefulWidget {
  const Drawerpage({super.key});

  @override
  State<Drawerpage> createState() => _DrawerpageState();
}

class _DrawerpageState extends State<Drawerpage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.035),
      height: MediaQuery.of(context).size.height*.8,
      width: MediaQuery.of(context).size.width*.65,
      margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*.175),
      decoration: BoxDecoration(
        color: Color(0xff393838),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width*.65,
            height: MediaQuery.of(context).size.height*.15,
            child: Image.asset("assets/Images/VitaBoard.jpg",fit: BoxFit.fill,),
          ),
          SizedBox(height: MediaQuery.of(context).size.width*.025,),
          Row(
            children: [
              Icon(Icons.tab_unselected,size: 25,color: Colors.white.withOpacity(.7),),
              SizedBox(width: MediaQuery.of(context).size.width*.035,),
              Text("Habits",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),)
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width*.025,),
          Row(
            children: [
              Icon(Icons.tab_unselected,size: 25,color: Colors.white.withOpacity(.7),),
              SizedBox(width: MediaQuery.of(context).size.width*.035,),
              Text("Habits",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),)
            ],
          ), SizedBox(height: MediaQuery.of(context).size.width*.025,),
          Row(
            children: [
              Icon(Icons.tab_unselected,size: 25,color: Colors.white.withOpacity(.7),),
              SizedBox(width: MediaQuery.of(context).size.width*.035,),
              Text("Habits",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),)
            ],
          ), SizedBox(height: MediaQuery.of(context).size.width*.025,),
          Row(
            children: [
              Icon(Icons.tab_unselected,size: 25,color: Colors.white.withOpacity(.7),),
              SizedBox(width: MediaQuery.of(context).size.width*.035,),
              Text("Habits",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),)
            ],
          ), SizedBox(height: MediaQuery.of(context).size.width*.025,),
          Row(
            children: [
              Icon(Icons.tab_unselected,size: 25,color: Colors.white.withOpacity(.7),),
              SizedBox(width: MediaQuery.of(context).size.width*.035,),
              Text("Habits",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),)
            ],
          ), SizedBox(height: MediaQuery.of(context).size.width*.025,),
          Row(
            children: [
              Icon(Icons.tab_unselected,size: 25,color: Colors.white.withOpacity(.7),),
              SizedBox(width: MediaQuery.of(context).size.width*.035,),
              Text("Habits",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),)
            ],
          ), SizedBox(height: MediaQuery.of(context).size.width*.025,),
          Row(
            children: [
              Icon(Icons.tab_unselected,size: 25,color: Colors.white.withOpacity(.7),),
              SizedBox(width: MediaQuery.of(context).size.width*.035,),
              Text("Habits",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),)
            ],
          ),
        ],
      ),
    );
  }
}
