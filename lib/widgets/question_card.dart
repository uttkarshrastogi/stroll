import 'package:flutter/material.dart';
import 'package:stroll/utils/theme.dart';
import 'package:stroll/widgets/voicepanel/circle_question_avatar.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleQuestionAvatar(),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'What is your most favorite childhood memory?',
              textAlign: TextAlign.center,
              style: AppTextStyles.heading,
            ),
          ),
          const SizedBox(height: 7),
           Text(
            '“Mine is definitely sneaking the late night snacks”',
            textAlign: TextAlign.center,
            style: AppTextStyles.subtitle.copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
