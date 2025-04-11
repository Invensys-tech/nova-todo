import 'package:flutter/material.dart';
import 'package:flutter_application_1/Drawer/Productivity%20/ProductivityViewPsge.dart';
import 'package:flutter_application_1/Drawer/SeetingPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Drawerpage extends StatefulWidget {
  const Drawerpage({super.key});

  @override
  State<Drawerpage> createState() => _DrawerpageState();
}

class _DrawerpageState extends State<Drawerpage> {


  bool isDark = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loabThemeApp();
  }
  Future<void> loabThemeApp() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDark = prefs.getBool('ThemeOfApp')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.035),
      height: MediaQuery.of(context).size.height*.8,
      width: MediaQuery.of(context).size.width*.65,
      margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width*.175),
      decoration: BoxDecoration(
        color:  Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))
      ),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*.03,),
          Hero(
              tag: 'unique_tag_1',
              child: Image.asset("assets/Images/VitaImage1.png",fit: BoxFit.contain,width: MediaQuery.of(context).size.width*.5,
                height: MediaQuery.of(context).size.height*.075,)),
          SizedBox(height: MediaQuery.of(context).size.width*.025,),

          Row(
            children: [
              Icon(Icons.tab_unselected,size: 17,color: Theme.of(context).unselectedWidgetColor,),
              SizedBox(width: MediaQuery.of(context).size.width*.035,),
              Text("Habits",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: Theme.of(context).unselectedWidgetColor ),)
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width*.015,),
          Divider(),
          SizedBox(height: MediaQuery.of(context).size.width*.015,),
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
                FaIcon(FontAwesomeIcons.wpexplorer,size: 17, color: Theme.of(context).unselectedWidgetColor,),
                SizedBox(width: MediaQuery.of(context).size.width*.035,),
                Text("Productivity",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Theme.of(context).unselectedWidgetColor),)
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width*.015,),
          Divider(),
          SizedBox(height: MediaQuery.of(context).size.width*.015,),
          Row(
            children: [
               FaIcon(FontAwesomeIcons.spinner,size: 17, color: Theme.of(context).unselectedWidgetColor, ),
              SizedBox(width: MediaQuery.of(context).size.width*.035,),
              Text("Quotes",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Theme.of(context).unselectedWidgetColor),)
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width*.015,),
          Divider(),
          SizedBox(height: MediaQuery.of(context).size.width*.015,),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.users,size: 17, color: Theme.of(context).unselectedWidgetColor ,),
              SizedBox(width: MediaQuery.of(context).size.width*.035,),
              Text("Community Challenges",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Theme.of(context).unselectedWidgetColor),)
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width*.015,),
          Divider(),
          SizedBox(height: MediaQuery.of(context).size.width*.015,),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.bell,size: 17, color: Theme.of(context).unselectedWidgetColor ,),
              SizedBox(width: MediaQuery.of(context).size.width*.035,),
              Text("Notification",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Theme.of(context).unselectedWidgetColor),)
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width*.015,),
          Divider(),
          SizedBox(height: MediaQuery.of(context).size.width*.015,),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.moneyBill1Wave,size: 17, color: Theme.of(context).unselectedWidgetColor ,),
              SizedBox(width: MediaQuery.of(context).size.width*.035,),
              Text("Prcing",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Theme.of(context).unselectedWidgetColor),)
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width*.015,),
          Divider(),
          SizedBox(height: MediaQuery.of(context).size.width*.015,),
          GestureDetector(
            onTap: (){
              PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                context,
                screen: Seetingpage(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino, settings: const RouteSettings(),
              );
            },
            child: Row(
              children: [
                FaIcon(FontAwesomeIcons.cogs,size: 17,color: Theme.of(context).unselectedWidgetColor ,),
                SizedBox(width: MediaQuery.of(context).size.width*.035,),
                Text("Seeting ",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Theme.of(context).unselectedWidgetColor),)
              ],
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.width*.015,),
          Divider(),
          SizedBox(height: MediaQuery.of(context).size.width*.015,),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.streetView,size: 17, color: Theme.of(context).unselectedWidgetColor ,),
              SizedBox(width: MediaQuery.of(context).size.width*.035,),
              Text("Profile ",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Theme.of(context).unselectedWidgetColor),)
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height*.15,),
          Divider(height: 1,color: Colors.white,),
          SizedBox(height: MediaQuery.of(context).size.height*.015,),
          Center(child: Text("V1.VitaDailyTracker 02042-025"))

        ],
      ),
    );
  }
}
