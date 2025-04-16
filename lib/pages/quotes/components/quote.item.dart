import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/quote.entity.dart';
import 'package:flutter_application_1/utils/helpers.dart';

class QuoteItem extends StatelessWidget {
  final Quote quote;
  QuoteItem({super.key, required this.quote});

  // final Random random = Random();
  // final bgColors = [
  //   Color(0xFF0B211C),
  //   Color(0xFF371A12),
  //   Color(0xFF39143B),
  //   Color(0xFF0C2524),
  //   Color(0xFF09090B),
  // ];

  // final Color backgroundColor = Color.fromARGB(
  //   255,
  //   100 + Random().nextInt(100),
  //   50 + Random().nextInt(100),
  //   50 + Random().nextInt(100),
  // );

  final backgroundColor =
      [
        Color(0xFF0B211C),
        Color(0xFF371A12),
        Color(0xFF39143B),
        Color(0xFF0C2524),
        Color(0xFF09090B),
      ][Random().nextInt(5)];

  Widget _buildSquare(double radius, Color color) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(shape: BoxShape.rectangle, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10.0),
        topLeft: Radius.circular(10.0),
        bottomLeft: Radius.circular(10.0),
        bottomRight: Radius.circular(30.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.grey.shade800,
          color: backgroundColor,
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: -60,
              right: -60,
              child: _buildSquare(
                90.0,
                const Color(0xFFFAFAFA).withValues(alpha: 0.5),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              child: Column(
                spacing: MediaQuery.of(context).size.width * 0.06,
                children: [
                  Text(
                    '"${quote.text}"',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFD4D4D8),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                          quote.category,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: MediaQuery.of(context).size.width * 0.015,
                        children: [
                          Text(
                            quote.author,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            quote.source,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey.shade400,
                            ),
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
    );
    // return Container(
    //   margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    //   child: Stack(
    //     children: [
    //       // Main Ticket Body with Curved Right Edge
    //       ClipPath(
    //         clipper: TicketClipper(),
    //         child: Container(
    //           width: double.infinity,
    //           padding: const EdgeInsets.all(16.0),
    //           decoration: BoxDecoration(
    //             color: backgroundColor,
    //             borderRadius: BorderRadius.circular(8.0),
    //           ),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 quote.text,
    //                 style: const TextStyle(color: Colors.white, fontSize: 16.0),
    //               ),
    //               const SizedBox(height: 12.0),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     quote.source,
    //                     style: const TextStyle(
    //                       color: Colors.white70,
    //                       fontSize: 12.0,
    //                     ),
    //                   ),
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.end,
    //                     children: [
    //                       Text(
    //                         quote.author,
    //                         style: const TextStyle(
    //                           color: Colors.white,
    //                           fontSize: 14.0,
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       ),
    //                       Text(
    //                         quote.source,
    //                         style: const TextStyle(
    //                           color: Colors.white70,
    //                           fontSize: 12.0,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       // Optional: Subtle Shadow for the Curve
    //       Positioned(
    //         top: 0,
    //         bottom: 0,
    //         right: 0,
    //         width: 10, // Adjust shadow width as needed
    //         child: CustomPaint(
    //           painter: CurveShadowPainter(backgroundColor.withOpacity(0.3)),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

// Custom clipper to create the curved shape
class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width - 20, size.height); // Start of the curve
    path.quadraticBezierTo(
      size.width - 5, // Control point for the curve
      size.height - size.height * 0.3,
      size.width, // End point of the curve
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width - 5,
      size.height * 0.3,
      size.width - 20,
      0,
    );
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

// Custom painter to draw the shadow for the curve
class CurveShadowPainter extends CustomPainter {
  final Color shadowColor;

  CurveShadowPainter(this.shadowColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = shadowColor
          ..maskFilter = const MaskFilter.blur(
            BlurStyle.normal,
            3.0,
          ); // Adjust blur radius for the shadow

    final path = Path();
    path.moveTo(0, size.height * 0.5); // Start point of the shadow
    path.quadraticBezierTo(
      size.width * 0.8, // Control point for the shadow curve
      size.height * 0.8,
      size.width, // End point of the shadow curve
      size.height,
    );
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.2, 0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
