import 'package:flutter/material.dart';

class EmptyWaveform extends StatelessWidget {
  const EmptyWaveform({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 20,
      alignment: Alignment.center,
    );
  }
}
