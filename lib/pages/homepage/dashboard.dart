import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/customized/billboard.dart';
import 'package:flutter_application_1/pages/homepage/dashboard-components/dashboard.expense.item.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<dynamic> expenses = [
    {
      'title': 'Electric Bill',
      'date': 'Yesterday',
      'amount': '2300',
      'icon': Icons.thunderstorm,
    },
    {
      'title': 'Groceries',
      'date': '2025-04-13',
      'amount': '2000',
      'icon': Icons.shopping_cart,
    },
    {
      'title': 'Rent',
      'date': '2025-04-07',
      'amount': '23000',
      'icon': Icons.house_outlined,
    },
  ];

  List<dynamic> habits = [
    {
      'title': 'Books and Music',
      'frequency': 'Everyday',
      'streak': '4',
      'icon': Icons.book,
    },
    {
      'title': 'Sports and Gym',
      'frequency': 'Once A Week',
      'streak': '4',
      'icon': Icons.line_weight,
    },
  ];

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
            // Financial Overview Section.

            // Recent Expenses Section
            Column(
              spacing: MediaQuery.of(context).size.height * .008,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Expenses',
                      style: TextStyle(color: Color(0xFFD4D4D8), fontSize: 16),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(color: Color(0xFF009966), fontSize: 12),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    spacing: MediaQuery.of(context).size.height * .015,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        expenses
                            .map(
                              (expense) =>
                                  DashboardExpenseItem(expense: expense),
                            )
                            .toList(),
                  ),
                ),
              ],
            ),
            // Recent Expenses Section

            // Todays Habits Section
            Column(
              spacing: MediaQuery.of(context).size.height * .008,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today's Habits",
                      style: TextStyle(color: Color(0xFFD4D4D8), fontSize: 16),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(color: Color(0xFF009966), fontSize: 12),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    spacing: MediaQuery.of(context).size.height * .008,
                    children:
                        habits
                            .map((habit) => DashboardHabitItem(habit: habit))
                            .toList(),
                  ),
                ),
              ],
            ),
            // Todays Habits Section

            // Board below todays habits and above the chart
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .03,
                vertical: MediaQuery.of(context).size.height * .025,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Color(0xFF27272A).withOpacity(.35),
                  width: 2.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weekly Completion',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        'Apr 12 - Apr 19',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '12',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Icon(
                        Icons.local_fire_department,
                        color: Color(0xFFE36810),
                        size: 16,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 4,
                    children: [
                      Row(
                        spacing: 4,
                        children: [
                          Icon(Icons.circle, color: Color(0xFF009966), size: 8),
                          Text(
                            'This Week',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        spacing: 4,
                        children: [
                          Icon(Icons.circle, color: Color(0xFF3F3F47), size: 8),
                          Text(
                            'Last Week',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Board below todays habits and above the chart

            // Top community challenges
            Column(
              spacing: MediaQuery.of(context).size.height * .008,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top Community Challenges",
                      style: TextStyle(color: Color(0xFFD4D4D8), fontSize: 16),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(color: Color(0xFF009966), fontSize: 12),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 4.0,
                  ),
                  margin: EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF27272A).withValues(alpha: .5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  // Container(
                  //       padding: EdgeInsets.symmetric(
                  //         horizontal: 12.0,
                  //         vertical: 4.0,
                  //       ),
                  //       margin: EdgeInsets.only(bottom: 10.0),
                  //       decoration: BoxDecoration(
                  //         color: Color(0xFF27272A).withValues(alpha: .5),
                  //         borderRadius: BorderRadius.circular(40.0),
                  //       ),
                  //       alignment: Alignment.center,
                  //       child: Text(
                  //         quote.category,
                  //         style: TextStyle(color: Colors.white, fontSize: 12),
                  //       ),
                  //     ),
                  child: Column(
                    spacing: MediaQuery.of(context).size.height * .008,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('60 Days Active Body Transformation'),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            margin: EdgeInsets.only(bottom: 10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF00D492).withValues(alpha: .5),
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Active',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            margin: EdgeInsets.only(bottom: 10.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF27272A).withValues(alpha: .5),
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Fitness',
                              style: TextStyle(
                                // color: Color(0xFF27272A),
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Row(
                            spacing: MediaQuery.of(context).size.width * 0.02,
                            children: [Icon(Icons.people, size: 16), Text('4')],
                          ),
                          Row(
                            spacing: MediaQuery.of(context).size.width * 0.02,
                            children: [
                              Icon(Icons.calendar_today, size: 16),
                              Text('April 12'),
                            ],
                          ),
                        ],
                      ),
                      Row(),
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

class DashboardHabitItem extends StatelessWidget {
  final dynamic habit;
  const DashboardHabitItem({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .001),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .02,
              vertical: MediaQuery.of(context).size.height * .015,
            ),
            width: MediaQuery.of(context).size.width * .93,
            decoration: BoxDecoration(
              // color: Color(0xff0d805e).withOpacity(.35),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Color(0xFF27272A).withOpacity(.35),
                width: 2.5,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: MediaQuery.of(context).size.width * .02,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFF27272A),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        habit['icon'],
                        color: Color(0xFF9F9FA9),
                        size: 20,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          habit['title'],
                          style: TextStyle(
                            color: Color(0xFFE4E4E7),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          habit['frequency'],
                          style: TextStyle(
                            color: Color(0xFFE4E4E7),
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .0125),

                SizedBox(height: MediaQuery.of(context).size.height * .015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text(
                        //   "Status : ",
                        //   style: GoogleFonts.lato(
                        //     fontSize: 13,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        Text("\$ ${habit['streak']}"),
                        Icon(
                          Icons.local_fire_department,
                          color: Color(0xFFE36810),
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
    );
  }
}
