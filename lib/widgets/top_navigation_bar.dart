import 'package:flutter/material.dart';
import '../utils/theme.dart';
import 'progress_bar_row.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const ProgressBarRow(),
            const SizedBox(height: 21),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.arrow_back_ios, color: Colors.white, size: 15),
                Text('Amanda, 22', style: AppTextStyles.navTitle),
                Icon(Icons.more_horiz_rounded, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
