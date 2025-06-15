import 'dart:math';
import 'package:flutter/material.dart';

class RecordButton extends StatelessWidget {
  final bool isRecording;
  final bool hasRecording;
  final bool isPlaying;
  final Duration lockDuration;
  final VoidCallback? onStartRecording;
  final VoidCallback? onStopRecording;
  final VoidCallback? onTogglePlayback;
  final double progress;

  const RecordButton({
    super.key,
    required this.isRecording,
    required this.hasRecording,
    required this.isPlaying,
    required this.progress,
    this.lockDuration = const Duration(minutes: 1),
    this.onStartRecording,
    this.onStopRecording,
    this.onTogglePlayback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (hasRecording && !isRecording) {
          onTogglePlayback?.call();
        } else if (!isRecording) {
          onStartRecording?.call();
        } else {
          onStopRecording?.call();
        }
      },
      child: SizedBox(
        width: 60,
        height: 60,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Progress arc
            SizedBox(
              width: 60,
              height: 60,
              child: CustomPaint(
                painter: _CircularLoaderPainter(progress: progress),
              ),
            ),

            // Button UI based on state
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFB4B4B4)),
              ),
              child: Center(
            child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: hasRecording && !isRecording
            ? Icon(
          isPlaying ? Icons.pause : Icons.play_arrow_rounded,
          key: const ValueKey('playPause'),
          size: 36,
          color: const Color(0xFF4F4CB1),
        )
            : AnimatedContainer(
          key: ValueKey(isRecording ? 'stop' : 'record'),
          width: isRecording ? 18 : 42,
          height: isRecording ? 18 : 42,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isRecording ? const Color(0xFF7B7B7B) : const Color(0xFF4F4CB1),
            shape: isRecording ? BoxShape.rectangle : BoxShape.circle,
            borderRadius: isRecording ? BorderRadius.circular(2) : null,
          ),
        ),
      ),
    ),

    ),
          ],
        ),
      ),
    );
  }
}

class _CircularLoaderPainter extends CustomPainter {
  final double progress;

  _CircularLoaderPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 3.0;
    final rect = Offset.zero & size;

    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: const [
        Color(0xFF4F4CB1),
        Color(0xFFCFCFFE),
      ],
    );

    final Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: size.center(Offset.zero), radius: size.width / 2 - strokeWidth),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularLoaderPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
