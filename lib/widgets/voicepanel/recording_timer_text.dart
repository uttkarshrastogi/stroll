import 'package:flutter/cupertino.dart';
import 'package:stroll/utils/theme.dart';

class RecordingTimerText extends StatelessWidget {
  final Duration current;
  final Duration total;

  const RecordingTimerText({
    super.key,
    required this.current,
    required this.total,
  });

  String _format(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "${_format(current)} / ${_format(total)}",
      style:AppTextStyles.smallGray
    );
  }
}