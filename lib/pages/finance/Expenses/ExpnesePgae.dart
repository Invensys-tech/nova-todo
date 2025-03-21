import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:ethiopian_datetime/ethiopian_datetime.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Expensespage extends StatefulWidget {
  const Expensespage({super.key});

  @override
  State<Expensespage> createState() => _ExpensespageState();
}

class _ExpensespageState extends State<Expensespage> {

  ETDateTime noww = ETDateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF2b2d30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Rounded corners
        ),
        onPressed: () {
          // Action when pressed
          print('Floating Action Button Pressed');
        },
        child: Icon(Icons.add), // The icon inside the button
      ),
     body: Column(
       children: [
         SizedBox(height: MediaQuery.of(context).size.height*.015,),
         CalendarTimeline(
           initialDate: ETDateTime.now(),
           firstDate: noww,
           lastDate: DateTime(2027, 11, 20),
           onDateSelected: (date){
             print(ETDateFormat("dd-MMMM-yyyy HH:mm:ss")
                 .format(noww));
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
         Column(
           children: [
             Padding(

               padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*.02),
               child: Container(
                 padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*.0,bottom: MediaQuery.of(context).size.height*.015),
                 height: MediaQuery.of(context).size.height*.1175,
                 width: MediaQuery.of(context).size.width*.9,
                 decoration: BoxDecoration(
                     color: Colors.black38,
                     borderRadius: BorderRadius.circular(15)
                 ),
                 child: Stack(
                   children: [

                     Positioned(
                       right:-78,
                       child: Container(
                         height: MediaQuery.of(context).size.height*.07,
                         width: MediaQuery.of(context).size.width*.25,
                         decoration: const BoxDecoration(

                         ),
                       ),
                     ),

                     Column(
                       children: [
                         SizedBox(height: MediaQuery.of(context).size.height*.015,),
                         Padding(
                           padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*.22),
                           child: Center(
                             child: Row(
                               children: [
                                 Icon(Icons.trending_up_outlined,color: Color(0xff0d805e),size: 25,),
                                 SizedBox(width: MediaQuery.of(context).size.width*.035,),
                                 Text("\$ 15,000 ETB",style: GoogleFonts.lato(fontWeight: FontWeight.w600,fontSize: 20,),),
                               ],
                             ),
                           ),
                         ),
                         Divider(color: Colors.white70,),
                         SizedBox(height: MediaQuery.of(context).size.height*.005,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             SizedBox(width: MediaQuery.of(context).size.width*.0155,),
                             Container(
                               width: MediaQuery.of(context).size.width*.275,
                               child: Row(
                                 children: [
                                   Icon(Icons.do_not_disturb_on_total_silence_outlined,size: 15,color: Colors.red,),
                                   SizedBox(width: MediaQuery.of(context).size.width*.015,),
                                   Text("\$ 45,000",style: GoogleFonts.lato(fontSize: 13 , color: Colors.red,fontWeight: FontWeight.w600),)
                                 ],
                               ),
                             ),

                             Container(
                                 width: MediaQuery.of(context).size.width*.275,
                                 child:
                                 Row(
                                   children: [
                                     Icon(Icons.do_not_disturb_on_total_silence_outlined,size: 15,color: Colors.deepOrangeAccent,),
                                     SizedBox(width: MediaQuery.of(context).size.width*.015,),
                                     Text("\$ 35,000",style: GoogleFonts.lato(fontSize: 13 , color: Colors.deepOrangeAccent,fontWeight: FontWeight.w600),)
                                   ],
                                 )
                             ),


                             Container(
                               width: MediaQuery.of(context).size.width*.275,
                               child: Row(
                                 children: [
                                   Icon(Icons.do_not_disturb_on_total_silence_outlined,size: 15,color: Color(0xff0d805e),),
                                   SizedBox(width: MediaQuery.of(context).size.width*.015,),
                                   Text("\$ 17,500",style: GoogleFonts.lato(fontSize: 13 , color: Color(0xff0d805e),fontWeight: FontWeight.w600),)
                                 ],
                               ),
                             )
                           ],
                         ),
                       ],
                     ),
                   ],
                 ),
               ),
             ),
             SizedBox(height: MediaQuery.of(context).size.height*.025,),


           ],
         ),

         Expenseslist("Must Expenses",  " Where did you go ",  " Transort " ,  " 1500"),
         Expenseslist("MayBe Expenses",  " Senay ye senay ",  " Tsedale " ,  " 1500"),
         Expenseslist("Must Expenss",  " Where did you go ",  " Transort " ,  " 1500"),
    ],
     ),
    );
  }



  Expenseslist(String typeofexpenses , String titleofExpenses , String catagoryofexpenses , String amountofexpenses)
  {
    return  Column(
      children: [
        Padding(
          padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*.035, right: MediaQuery.of(context).size.width*.035,top: MediaQuery.of(context).size.height*.0125,bottom: MediaQuery.of(context).size.height*.0125),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width*.025,),
              typeofexpenses == "Must Expenses" ? Icon(Icons.circle_rounded,size: 17,color: Colors.green,) : typeofexpenses == "MayBe Expenses" ? Icon(Icons.circle_rounded,size: 17,color: Colors.orange,):Icon(Icons.circle_rounded,size: 17,color: Colors.red,),
              SizedBox(width: MediaQuery.of(context).size.width*.05,),
              Container(
                width: MediaQuery.of(context).size.width*.55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(titleofExpenses,style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w400),),
                    SizedBox(height: MediaQuery.of(context).size.height*.005,),
                    Text(catagoryofexpenses,style: GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w400),),
                  ],),
              ),

              Text("\$ ${amountofexpenses}ETB",style: GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w400),),
            ],
          ),
        ),

        Divider(),
      ],
    );
  }
}
