import 'package:flutter/material.dart';

class UserProfileWithAddButton extends StatelessWidget {
  const UserProfileWithAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF27272A),
          ),
          child: const Icon(
            Icons.person_outline,
            size: 40,
            color: Color(0xFF3F3F47),
          ),
        ),

        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE4E4E7),
            ),
            child: const Icon(
              Icons.add,
              size: 16,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
