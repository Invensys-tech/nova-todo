import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:ethiopian_datetime/ethiopian_datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/goal/common/testgoal.dart';
import 'package:flutter_application_1/pages/todopage/SingleToDoListViewpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    ETDateTime noww = ETDateTime.now();


    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu,size: 27, color: Colors.white,),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF2b2d30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Rounded corners
        ),
        onPressed: () {

        },
        child: Icon(Icons.add), // The icon inside the button
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          SizedBox(height: MediaQuery.of(context).size.height * .015),
          CalendarTimeline(
            initialDate: ETDateTime.now(),
            firstDate: noww,
            lastDate: DateTime(2027, 11, 20),
            onDateSelected: (date) {
              print(ETDateFormat("dd-MMMM-yyyy HH:mm:ss").format(noww));
            },

            leftMargin: 20,
            showYears: false,
            monthColor: Colors.blueGrey,
            dayColor: Colors.teal[200],
            activeDayColor: Colors.white,
            activeBackgroundDayColor: Colors.grey,
            shrink: true,
            locale: 'en_ISO',
          ),


              SizedBox(height: MediaQuery.of(context).size.height*.025,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 15),
            child: new LinearPercentIndicator(
              width: MediaQuery.of(context).size.width*.9,
              animation: true,
              lineHeight: MediaQuery.of(context).size.height*.01,
              animationDuration: 2500,
              percent: 0.8,
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Color(0xff0d805e),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width*.065),
            child: Text("80.0% of the work is done ",style: TextStyle(color: Colors.white,fontSize: 15),),
          ),

              SizedBox(height: MediaQuery.of(context).size.height*.025,),
              Padding(
                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.05, vertical: MediaQuery.of(context).size.height*.015),
                      width: MediaQuery.of(context).size.width*.93,
                      decoration: BoxDecoration(
                          color:  Color(0xff0d805e).withOpacity(.35),
                          borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black, // Shadow color with opacity
                            spreadRadius: 2, // How much the shadow spreads
                            blurRadius: 10, // Softens the shadow
                            offset: Offset(-4, 0), // Moves shadow right & down
                          ),
                        ],
                      ),
                     child: Column(
                       children: [
                         Center(
                           child: Text("Add Daily Journal ",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),),
                         ),
                         SizedBox(height: MediaQuery.of(context).size.height*.015,),
                         Row(
                           children: [
                             Icon(Icons.do_not_disturb_on_total_silence,color: Colors.white.withOpacity(.8),size: 20,),
                             SizedBox(width: MediaQuery.of(context).size.width*.015,),
                             Text("Things you face Today",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.white.withOpacity(.8)),)
                           ],
                         ),SizedBox(height: MediaQuery.of(context).size.height*.005,),
                         Row(
                           children: [
                             Icon(Icons.do_not_disturb_on_total_silence,color: Colors.white.withOpacity(.8),size: 20,),
                             SizedBox(width: MediaQuery.of(context).size.width*.015,),
                             Text("Ypur thinking and assumptions ",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.white.withOpacity(.8)),)
                           ],
                         ),SizedBox(height: MediaQuery.of(context).size.height*.005,),
                         Row(
                           children: [
                             Icon(Icons.do_not_disturb_on_total_silence,color: Colors.white.withOpacity(.8),size: 20,),
                             SizedBox(width: MediaQuery.of(context).size.width*.015,),
                             Text("How was the day what needs to improve",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.white.withOpacity(.8)),)
                           ],
                         ),
                         SizedBox(height: MediaQuery.of(context).size.height*.005,),
                         Row(
                           children: [
                             Icon(Icons.do_not_disturb_on_total_silence,color: Colors.white.withOpacity(.8),size: 20,),
                             SizedBox(width: MediaQuery.of(context).size.width*.015,),
                             Text("What did you learn today",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.white.withOpacity(.8)),)
                           ],
                         ),
                       ],
                     ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  ],
                ),
              ),

              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Singletodolistviewpage()),
                  );
                },
                child: Padding(
                  padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.05, vertical: MediaQuery.of(context).size.height*.015),
                        width: MediaQuery.of(context).size.width*.93,
                        decoration: BoxDecoration(
                            color:  Color(0xff0d805e).withOpacity(.35),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text( "Title Of the ToDoLisr",style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600),),
                                Text("3:00AM - 4:00PM", style:  GoogleFonts.lato(fontSize: 14 , fontWeight: FontWeight.w400, color: Colors.white.withOpacity(.75)),)
                              ],
                            ),

                            SizedBox(height: MediaQuery.of(context).size.height*.0125,),
                            Text( "Just do what you have to do inorder to do the best you think ypu can do in that but ",style: GoogleFonts.lato(fontSize: 12 , fontWeight: FontWeight.w400, color: Colors.white.withOpacity(.8)),),

                            SizedBox(height: MediaQuery.of(context).size.height*.015,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.lock_clock, size: 20, color: Colors.white,) ,
                                Row(
                                  children: [
                                    Text("Status : ",style: GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w500),),
                                    Text("Waiting",style: GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w500 ,color: Colors.yellow),),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: MediaQuery.of(context).size.height*.01,),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.02,),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.05, vertical: MediaQuery.of(context).size.height*.015),
                      width: MediaQuery.of(context).size.width*.93,
                      decoration: BoxDecoration(
                          color:  Color(0xff0d805e).withOpacity(.35),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text( "Title Of the ToDoList",style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600),),
                              Text("3:00AM - 4:00PM", style:  GoogleFonts.lato(fontSize: 14 , fontWeight: FontWeight.w400, color: Colors.white.withOpacity(.75)),)
                            ],
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height*.0125,),
                          Text( "Just do what you have to do inorder to do the best you think ypu can do in that but ",style: GoogleFonts.lato(fontSize: 12 , fontWeight: FontWeight.w400, color: Colors.white.withOpacity(.8)),),

                          SizedBox(height: MediaQuery.of(context).size.height*.015,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.lock_clock, size: 20, color: Colors.white,) ,
                              Row(
                                children: [
                                  Text("Status : ",style: GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w500),),
                                  Text("Waiting",style: GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w500 ,color: Colors.yellow),),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height*.01,),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  ],
                ),
              ),






              Padding(
                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.05, vertical: MediaQuery.of(context).size.height*.015),
                      width: MediaQuery.of(context).size.width*.93,
                      decoration: BoxDecoration(
                          color:  Color(0xff0d805e).withOpacity(.35),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text( "Title Of the ToDoList",style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600),),
                              Text("3:00AM - 4:00PM", style:  GoogleFonts.lato(fontSize: 14 , fontWeight: FontWeight.w400, color: Colors.white.withOpacity(.75)),)
                            ],
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height*.0125,),
                          Text( "Just do what you have to do inorder to do the best you think ypu can do in that but ",style: GoogleFonts.lato(fontSize: 12 , fontWeight: FontWeight.w400, color: Colors.white.withOpacity(.8)),),

                          SizedBox(height: MediaQuery.of(context).size.height*.015,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.lock_clock, size: 20, color: Colors.white,) ,
                              Row(
                                children: [
                                  Text("Status : ",style: GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w500),),
                                  Text("Waiting",style: GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w500 ,color: Colors.yellow),),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height*.01,),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
                  ],
                ),
              ),
        ]),
      ),
    );
  }



}


