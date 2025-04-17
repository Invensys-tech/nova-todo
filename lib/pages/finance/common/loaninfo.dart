// import 'package:flutter/material.dart';

// class LoanCard extends StatefulWidget {
//   const LoanCard({super.key});

//   @override
//   State<LoanCard> createState() => _LoanCardState();
// }

// class _LoanCardState extends State<LoanCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(
//         vertical: MediaQuery.of(context).size.height * 0.01,
//       ),
//       width: MediaQuery.of(context).size.width * 1,
//       height: MediaQuery.of(context).size.height * 0.07,
//       padding: EdgeInsets.symmetric(
//         horizontal: MediaQuery.of(context).size.width * 0.02,
//         vertical: MediaQuery.of(context).size.height * 0.005,
//       ),
//       decoration: BoxDecoration(
//         color: Color(0xff292929),
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Row(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//               Text(
//                 "Demeke Zewdu",
//                 style: TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w200,
//                   color: Colors.white.withOpacity(0.8),
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.007),

//               Text(
//                 "0911561780",
//                 style: TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w200,
//                   color: Colors.white.withOpacity(0.8),
//                 ),
//               ),
//             ],
//           ),
//           Spacer(),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: MediaQuery.of(context).size.height * 0.01),

//               Text(
//                 '\$ 1,000,000',
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w200,
//                   color: Colors.white.withOpacity(0.8),
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.007),

//               Text(
//                 'Payable Loan',
//                 style: TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w200,
//                   color: Colors.red,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';
import 'package:flutter_application_1/pages/finance/loan/loanview.dart';

class LoanCard extends StatelessWidget {
  final Datamanager datamanager;
  final String name;
  final String phoneNumber;
  final num loanAmount;
  final int id;

  const LoanCard({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.loanAmount,
    required this.id,
    required this.datamanager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => LoanView(
                  name: name,
                  phoneNumber: phoneNumber,
                  loanAmount: loanAmount,
                  parentLoanId: id,
                  datamanager: datamanager,
                ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.08,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02,
          vertical: MediaQuery.of(context).size.height * 0.005,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1, color: Colors.grey.withOpacity(.3))
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.007),
                Text(
                  phoneNumber,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  '\$${loanAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.007),
                Text(
                  'Payable Loan',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
