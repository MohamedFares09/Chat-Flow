import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class VoiceRecordButton extends StatefulWidget {
  const VoiceRecordButton({
    required this.isSending,
    required this.onVoiceRecorded,
    super.key,
  });

  final bool isSending;
  final ValueChanged<String> onVoiceRecorded;

  @override
  State<VoiceRecordButton> createState() => _VoiceRecordButtonState();
}

class _VoiceRecordButtonState extends State<VoiceRecordButton> {
  final AudioRecorder _recorder = AudioRecorder();
  bool _isRecording = false;

  @override
  void dispose() {
    _recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: _isRecording ? 'Send voice' : 'Record voice',
      onPressed: widget.isSending ? null : _toggleRecording,
      icon: Icon(
        _isRecording ? Icons.stop_circle_outlined : Icons.mic_none_outlined,
        color: _isRecording ? Colors.redAccent : AppColors.body,
      ),
    );
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      final path = await _recorder.stop();
      setState(() => _isRecording = false);
      if (path != null) {
        widget.onVoiceRecorded(path);
      }
      return;
    }

    final hasPermission = await _recorder.hasPermission();
    if (!hasPermission) {
      return;
    }

    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/voice_'
        '${DateTime.now().millisecondsSinceEpoch}.m4a';
    await _recorder.start(
      const RecordConfig(encoder: AudioEncoder.aacLc),
      path: path,
    );
    setState(() => _isRecording = true);
  }
}
