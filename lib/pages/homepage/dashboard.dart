import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/customized/billboard.dart';
import 'package:flutter_application_1/services/streak.helper.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: MediaQuery.of(context).size.height * 0.04,
          children: [
            ElevatedButton(
              onPressed: () {
                simulateContinuingDailyStreak(22);
              },
              child: Text("Test Continue"),
            ),

            ElevatedButton(
              onPressed: () {
                simulateBrokenDailyStreak(22);
              },
              child: Text("Test Break"),
            ),

            Billboard(
              height: 135,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 15,
                      children: [
                        Text('Total Balance', style: TextStyle(fontSize: 14)),
                        Text(
                          r'$ 72,000',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 15,
                      children: [
                        Text('Streak', style: TextStyle(fontSize: 14)),
                        Text(
                          '23',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Financial Overview Section
            Column(
              spacing: MediaQuery.of(context).size.height * .008,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Financial Overview',
                      style: TextStyle(color: Color(0xFFD4D4D8), fontSize: 16),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(color: Color(0xFF009966), fontSize: 12),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Color(0xFF3F3F47), width: 1),
                    color: Color(0xFF27272A),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 11,
                            children: [
                              Text('Current Balance'),
                              Row(
                                children: [
                                  Text(
                                    '+',
                                    style: TextStyle(
                                      color: Color(0xFF009966),
                                      fontSize: 24,
                                    ),
                                  ),
                                  Text(
                                    r'$ 65,400',
                                    style: TextStyle(
                                      color: Color(0xFFF4F4F5),
                                      fontSize: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(flex: 2, child: Text('Circle')),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          spacing: 8,
                          children: [
                            Text('This Week'),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: 4,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  spacing: 4,
                                  children: [
                                    Text(
                                      'Total Income',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Icon(
                                      Icons.circle,
                                      color: Color(0xFF009966),
                                      size: 8,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  spacing: 4,
                                  children: [
                                    Text(
                                      'Total Expense',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Icon(
                                      Icons.circle,
                                      color: Color(0xFF8B0836),
                                      size: 8,
                                    ),
                                  ],
                                ),
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
          ],
        ),
      ),
    );
  }
}
