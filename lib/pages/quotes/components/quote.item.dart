import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/entities/quote.entity.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/quotes/form.quotes.dart';
import 'package:flutter_application_1/utils/helpers.dart';
import 'package:google_fonts/google_fonts.dart';

class QuoteItem extends StatelessWidget {
  final Quote quote;

  QuoteItem({super.key, required this.quote});

  final backgroundColorWhite =
      [
        Color(0xFF0B211C),
        Color(0xFF371A12),
        Color(0xFF39143B),
        Color(0xFF0C2524),
        Color(0xFF09090B),
      ][Random().nextInt(5)];

  final backgroundColorBlack =
      [
        Color(0xff5EE9B5),
        Color(0xffFFB86A),
        Color(0xffA2F4FD),
        Color(0xffE4E4E7),
        Color(0xff5EE9B5),
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => QuoteForm(quote: quote, refetch: () {})),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(30.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.grey.shade800,
            color: isDark ? backgroundColorWhite : backgroundColorBlack,
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
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .035,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '"${quote.text}"',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.cinzel(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * .025,
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
                            style: TextStyle(fontSize: 12),
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
      ),
    );
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
