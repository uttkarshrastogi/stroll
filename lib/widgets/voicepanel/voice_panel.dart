import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:stroll/utils/theme.dart';
import 'package:stroll/widgets/voicepanel/gradient_shader.dart';
import 'package:stroll/widgets/voicepanel/empty_waveform.dart';
import '../record_button.dart';

class VoicePanel extends StatefulWidget {
  const VoicePanel({super.key});

  @override
  State<VoicePanel> createState() => _VoicePanelState();
}

class _VoicePanelState extends State<VoicePanel> {
  bool _isRecording = false;
  bool _hasRecording = false;
  bool _isPlaying = false;
  int _elapsedSeconds = 0;
  Timer? _timer;
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  Timer? _positionUpdater;

  late final PlayerController _playerController;
  WaveformType _waveformType = WaveformType.fitWidth;

  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final AudioPlayer _player = AudioPlayer();
  final RecorderController _recorderController = RecorderController();

  double get recordingProgress =>
      _isRecording ? (_elapsedSeconds / 60).clamp(0.0, 1.0) : 0.0;
  String? _recordingPath;

  @override
  void initState() {
    super.initState();
    _playerController = PlayerController();
    _playerController.onCompletion.listen((_) {
      _positionUpdater?.cancel();
      setState(() => _isPlaying = false);
    });
    _initRecorder();
    _recorderController
      ..refresh()
      ..checkPermission();
  }

  Future<void> _initRecorder() async {
    await _recorder.openRecorder();
  }

  Future<String> _getFilePath() async {
    final dir = await getTemporaryDirectory();
    return '${dir.path}/voice_note.aac';
  }

  Future<void> _startRecording() async {
    final path = await _getFilePath();
    await _recorder.startRecorder(toFile: path);
    _recorderController.record(path: path);

    setState(() {
      _isRecording = true;
      _hasRecording = false;
      _elapsedSeconds = 0;
      _currentDuration = Duration.zero;
      _recordingPath = path;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _elapsedSeconds++;
        _currentDuration = Duration(seconds: _elapsedSeconds);
      });
    });
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    await _recorderController.stop(false);
    _timer?.cancel();

    setState(() {
      _isRecording = false;
      _hasRecording = true;
      _totalDuration = Duration(seconds: _elapsedSeconds);
    });

    if (_recordingPath != null) {
      await _playerController.preparePlayer(
        path: _recordingPath!,
        shouldExtractWaveform: true,
      );
      _playerController.setFinishMode(finishMode: FinishMode.pause);
    }
  }

  double _calculateScaleFactor(Duration duration) {
    final seconds = duration.inSeconds.clamp(1, 600);
    if (seconds < 5) return 20;
    if (seconds < 10) return 30;
    if (seconds < 20) return 40;
    if (seconds < 40) return 50;
    return 60;
  }

  Future<void> _deleteRecording() async {
    _timer?.cancel();
    _positionUpdater?.cancel();

    if (_recorderController.isRecording) {
      await _recorderController.stop();
    }

    await _playerController.stopPlayer();
    _recorderController.reset();

    if (_recordingPath != null && File(_recordingPath!).existsSync()) {
      File(_recordingPath!).deleteSync();
    }

    setState(() {
      _isRecording = false;
      _hasRecording = false;
      _isPlaying = false;
      _elapsedSeconds = 0;
      _currentDuration = Duration.zero;
      _totalDuration = Duration.zero;
      _recordingPath = null;
    });
  }

  Future<void> _togglePlayback() async {
    if (_isPlaying) {
      await _playerController.pausePlayer();
      _positionUpdater?.cancel();
      setState(() => _isPlaying = false);
    } else {
      await _playerController.startPlayer(forceRefresh: false);
      setState(() => _isPlaying = true);

      _positionUpdater = Timer.periodic(const Duration(milliseconds: 200), (_) async {
        final currentMillis = await _playerController.getDuration(DurationType.current);
        setState(() {
          _currentDuration = Duration(milliseconds: currentMillis);
        });
      });
    }
  }

  String _formatTime(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _player.dispose();
    _recorder.closeRecorder();
    _recorderController.dispose();
    _playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: _formatTime(_currentDuration),
                  style: TextStyle(
                    color: (!_isRecording && _hasRecording)
                        ? AppColors.textPrimary
                        : AppColors.gray,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                if (!_isRecording && _hasRecording)
                  const TextSpan(
                    text: ' / ',
                    style: AppTextStyles.smallGray,
                  ),
                if (!_isRecording && _hasRecording)
                  TextSpan(
                    text: _formatTime(_totalDuration),
                    style: AppTextStyles.smallGray,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
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
                _isRecording
                    ? AudioWaveforms(
                  enableGesture: false,
                  size: const Size(double.infinity, 30),
                  recorderController: _recorderController,
                  waveStyle: WaveStyle(
                    waveColor: AppColors.waveformDark,
                    extendWaveform: true,
                    showMiddleLine: false,
                    spacing: 2,
                    waveThickness: 1,
                    scaleFactor: 50,
                  ),
                )
                    : _hasRecording
                    ? AudioFileWaveforms(
                  playerController: _playerController,
                  waveformType: _waveformType,
                  size: const Size(double.infinity, 30),
                  playerWaveStyle: PlayerWaveStyle(
                    liveWaveGradient: buildGradientShader(context),
                    spacing: 2,
                    waveThickness: 1,
                    waveCap: StrokeCap.round,
                    scaleFactor: _calculateScaleFactor(_totalDuration),
                  ),
                )
                    : const EmptyWaveform(),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: (_isRecording || _hasRecording) ? _deleteRecording : null,
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: (_isRecording || _hasRecording)
                        ? AppColors.heading
                        : AppColors.darkGray,
                    fontSize: 17,
                  ),
                ),
              ),
              RecordButton(
                isRecording: _isRecording,
                hasRecording: _hasRecording,
                isPlaying: _isPlaying,
                progress: recordingProgress,
                onStartRecording: _startRecording,
                onStopRecording: _stopRecording,
                onTogglePlayback: _togglePlayback,
              ),
              Text(
                'Submit',
                style: TextStyle(
                  color: ( _hasRecording)
                      ? AppColors.heading
                      : AppColors.darkGray,
                  fontSize: 17,
                ),
              ),
            ],
          ),
          Text(
            'Unmatch',
            style: AppTextStyles.label.copyWith(color: AppColors.red),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
