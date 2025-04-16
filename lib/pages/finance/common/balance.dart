import 'package:flutter/material.dart';

class BankBalance extends StatefulWidget {
  const BankBalance({super.key});

  @override
  State<BankBalance> createState() => _BankBalanceState();
}

class _BankBalanceState extends State<BankBalance> {
  @override
  Widget build(BuildContext context) {
  /*  return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        // Remove fixed height to allow content to determine height
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
          Row(
            children: [
              Text(
                'Total Balance',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w200,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              Spacer(),
              Text(
                'Total Balance',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w200,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_drop_down),
                color: Colors.white,
              ),
            ],
          ),
          Text(
            "\$ 99,000",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.8),
            ),
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
                    'Total Balance',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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
                            "\$ 99,000",
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
                      Text("Total Income",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                      Row(
                        children: [
                          Text("+ ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.green),),
                          Text("11,500",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
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
                      Text("Total Expenses",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                      Row(
                        children: [
                          Text("- ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.red),),
                          Text("11,500",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
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
