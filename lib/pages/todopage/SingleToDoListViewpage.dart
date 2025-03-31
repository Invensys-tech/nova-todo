import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';


class Singletodolistviewpage extends StatefulWidget {
  const Singletodolistviewpage({super.key});

  @override
  State<Singletodolistviewpage> createState() => _SingletodolistviewpageState();
}

class _SingletodolistviewpageState extends State<Singletodolistviewpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.keyboard_arrow_left, color: Color(0xff0d805e),size: 30,),
        title: Text("View Single Daily task",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.01, horizontal: MediaQuery.of(context).size.width*.025),
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.01, horizontal: MediaQuery.of(context).size.width*.025),
              width: MediaQuery.of(context).size.width*.95,
              height: MediaQuery.of(context).size.height*.235,
              decoration: BoxDecoration(
                  color: Color(0xff2D2C2C),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle_outlined,size: 30,color: Colors.red,),
                      SizedBox(width: MediaQuery.of(context).size.width*.025,),
                      Text("Going to GYm",style: TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.w700),)
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.025,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("Task Date ",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Colors.white.withOpacity(.75)),),
                          SizedBox(height: MediaQuery.of(context).size.height*.000,),
                          Text("12 - 03 - 2025 ",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),),
                        ],
                      ),
                      Column(
                        children: [
                          Text("Reminded In ",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Colors.white.withOpacity(.75)),),
                          SizedBox(height: MediaQuery.of(context).size.height*.000,),
                          Text("Before 10 Min ",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),),
                        ],
                      ),
                      Column(
                        children: [
                          Text("Task Time ",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Colors.white.withOpacity(.75)),),
                          SizedBox(height: MediaQuery.of(context).size.height*.000,),
                          Text("3:00 AM - 9:00 AM ",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.025,),
                  Text(" Describtion :- Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300,color: Colors.white.withOpacity(.7)),)

                ],
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height*.025,),
            Container(
              margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.01, horizontal: MediaQuery.of(context).size.width*.025),
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.01, horizontal: MediaQuery.of(context).size.width*.025),
              width: MediaQuery.of(context).size.width*.95,
              height: MediaQuery.of(context).size.height*.335,
              decoration: BoxDecoration(
                  color: Color(0xff2D2C2C),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  Text("Sub Tasks To Do ",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),),
                  SizedBox(height: MediaQuery.of(context).size.height*.015,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RoundCheckBox(
                        onTap: null,
                        checkedWidget: Icon(Icons.check,size: 18,color: Color(0xff363636),),
                        disabledColor: Color(0xff2E8CD3),
                        isChecked: true,
                        size: 25,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width*.015,),
                      Container(
                         width: MediaQuery.of(context).size.width*.8,
                          child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300, decoration: TextDecoration.lineThrough),))
                    ],
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height*.015,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RoundCheckBox(
                        onTap: null,
                        checkedWidget: Icon(Icons.check,size: 18,color: Color(0xff363636),),
                        disabledColor: Color(0xff2E8CD3),
                        isChecked: true,
                        size: 25,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width*.015,),
                      Container(
                          width: MediaQuery.of(context).size.width*.8,
                          child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.  ",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300,  decoration: TextDecoration.lineThrough),))
                    ],
                  ),


                  SizedBox(height: MediaQuery.of(context).size.height*.015,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RoundCheckBox(
                        onTap: null,
                        border: Border.all(width: 3, color: Colors.white),
                        checkedWidget: Icon(Icons.check,size: 18,color: Color(0xff363636),),
                        disabledColor: Color(0xff363636),
                        isChecked: false,
                        size: 25,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width*.015,),
                      Container(
                          width: MediaQuery.of(context).size.width*.8,
                          child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),))
                    ],
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height*.015,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RoundCheckBox(
                        onTap: null,

                        border: Border.all(width: 3, color: Colors.white),
                        checkedWidget: Icon(Icons.check,size: 18,color: Color(0xff363636),),
                        disabledColor: Color(0xff363636),
                        isChecked: false,
                        size: 25,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width*.015,),
                      Container(
                          width: MediaQuery.of(context).size.width*.8,
                          child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.  ",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),))
                    ],
                  ),

                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.025,),

          ],
        ),
      ),
    );
  }
}
