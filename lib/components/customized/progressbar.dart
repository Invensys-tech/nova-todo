import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress;
  final double height;
  final Color backgroundColor;
  final Color progressColor;

  const CustomProgressBar({
    super.key,
    required this.progress,
    this.height = 25,
    this.backgroundColor = const Color(0xFF3F3F47),
    this.progressColor = const Color(0xFF006045),
  });

  // const CustomProgressBar({
  //   Key? key,
  //   required this.progress,
  //   this.height = 25,
  //   this.backgroundColor = const Color(0xFFE0E0E0),
  //   this.progressColor = Colors.blue,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(height / 4),
            border: Border.all(color: Color(0xFF3F3F47), width: 1.5),
          ),
        ),
        FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: progress.clamp(0.0, 1.0),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: progressColor,
              borderRadius: BorderRadius.circular(height / 4),
            ),
          ),
        ),
        Text(
          '${(progress * 100).toStringAsFixed(0)}%',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
