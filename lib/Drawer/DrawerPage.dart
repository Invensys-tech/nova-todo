import 'package:flutter/material.dart';
import 'package:flutter_application_1/Drawer/Productivity%20/ProductivityViewPsge.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

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
          SizedBox(height: MediaQuery.of(context).size.height*.03,),
          Container(
            width: MediaQuery.of(context).size.width*.5,
            height: MediaQuery.of(context).size.height*.075,
            child: Image.asset("assets/Images/VitaImage1.png",fit: BoxFit.contain,),
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
          GestureDetector(
            onTap: (){

              PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                context,
                screen: ProductivityViewPgae(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino, settings: const RouteSettings(),
              );
            },
            child: Row(
              children: [
                FaIcon(FontAwesomeIcons.users,size: 20,color: Colors.white.withOpacity(.7),),
                SizedBox(width: MediaQuery.of(context).size.width*.035,),
                Text("Productivity",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),)
              ],
            ),
          ), SizedBox(height: MediaQuery.of(context).size.width*.025,),
          Row(
            children: [
               FaIcon(FontAwesomeIcons.gamepad,size: 25,color: Colors.white.withOpacity(.7),),
              SizedBox(width: MediaQuery.of(context).size.width*.035,),
              Text("Quotes",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),)
            ],
          ), SizedBox(height: MediaQuery.of(context).size.width*.025,),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.users,size: 20,color: Colors.white.withOpacity(.7),),
              SizedBox(width: MediaQuery.of(context).size.width*.035,),
              Text("Community Challenges",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),)
            ],
          ), SizedBox(height: MediaQuery.of(context).size.width*.025,),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.users,size: 20,color: Colors.white.withOpacity(.7),),
              SizedBox(width: MediaQuery.of(context).size.width*.035,),
              Text("Notification",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),)
            ],
          ), SizedBox(height: MediaQuery.of(context).size.width*.025,),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.users,size: 20,color: Colors.white.withOpacity(.7),),
              SizedBox(width: MediaQuery.of(context).size.width*.035,),
              Text("Prcing",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),)
            ],
          ), SizedBox(height: MediaQuery.of(context).size.width*.025,),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.users,size: 20,color: Colors.white.withOpacity(.7),),
              SizedBox(width: MediaQuery.of(context).size.width*.035,),
              Text("Seeting ",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),)
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width*.025,),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.streetView,size: 20,color: Colors.white.withOpacity(.7),),
              SizedBox(width: MediaQuery.of(context).size.width*.035,),
              Text("Profile ",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),)
            ],
          ),
        ],
      ),
    );
  }
}
