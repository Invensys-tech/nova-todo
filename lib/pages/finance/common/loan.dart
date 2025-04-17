import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

class LoanWidget extends StatefulWidget {
  const LoanWidget({super.key});

  @override
  State<LoanWidget> createState() => _LoanWidgetState();
}

class _LoanWidgetState extends State<LoanWidget> {
  @override
  Widget build(BuildContext context) {
    /*return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Color(0xff202020),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.045,
        vertical: MediaQuery.of(context).size.height * 0.0095,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total Amounts of Loan",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w200,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.009),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "\$ 2000",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.01),
              Text(
                "Total Amounts of Loan",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w200,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.035,
                    width: MediaQuery.of(context).size.height * 0.035,
                    decoration: BoxDecoration(
                      color: Color(0xFF474646),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.trending_up,
                      color: Colors.green,
                      size: MediaQuery.of(context).size.height * 0.032,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        "Receivable Loan",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w200,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Text(
                        "15,000",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.035,
                    width: MediaQuery.of(context).size.height * 0.035,
                    decoration: BoxDecoration(
                      color: Color(0xFF474646),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.trending_down,
                      color: Colors.red,
                      size: MediaQuery.of(context).size.height * 0.032,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        "Payable Loan",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w200,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Text(
                        "15,000",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ); */


    return Container(
      height: MediaQuery.of(context).size.height*.2675,
      width: MediaQuery.of(context).size.width*.95,
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.025, vertical: MediaQuery.of(context).size.height*.02),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Colors.grey.withOpacity(.2))
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width*.9,
            height: MediaQuery.of(context).size.height*.12,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color:Theme.of(context).disabledColor
            ),
            child:   Stack(
              children: [

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.035, vertical: MediaQuery.of(context).size.height*.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.01,),
                      Row(
                        children: [
                          Text(
                            'Net Amount Loan.  ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          badges.Badge(
                            showBadge: true,
                            ignorePointer: false,
                            onTap: () {},
                            badgeContent:
                            Text("Payable",style: TextStyle(fontSize: 12, color: Colors.red),),
                            badgeAnimation: badges.BadgeAnimation.rotation(
                              animationDuration: Duration(seconds: 1),
                              colorChangeAnimationDuration: Duration(seconds: 1),
                              loopAnimation: false,
                              curve: Curves.fastOutSlowIn,
                              colorChangeAnimationCurve: Curves.easeInCubic,
                            ),
                            badgeStyle: badges.BadgeStyle(
                              shape: badges.BadgeShape.square,
                              badgeColor: Colors.black,
                              padding: EdgeInsets.all(4),
                              borderRadius: BorderRadius.circular(4),

                              elevation: 0,
                            ),

                          ),
                          Spacer(),
                          Text(
                            'Today',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(Icons.arrow_drop_down, size: 20,color: Colors.white,),
                        ],
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*.005,),

                      Text(
                        "\$ ETB 22,400",
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height*.03,
                  left: MediaQuery.of(context).size.width*.4,
                  child: Container(
                    width: MediaQuery.of(context).size.width*.3,
                    height: MediaQuery.of(context).size.height*.1,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff009966).withOpacity(.1)
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height*.05,
                  left: MediaQuery.of(context).size.width*.5,
                  child: Container(
                    width: MediaQuery.of(context).size.width*.35,
                    height: MediaQuery.of(context).size.height*.15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffFAFAFA).withOpacity(.1)
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*.015,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.035),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*.09,
                  width: MediaQuery.of(context).size.width*.35,
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.02,vertical: MediaQuery.of(context).size.height*.01),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(width: 1 , color: Colors.grey.withOpacity(.2),
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Recivable",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                      Row(
                        children: [
                          Text("+ ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.green),),
                          Text("ETB 11,500",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*.09,
                  width: MediaQuery.of(context).size.width*.35,
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.02,vertical: MediaQuery.of(context).size.height*.01),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(width: 1 , color: Colors.grey.withOpacity(.2),
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Payable",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                      Row(
                        children: [
                          Text("- ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.red),),
                          Text("ETB 11,500",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
