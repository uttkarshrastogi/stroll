int calculateNoOfSamples({
  required Duration duration,
  required double containerWidth,
  double spacing = 2.0,
  double barWidth = 1.0,
}) {
  final totalBarSpace = barWidth + spacing;
  final estimatedBars = containerWidth / totalBarSpace;

  // You might want fewer bars than that for very short audio
  final durationInSeconds = duration.inMilliseconds / 1000.0;

  // At least 25 bars/sec, max 120 overall for short clips
  final samplesPerSecond = (estimatedBars / durationInSeconds).clamp(25, 200);

  return (samplesPerSecond * durationInSeconds).round();
}

