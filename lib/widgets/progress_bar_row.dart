import 'package:flutter/material.dart';
import 'package:stroll/utils/theme.dart';

class ProgressBarRow extends StatelessWidget {
  const ProgressBarRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.lightGray,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:  AppColors.midGray,
            ),
          ),
        ),
      ],
    );
  }
}
