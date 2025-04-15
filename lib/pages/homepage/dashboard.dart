import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/customized/billboard.dart';

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

            Column(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
