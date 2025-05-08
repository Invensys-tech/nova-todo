import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class CommunityChallenges extends StatefulWidget {
  const CommunityChallenges({super.key});

  @override
  State<CommunityChallenges> createState() => _CommunityChallengesState();
}

class _CommunityChallengesState extends State<CommunityChallenges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.width*.05,),
            Container(
              height: MediaQuery.of(context).size.height*.45,
              width: MediaQuery.of(context).size.width,
                child:Lottie.asset(
        
                  'assets/LottieAnimations/UnderConstruction2.json',
                  // height: widget.habit.streak.toString() == "1" ? 40:
                  // widget.habit.streak.toString() == "2" ? 45:
                  // widget.habit.streak.toString() == "3" ? 50:
                  // widget.habit.streak.toString() == "4" ? 55:
                  // widget.habit.streak.toString() == "5" ? 60:40,
                  // width: widget.habit.streak.toString() == "1" ? 35:
                  // widget.habit.streak.toString() == "2" ? 40:
                  // widget.habit.streak.toString() == "3" ? 45:
                  // widget.habit.streak.toString() == "4" ? 50:
                  // widget.habit.streak.toString() == "5" ? 55:35,
                  height: 45,
                  width: 40,
                  fit: BoxFit.contain,
                )
        
            ),
            SizedBox(height: MediaQuery.of(context).size.height*.05,),
            Center(
              child: Text("Page Is Under Construction ",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.009),
            Container(
              padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*.015),
              width: MediaQuery.of(context).size.width*1,
              child: Center(
                child: Text("Once the Page is finished you will have the following features and you will you enjoy the app more from now ",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            ...[
              "You Will Partcipate in other challenges",
              "Your Journey to achieve something will not be alone",
              "You will Create a community in which that want to upgrade",
              "You will help and helped thorugh different things",
              "Life will be easy from noon",
            ].map(
                  (text) => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01,
            left: MediaQuery.of(context).size.width*.06
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Color(0xFF00D084)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        text,
                        style: TextStyle( fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        
            SizedBox(height: MediaQuery.of(context).size.height*.035,),
        
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width*.45,
                height: MediaQuery.of(context).size.height*.05,
                decoration: BoxDecoration(
                    color: Color(0xFF00D084),
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    border: Border.all(width: 1, color: Color(0xFF00D084))
                ),
                child: Center(
                  child:  const Text('Back To Home'),
                ),
              ),
            ),
        
          ],
        ),
      ),
    );
  }
}
