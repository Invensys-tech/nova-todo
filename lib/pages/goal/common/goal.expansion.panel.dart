import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/pages/goal/common/goalwidget.dart';
import 'package:flutter_application_1/pages/goal/common/sub-goal-card.dart';
import 'package:flutter_application_1/utils/helpers.dart';

class GoalExpansionPanel extends StatelessWidget {
  final String title;
  final Icon? icon;
  final dynamic? created_at;
  final double? percentage;

  const GoalExpansionPanel({
    super.key,
    required this.title,
    this.icon,
    this.created_at,
    this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");
    print(getDateOnly(DateTime.parse(created_at)));
    return Column(
      children: [
        SubGoalCardWidget(
          title: title,
          status:
              percentage == 100.00
                  ? "Completed"
                  : percentage == 0.00
                  ? "Not Started"
                  : "In Progress",
          date: getDateOnly(DateTime.parse(created_at)),
          percentage: percentage ?? 0.0,
        ),
        // GoalWidget(id: 1, title: title, description: "description", term: "t"),
        // Container(
        //   padding: EdgeInsets.symmetric(
        //     vertical: MediaQuery.of(context).size.height * 0.01,
        //     horizontal: MediaQuery.of(context).size.width * 0.02,
        //   ),
        //   color: Theme.of(context).primaryColorDark,
        //   child: Row(
        //     spacing: MediaQuery.of(context).size.width * 0.04,
        //     children: [icon ?? Container(), Text("p")],
        //   ),
        // ),
      ],
    );
  }
}
