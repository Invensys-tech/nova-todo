import 'package:flutter/material.dart';
import 'package:flutter_application_1/Drawer/Productivity%20/GeneralProgressStreakView.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';



class Generalprogress extends StatefulWidget {
  const Generalprogress({super.key});

  @override
  State<Generalprogress> createState() => _GeneralprogressState();
}

class _GeneralprogressState extends State<Generalprogress> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*.0075,),
          GestureDetector(
            onTap: (){
              PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                context,
                screen: Generalprogressstreakview(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino, settings: const RouteSettings(),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width*.935,
              height: MediaQuery.of(context).size.height*.085,
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.015, vertical: MediaQuery.of(context).size.height*.0075),
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.015),
              decoration: BoxDecoration(
                color: Color(0xff292929),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("12/03/2025 - 21/03/2025" ,style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),
                      SizedBox(height: MediaQuery.of(context).size.height*.005,),
                      Text("6 Days Per Week" ,style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),

                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*.225,),
                  Icon(Icons.local_fire_department_rounded,size: 35,color: Colors.orange,),
                  SizedBox(width: MediaQuery.of(context).size.width*.013,),
                  Padding(
                    padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.0095),
                    child: Text("2 Weeks",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width*.935,
            height: MediaQuery.of(context).size.height*.085,
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.015, vertical: MediaQuery.of(context).size.height*.0075),
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.015),
            decoration: BoxDecoration(
                color: Color(0xff292929),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("12/03/2025 - 21/03/2025" ,style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),
                    SizedBox(height: MediaQuery.of(context).size.height*.005,),
                    Text("6 Days Per Week" ,style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),
      
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width*.225,),
                Icon(Icons.local_fire_department_rounded,size: 35,color: Colors.orange,),
                SizedBox(width: MediaQuery.of(context).size.width*.013,),
                Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.0095),
                  child: Text("2 Weeks",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width*.935,
            height: MediaQuery.of(context).size.height*.085,
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.015, vertical: MediaQuery.of(context).size.height*.0075),
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.015),
            decoration: BoxDecoration(
                color: Color(0xff292929),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("12/03/2025 - 21/03/2025" ,style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),
                    SizedBox(height: MediaQuery.of(context).size.height*.005,),
                    Text("6 Days Per Week" ,style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),
      
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width*.225,),
                Icon(Icons.local_fire_department_rounded,size: 35,color: Colors.orange,),
                SizedBox(width: MediaQuery.of(context).size.width*.013,),
                Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.0095),
                  child: Text("2 Weeks",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width*.935,
            height: MediaQuery.of(context).size.height*.085,
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.015, vertical: MediaQuery.of(context).size.height*.0075),
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.015),
            decoration: BoxDecoration(
                color: Color(0xff292929),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("12/03/2025 - 21/03/2025" ,style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),
                    SizedBox(height: MediaQuery.of(context).size.height*.005,),
                    Text("6 Days Per Week" ,style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),
      
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width*.225,),
                Icon(Icons.local_fire_department_rounded,size: 35,color: Colors.orange,),
                SizedBox(width: MediaQuery.of(context).size.width*.013,),
                Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.0095),
                  child: Text("2 Weeks",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                )
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*.0225,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Catagories",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
      
                Text("See All",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),)
              ],
            ),
          ),
      
          Container(
            width: MediaQuery.of(context).size.width*.935,
            height: MediaQuery.of(context).size.height*.075,
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.015, vertical: MediaQuery.of(context).size.height*.0075),
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.015),
            decoration: BoxDecoration(
                color: Color(0xff393838),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Biceps Workout ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, ),),
                Text("10 Sub tasks ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, ),)
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width*.935,
            height: MediaQuery.of(context).size.height*.075,
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.015, vertical: MediaQuery.of(context).size.height*.0075),
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.015),
            decoration: BoxDecoration(
                color: Color(0xff393838),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Biceps Workout ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, ),),
                Text("10 Sub tasks ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, ),)
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width*.935,
            height: MediaQuery.of(context).size.height*.075,
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.015, vertical: MediaQuery.of(context).size.height*.0075),
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.015),
            decoration: BoxDecoration(
                color: Color(0xff393838),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Biceps Workout ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, ),),
                Text("10 Sub tasks ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, ),)
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width*.935,
            height: MediaQuery.of(context).size.height*.075,
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.015, vertical: MediaQuery.of(context).size.height*.0075),
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.015),
            decoration: BoxDecoration(
                color: Color(0xff393838),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Biceps Workout ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, ),),
                Text("10 Sub tasks ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, ),)
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
