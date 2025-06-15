import 'package:flutter/material.dart';
import '../widgets/voicepanel/voice_panel.dart';
import '../widgets/top_navigation_bar.dart';
import '../widgets/question_card.dart';

class RecordingScreen extends StatelessWidget {
  const RecordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: const [
          _BackgroundImage(),
          _FadeOverlay(),
          TopNavigationBar(),
          QuestionCard(),
          VoicePanel(),
        ],
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        'assets/recording_screen.png',
        fit: BoxFit.cover,
      ),
    );
  }
}

class _FadeOverlay extends StatelessWidget {
  const _FadeOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.4),
      ),
    );
  }
}
