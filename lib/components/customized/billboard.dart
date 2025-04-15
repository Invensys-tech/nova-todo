import 'package:flutter/material.dart';

class Billboard extends StatelessWidget {
  final Widget child;
  final double height;
  const Billboard({super.key, required this.child, this.height = 200.0});

  Widget _buildCircle(double radius, Color color) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF006045),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            bottom: -50,
            right: -10,
            child: _buildCircle(
              100.0,
              const Color(0xFFFAFAFA).withValues(alpha: .1),
            ),
          ),
          Positioned(
            bottom: -10,
            right: 30,
            child: _buildCircle(
              75.0,
              const Color(0xFF009966).withValues(alpha: .2),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
