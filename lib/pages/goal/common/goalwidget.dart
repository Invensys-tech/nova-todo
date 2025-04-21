import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/goal/goalview.dart';

class GoalWidget extends StatelessWidget {
  final int id;
  final String title;
  final String description;
  final String? date;
  final double percentage;

  const GoalWidget({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    this.date,
    this.percentage = 0.0,
  });

  get fifty => null;

  @override
  Widget build(BuildContext context) {
    print(percentage);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => GoalView(id: id)),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        decoration: BoxDecoration(
          color: const Color(0xFF424242),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6.0),
                    child: Icon(
                      Icons.circle,
                      size: 8,
                      color: Colors.green.shade400,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        if (date != null) ...[
                          const SizedBox(height: 6),
                          Text(
                            'Starting Date: $date',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),

            SizedBox(
              width: 50.0,
              height: 50.0,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: (percentage / 100).clamp(0.0, 1.0),
                    strokeWidth: 4,
                    backgroundColor: Colors.white24,
                    valueColor: AlwaysStoppedAnimation(Colors.green),
                  ),

                  Center(
                    child: Text(
                      '${percentage.round()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.green),
          ],
        ),
      ),
    );
  }
}
