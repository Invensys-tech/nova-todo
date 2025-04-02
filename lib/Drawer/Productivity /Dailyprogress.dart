import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:ethiopian_datetime/ethiopian_datetime.dart';
import 'package:flutter/material.dart';


class DailyprogressLists extends StatefulWidget {
  const DailyprogressLists({super.key});

  @override
  State<DailyprogressLists> createState() => _DailyprogressListsState();
}

class _DailyprogressListsState extends State<DailyprogressLists> {

  ETDateTime noww = ETDateTime.now();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
          SizedBox(height: MediaQuery.of(context).size.height*.0125),
          Container(
            margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.015, horizontal: MediaQuery.of(context).size.width*.025),
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.015, horizontal: MediaQuery.of(context).size.width*.045),
            height: MediaQuery.of(context).size.height*.25,
            width: MediaQuery.of(context).size.width*.925,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff626262).withOpacity(.5),
              border: Border.all(width: 1,color: Colors.white.withOpacity(.3))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Biceps training ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.005),
                child: Row(
                  children: [
                    Icon(Icons.circle,size: 14,color: Colors.white.withOpacity(.85),),
                    SizedBox(width: MediaQuery.of(context).size.width*.01,),
                    Text("Barbel Curl with 25 Kg ---  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                    Text("2 sets 10 reps  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),),
                  ],
                )),
      
                Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.005),
                    child: Row(
                      children: [
                        Icon(Icons.circle,size: 14,color: Colors.white.withOpacity(.85),),
                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                        Text("Barbel Curl with 25 Kg ---  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        Text("2 sets 10 reps  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),),
                      ],
                    )),
                Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.005),
                    child: Row(
                      children: [
                        Icon(Icons.circle,size: 14,color: Colors.white.withOpacity(.85),),
                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                        Text("Barbel Curl with 25 Kg ---  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        Text("2 sets 10 reps  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),),
                      ],
                    )),
                Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.005),
                    child: Row(
                      children: [
                        Icon(Icons.circle,size: 14,color: Colors.white.withOpacity(.85),),
                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                        Text("Barbel Curl with 25 Kg ---  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        Text("2 sets 10 reps  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),),
                      ],
                    )),
                Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.005),
                    child: Row(
                      children: [
                        Icon(Icons.circle,size: 14,color: Colors.white.withOpacity(.85),),
                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                        Text("Barbel Curl with 25 Kg ---  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        Text("2 sets 10 reps  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),),
                      ],
                    ))
              ],
            ),
          ),
      
          Container(
            margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.015, horizontal: MediaQuery.of(context).size.width*.025),
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.015, horizontal: MediaQuery.of(context).size.width*.045),
            height: MediaQuery.of(context).size.height*.25,
            width: MediaQuery.of(context).size.width*.925,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff626262).withOpacity(.5),
                border: Border.all(width: 1,color: Colors.white.withOpacity(.3))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Biceps training ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.005),
                    child: Row(
                      children: [
                        Icon(Icons.circle,size: 14,color: Colors.white.withOpacity(.85),),
                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                        Text("Barbel Curl with 25 Kg ---  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        Text("2 sets 10 reps  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),),
                      ],
                    )),
      
                Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.005),
                    child: Row(
                      children: [
                        Icon(Icons.circle,size: 14,color: Colors.white.withOpacity(.85),),
                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                        Text("Barbel Curl with 25 Kg ---  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        Text("2 sets 10 reps  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),),
                      ],
                    )),
                Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.005),
                    child: Row(
                      children: [
                        Icon(Icons.circle,size: 14,color: Colors.white.withOpacity(.85),),
                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                        Text("Barbel Curl with 25 Kg ---  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        Text("2 sets 10 reps  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),),
                      ],
                    )),
                Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.005),
                    child: Row(
                      children: [
                        Icon(Icons.circle,size: 14,color: Colors.white.withOpacity(.85),),
                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                        Text("Barbel Curl with 25 Kg ---  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        Text("2 sets 10 reps  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),),
                      ],
                    )),
                Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.005),
                    child: Row(
                      children: [
                        Icon(Icons.circle,size: 14,color: Colors.white.withOpacity(.85),),
                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                        Text("Barbel Curl with 25 Kg ---  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        Text("2 sets 10 reps  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),),
                      ],
                    ))
              ],
            ),
          ),
      
          Container(
            margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.015, horizontal: MediaQuery.of(context).size.width*.025),
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.015, horizontal: MediaQuery.of(context).size.width*.045),
            height: MediaQuery.of(context).size.height*.25,
            width: MediaQuery.of(context).size.width*.925,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff626262).withOpacity(.5),
                border: Border.all(width: 1,color: Colors.white.withOpacity(.3))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Biceps training ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.005),
                    child: Row(
                      children: [
                        Icon(Icons.circle,size: 14,color: Colors.white.withOpacity(.85),),
                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                        Text("Barbel Curl with 25 Kg ---  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        Text("2 sets 10 reps  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),),
                      ],
                    )),
      
                Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.005),
                    child: Row(
                      children: [
                        Icon(Icons.circle,size: 14,color: Colors.white.withOpacity(.85),),
                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                        Text("Barbel Curl with 25 Kg ---  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        Text("2 sets 10 reps  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),),
                      ],
                    )),
                Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.005),
                    child: Row(
                      children: [
                        Icon(Icons.circle,size: 14,color: Colors.white.withOpacity(.85),),
                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                        Text("Barbel Curl with 25 Kg ---  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        Text("2 sets 10 reps  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),),
                      ],
                    )),
                Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.005),
                    child: Row(
                      children: [
                        Icon(Icons.circle,size: 14,color: Colors.white.withOpacity(.85),),
                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                        Text("Barbel Curl with 25 Kg ---  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        Text("2 sets 10 reps  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),),
                      ],
                    )),
                Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.005),
                    child: Row(
                      children: [
                        Icon(Icons.circle,size: 14,color: Colors.white.withOpacity(.85),),
                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                        Text("Barbel Curl with 25 Kg ---  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        Text("2 sets 10 reps  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),),
                      ],
                    ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.015, horizontal: MediaQuery.of(context).size.width*.025),
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.015, horizontal: MediaQuery.of(context).size.width*.045),
            height: MediaQuery.of(context).size.height*.25,
            width: MediaQuery.of(context).size.width*.925,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff626262).withOpacity(.5),
                border: Border.all(width: 1,color: Colors.white.withOpacity(.3))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Biceps training ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.005),
                    child: Row(
                      children: [
                        Icon(Icons.circle,size: 14,color: Colors.white.withOpacity(.85),),
                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                        Text("Barbel Curl with 25 Kg ---  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        Text("2 sets 10 reps  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),),
                      ],
                    )),
      
                Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.005),
                    child: Row(
                      children: [
                        Icon(Icons.circle,size: 14,color: Colors.white.withOpacity(.85),),
                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                        Text("Barbel Curl with 25 Kg ---  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        Text("2 sets 10 reps  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),),
                      ],
                    )),
                Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.005),
                    child: Row(
                      children: [
                        Icon(Icons.circle,size: 14,color: Colors.white.withOpacity(.85),),
                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                        Text("Barbel Curl with 25 Kg ---  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        Text("2 sets 10 reps  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),),
                      ],
                    )),
                Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.005),
                    child: Row(
                      children: [
                        Icon(Icons.circle,size: 14,color: Colors.white.withOpacity(.85),),
                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                        Text("Barbel Curl with 25 Kg ---  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        Text("2 sets 10 reps  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),),
                      ],
                    )),
                Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.005),
                    child: Row(
                      children: [
                        Icon(Icons.circle,size: 14,color: Colors.white.withOpacity(.85),),
                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                        Text("Barbel Curl with 25 Kg ---  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        Text("2 sets 10 reps  ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.green),),
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
