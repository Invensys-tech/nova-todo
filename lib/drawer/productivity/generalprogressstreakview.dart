import 'package:flutter/material.dart';


class Generalprogressstreakview extends StatefulWidget {
  const Generalprogressstreakview({super.key});

  @override
  State<Generalprogressstreakview> createState() => _GeneralprogressstreakviewState();
}

class _GeneralprogressstreakviewState extends State<Generalprogressstreakview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        shape: Border(
          bottom: BorderSide(
            color: Colors.white, // Border color
            width: 1, // Border width
          ),
        ),
        title: Text("12/03/2025 - 21/03/2025",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
        actions: [
          Row(
            children: [
              Icon(Icons.local_fire_department_rounded,size: 25,color: Colors.orange,),
              SizedBox(width: MediaQuery.of(context).size.width*.013,),
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.00),
                child: Text("2 Weeks",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
              ),
              SizedBox(width: MediaQuery.of(context).size.width*.0125,)
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Biceps training ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                      Text("10/15/2025",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.white.withOpacity(.7)),)
                    ],
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Biceps training ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                      Text("10/15/2025",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.white.withOpacity(.7)),)
                    ],
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Biceps training ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                      Text("10/15/2025",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.white.withOpacity(.7)),)
                    ],
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Biceps training ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                      Text("10/15/2025",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.white.withOpacity(.7)),)
                    ],
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Biceps training ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                      Text("10/15/2025",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.white.withOpacity(.7)),)
                    ],
                  ),
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
      ),
    );
  }
}
