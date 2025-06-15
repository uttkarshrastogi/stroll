import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'gradient_shader.dart';

class WaveformDisplay extends StatelessWidget {
  final bool isRecording;
  final bool hasRecording;
  final RecorderController recorderController;
  final PlayerController playerController;
  final Duration totalDuration;

  const WaveformDisplay({
    super.key,
    required this.isRecording,
    required this.hasRecording,
    required this.recorderController,
    required this.playerController,
    required this.totalDuration,
  });

  double _calculateScaleFactor(Duration duration) {
    final seconds = duration.inSeconds.clamp(1, 600);
    return (seconds < 5) ? 20
        : (seconds < 10) ? 30
        : (seconds < 20) ? 40
        : (seconds < 40) ? 50
        : 60;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 30,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(height: 1, color: Colors.white24),
            ),
          ),
          isRecording
              ? AudioWaveforms(
            enableGesture: false,
            size: const Size(double.infinity, 30),
            recorderController: recorderController,
            waveStyle: WaveStyle(
              waveColor: const Color(0xFF36393E),
              extendWaveform: true,
              showMiddleLine: false,
              spacing: 2,
              waveThickness: 1,
              scaleFactor: 50,
            ),
          )
              : hasRecording
              ? AudioFileWaveforms(
            playerController: playerController,
            waveformType: WaveformType.fitWidth,
            size: const Size(double.infinity, 30),
            playerWaveStyle: PlayerWaveStyle(
              liveWaveGradient: buildGradientShader(context),
              spacing: 2,
              waveThickness: 1,
              waveCap: StrokeCap.round,
              scaleFactor: _calculateScaleFactor(totalDuration),
            ),
          )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
