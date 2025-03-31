import 'package:flutter/material.dart';



class Singlebankfullviewpage extends StatefulWidget {
  const Singlebankfullviewpage({super.key});

  @override
  State<Singlebankfullviewpage> createState() => _SinglebankfullviewpageState();
}

class _SinglebankfullviewpageState extends State<Singlebankfullviewpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: Icon(Icons.arrow_back, size: 20,color: Colors.white,),
        title: Text("Abyssinya Bank",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700,color: Colors.white),),
        actions: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.005,vertical: MediaQuery.of(context).size.height*.005),
                width: MediaQuery.of(context).size.width*.225,
                height: MediaQuery.of(context).size.height*.0375,
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Colors.grey),
                  borderRadius: BorderRadius.circular(7)
                ),
                child: Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width*.015,),
                    Icon(Icons.date_range_rounded, size: 18 ,color: Colors.white.withOpacity(.75),),
                    SizedBox(width: MediaQuery.of(context).size.width*.035,),
                    Text("2015",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),)
                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width*.015,)
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*.2,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*.05,),
                Center(child: Text("Avilable Balance ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400,color: Color(0xff038722)),)),
                SizedBox(height: MediaQuery.of(context).size.height*.015,),
                Center(child: Text("\$ 350,435 ", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600,),)),
                SizedBox(height: MediaQuery.of(context).size.height*.005,),
                Center(child: Text("Saving Account", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: Color(0xff038722).withOpacity(.7)),)),
              ],
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width*.9,
            height: MediaQuery.of(context).size.height*.125,
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.05),
            decoration: BoxDecoration(
              border: Border.all(width: 1,color: Colors.grey.withOpacity(.5)),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*.02,),
                Center(
                  child: Text("10002211260373",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.02,),
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width*.02,),
                    Text("Created In: 12 -02 -2022",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),),
                    SizedBox(width: MediaQuery.of(context).size.width*.2,),
                    Text("Abbysinya Branch ",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300),),
                    SizedBox(width: MediaQuery.of(context).size.width*.02,),
                  ],
                )

              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*.035,),
          Container(
            height: MediaQuery.of(context).size.height*.465,
            color: Colors.black,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                Container(
                  height: MediaQuery.of(context).size.height*.075,
                  color: Colors.grey.withOpacity(.1),
                  child: Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width*.02,),
                      Icon(Icons.transit_enterexit_rounded,color: Colors.red,size: 25,),
                      SizedBox(width: MediaQuery.of(context).size.width*.02,),
                      Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height*.0075,),
                          Text("Paid For Expenses in",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                          SizedBox(height: MediaQuery.of(context).size.height*.0035,),
                          Text("12 - 02 -2025  11:50",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),
                        ],
                      ),

                      SizedBox(width: MediaQuery.of(context).size.width*.3,),
                      Text("-",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.red),),
                      Text("\$ 350",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)

                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.015,),
                Container(
                  height: MediaQuery.of(context).size.height*.075,
                  color: Colors.grey.withOpacity(.1),
                  child: Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width*.02,),
                      Icon(Icons.transit_enterexit_rounded,color: Colors.red,size: 25,),
                      SizedBox(width: MediaQuery.of(context).size.width*.02,),
                      Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height*.0075,),
                          Text("Paid For Expenses in",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                          SizedBox(height: MediaQuery.of(context).size.height*.0035,),
                          Text("12 - 02 -2025  11:50",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),
                        ],
                      ),

                      SizedBox(width: MediaQuery.of(context).size.width*.3,),
                      Text("-",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.red),),
                      Text("\$ 350",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)

                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.015,),
                Container(
                  height: MediaQuery.of(context).size.height*.075,
                  color: Colors.grey.withOpacity(.1),
                  child: Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width*.02,),
                      Icon(Icons.transit_enterexit_rounded,color: Colors.red,size: 25,),
                      SizedBox(width: MediaQuery.of(context).size.width*.02,),
                      Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height*.0075,),
                          Text("Paid For Expenses in",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                          SizedBox(height: MediaQuery.of(context).size.height*.0035,),
                          Text("12 - 02 -2025  11:50",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),),
                        ],
                      ),

                      SizedBox(width: MediaQuery.of(context).size.width*.3,),
                      Text("-",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.red),),
                      Text("\$ 350",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)

                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.015,),
                Container(
                  color: Theme.of(context).canvasColor,
                  width: MediaQuery.of(context).size.width*1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025,vertical: MediaQuery.of(context).size.height*.015),
                    child: Row(
                      children: [
                        Action != "Added" ? Icon(Icons.transit_enterexit,color: Colors.red,size: 15,) :  Icon(Icons.call_made,color: Colors.green,size: 15,),
                        SizedBox(width: MediaQuery.of(context).size.width*.02,),
                        Container(
                          width: MediaQuery.of(context).size.width*.68,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Transactionname",style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w300),),
                              SizedBox(height: MediaQuery.of(context).size.height*.005,),
                              Text("12 - 02 -2025 12:30PM",style: TextStyle(color: Colors.white.withOpacity(.5),fontSize: 11,fontWeight: FontWeight.w200),),
                            ],
                          ),
                        ),
                        Row(
                          children:  [
                            Text("-",style: TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold),),
                            Text("\$ 500",style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w300),)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
