import 'package:flutter/material.dart';
import 'package:flutter_application_1/Drawer/DrawerPage.dart';
import 'package:flutter_application_1/datamanager.dart';

class HomePage extends StatefulWidget {
  final Datamanager datamanager;
  const HomePage({super.key, required this.datamanager});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.menu), onPressed: (){
          _scaffoldKey.currentState?.openDrawer();
        },),
      ),
      drawer: Drawer(
        backgroundColor: Colors.transparent,
        child: Drawerpage(

        ),
      ),
      body: Column(
        children: [
          Container(child: Text("he"),),
          SizedBox(height: MediaQuery.of(context).size.height*.2),
          
          Stack(
            children: [

              
              Container(
                width: MediaQuery.of(context).size.width*.8,
                height: MediaQuery.of(context).size.height*.5,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25),bottomRight: Radius.circular(50), bottomLeft: Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      spreadRadius: 5,
                      blurRadius: 20,
                      offset: Offset(0, 10), // changes position of shadow
                    ),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height*.425,
                left: MediaQuery.of(context).size.width*.65,
                child: Container(
                  width: MediaQuery.of(context).size.width*.15,
                  height: MediaQuery.of(context).size.height*.075,
                 decoration:BoxDecoration(
                   color: Colors.white.withOpacity(.7),
                   borderRadius: BorderRadius.only( bottomRight: Radius.circular(50)),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black.withOpacity(.05),
                       spreadRadius: 5,
                       blurRadius: 20,
                       offset: Offset(0, 1), // changes position of shadow
                     ),
                   ],
                 ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
