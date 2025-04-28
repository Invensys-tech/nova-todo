import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/goal/goalview.dart';

class SubGoalCardWidget extends StatelessWidget {
  final String title;
  final String status;
  final String? date;
  final double percentage;

  SubGoalCardWidget({
    super.key,
    required this.title,
    required this.status,
    this.date,
    this.percentage = 0.0,
  });

  get fifty => null;

  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    print(percentage);
    return GestureDetector(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        decoration: BoxDecoration(
          // color: const Color(0xFF424242),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(status, style: TextStyle(fontSize: 13)),
                        const SizedBox(height: 6),
                        Text(date ?? '', style: TextStyle(fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),

            // SizedBox(
            //   width: 50.0,
            //   height: 50.0,
            //   child: Stack(
            //     fit: StackFit.expand,
            //     children: [
            //       CircularProgressIndicator(
            //         value: (percentage / 100).clamp(0.0, 1.0),
            //         strokeWidth: 4,
            //         backgroundColor: Colors.white24,
            //         valueColor: AlwaysStoppedAnimation(Colors.green),
            //       ),
            //
            //       Center(
            //         child: Text(
            //           '${percentage.round()}%',
            //           style: const TextStyle(
            //             color: Colors.white,
            //             fontSize: 12,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * .2,
                height: MediaQuery.of(context).size.height * .1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColorDark,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .015,
                  ),
                  width: MediaQuery.of(context).size.width * .175,
                  height: MediaQuery.of(context).size.height * .075,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  child: DashedCircularProgressBar.aspectRatio(
                    aspectRatio: 1, // width ÷ height
                    valueNotifier: _valueNotifier,
                    progress: percentage,
                    startAngle: 360,
                    sweepAngle: -360,
                    foregroundColor: Color(0xff0FF009966),
                    backgroundColor: Theme.of(context).primaryColorDark,
                    foregroundStrokeWidth: 10,
                    backgroundStrokeWidth: 10,
                    animation: true,
                    seekSize: 6,
                    seekColor: const Color(0xffeeeeee),
                    child: Center(
                      child: ValueListenableBuilder(
                        valueListenable: _valueNotifier,
                        builder:
                            (_, double value, __) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${percentage}%',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
