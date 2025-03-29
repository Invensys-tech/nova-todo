import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/goal/goalview.dart';

class GoalWidget extends StatefulWidget {
  final int id;
  final String title;
  final String description;
  final String? date;
  const GoalWidget({
    super.key,
    required this.description,
    required this.title,
    this.date,
    required this.id,
  });

  @override
  State<GoalWidget> createState() => _GoalWidgetState();
}

class _GoalWidgetState extends State<GoalWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoalView(id: widget.id)),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
          vertical: MediaQuery.of(context).size.width * 0.06,
        ),
        decoration: BoxDecoration(color: Color(0xff424242)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  Text(
                    'Starting Date :12 - 02 -2025 ',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // height: MediaQuery.of(context).size.height * 0.42,
              // width: MediaQuery.of(context).size.height * 0.42,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Icon(
                Icons.circle,
                size: MediaQuery.of(context).size.height * 0.14,
                color: Colors.green.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
