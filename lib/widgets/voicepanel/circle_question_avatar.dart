import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stroll/utils/theme.dart';

class CircleQuestionAvatar extends StatelessWidget {
  const CircleQuestionAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Stroll question',
            style:AppTextStyles.label
          ),
        ),
        Positioned(
          top: -20,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 4),
            ),
            child: const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/recording_screen.png'),
            ),
          ),
        ),
      ],
    );
  }
}
