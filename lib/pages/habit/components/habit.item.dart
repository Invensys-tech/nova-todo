import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HabitItem extends StatefulWidget {
  final String name;
  const HabitItem({super.key, required this.name});

  @override
  State<HabitItem> createState() => _HabitItemState();
}

class _HabitItemState extends State<HabitItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade900, // Background color
        borderRadius: BorderRadius.circular(
          16.0,
        ), // Rounded corners with a radius of 16
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: MediaQuery.of(context).size.width * 0.04,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Icon(Icons.book), Text(widget.name)],
          ),
          Row(
            spacing: MediaQuery.of(context).size.width * 0.01,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.local_fire_department, color: Colors.orange),
              Text('10'),
            ],
          ),
        ],
      ),
    );
  }
}
