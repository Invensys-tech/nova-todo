import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class SingleEpensesFullViewPage extends StatefulWidget {
  const SingleEpensesFullViewPage({super.key});

  @override
  State<SingleEpensesFullViewPage> createState() => _SingleEpensesFullViewPageState();
}

class _SingleEpensesFullViewPageState extends State<SingleEpensesFullViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark.withOpacity(.6),
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(

             height: MediaQuery.of(context).size.height*.35,
              child: Center(),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*.58,
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.035, vertical: MediaQuery.of(context).size.height*.015),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Expenses Details ",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
                    GestureDetector(
                      onTap: (){

                        Navigator.pop(context);
                      },
                        child: FaIcon(FontAwesomeIcons.x, size: 15,))
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.035,),
                Container(
                  child: Row(
                    children: [
                      Container(

                        width: MediaQuery.of(context).size.width*.55,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Expenses Name",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                            Text("Lunch At Bole",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Amount",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                          SizedBox(height: MediaQuery.of(context).size.height*.00,),
                          Text("ETB 3,200",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                        ],
                      )

                    ],
                  ),
                ),
                Divider(),
                SizedBox(height: MediaQuery.of(context).size.height*.025,),
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*.55,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Paid Via",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                            Text("BOA",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Account Number",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                          SizedBox(height: MediaQuery.of(context).size.height*.00,),
                          Text("10023289433",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                        ],
                      )

                    ],
                  ),
                ),
                Divider(),

                SizedBox(height: MediaQuery.of(context).size.height*.025,),
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*.55,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Catagory",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                            Text("Foods And Beverages",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Type",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                          SizedBox(height: MediaQuery.of(context).size.height*.00,),
                          Row(
                            children: [
                              Icon(Icons.circle,color: Colors.red,),
                              Text("Unwanted",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                            ],
                          ),
                        ],
                      )

                    ],
                  ),
                ),
                Divider(),

                SizedBox(height: MediaQuery.of(context).size.height*.025,),
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*.55,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Date",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                            Text("12-08-2025 , 12:43 (last Week)",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
                Divider(),
                SizedBox(height: MediaQuery.of(context).size.height*.025,),
                Container(
                  child: Row(
                    children: [
                      Container(

                        width: MediaQuery.of(context).size.width*.93,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Addtional Note",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                            Text("lorem Ipsume is the one and only in the best way to include int he best way to intemisate but ",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
                Divider()
              ],
            ),
          )
        ],
      ),
    );
  }
}
