import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/goal/goalview.dart';

class GoalWidget extends StatelessWidget {
  final int id;
  final String title;
  final String description;
  final String? date;
  final double percentage;
  final String term;

   GoalWidget({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    this.date,
    this.percentage = 0.0,
    required this.term,
  });

  get fifty => null;

  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
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
          border: Border.all(width: 1,color: Colors.grey.withOpacity(.3)),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6.0),
                    child: Icon(
                      Icons.circle,
                      size: 15,
                      color:
                          percentage == 0.0
                              ? Colors.red
                              : percentage == 100.00
                              ? Colors.green
                              : Colors.grey,
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
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              '${date}: $term',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300
                              ),
                            ),
                          ],
                        ),
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



            Container(
              width: MediaQuery.of(context).size.width*.2,
              height: MediaQuery.of(context).size.height*.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColorDark,
              ),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.015),
                  width: MediaQuery.of(context).size.width*.175,
                  height: MediaQuery.of(context).size.height*.075,
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
                    foregroundStrokeWidth: 15,
                    backgroundStrokeWidth: 15,
                    animation: true,
                    seekSize: 6,
                    seekColor: const Color(0xffeeeeee),
                    child: Center(
                      child: ValueListenableBuilder(
                          valueListenable: _valueNotifier,
                          builder: (_, double value, __) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${percentage.round()}%',
                                style:  TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12
                                ),
                              ),

                            ],
                          )
                      ),
                    ),
                  )
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
