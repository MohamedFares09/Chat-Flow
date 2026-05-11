import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:test_codex/features/message/presentation/widgets/message_duration_label.dart';

class MessageVoiceContent extends StatefulWidget {
  const MessageVoiceContent({
    required this.voiceUrl,
    super.key,
  });

  final String voiceUrl;

  @override
  State<MessageVoiceContent> createState() => _MessageVoiceContentState();
}

class _MessageVoiceContentState extends State<MessageVoiceContent> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  StreamSubscription<Duration>? _durationSubscription;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<PlayerState>? _stateSubscription;
  StreamSubscription<void>? _completeSubscription;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    unawaited(_audioPlayer.setSourceUrl(widget.voiceUrl));
    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      if (mounted) {
        setState(() => _duration = duration);
      }
    });
    _positionSubscription = _audioPlayer.onPositionChanged.listen((position) {
      if (mounted) {
        setState(() => _position = position);
      }
    });
    _stateSubscription = _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() => _isPlaying = state == PlayerState.playing);
      }
    });
    _completeSubscription = _audioPlayer.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() {
          _isPlaying = false;
          _position = Duration.zero;
        });
      }
    });
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _stateSubscription?.cancel();
    _completeSubscription?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: Column(
        children: [
          Row(
            children: [
              IconButton.filled(
                onPressed: _togglePlayback,
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              ),
              SizedBox(
                width: 34,
                child: Text(
                  MessageDurationLabel.format(_position),
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 3,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 12,
                    ),
                  ),
                  child: Slider(
                    value: _sliderValue,
                    max: _sliderMax,
                    onChanged: (value) {
                      _audioPlayer.seek(
                        Duration(milliseconds: value.round()),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                MessageDurationLabel.format(_duration),
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.mic, color: Colors.white70, size: 18),
            ],
          ),
        ],
      ),
    );
  }

  double get _sliderMax {
    return _duration.inMilliseconds <= 0
        ? 1
        : _duration.inMilliseconds.toDouble();
  }

  double get _sliderValue {
    if (_duration.inMilliseconds <= 0) {
      return 0;
    }

    return _position.inMilliseconds
        .clamp(0, _duration.inMilliseconds)
        .toDouble();
  }

  Future<void> _togglePlayback() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      return;
    }

    if (_position >= _duration && _duration > Duration.zero) {
      await _audioPlayer.seek(Duration.zero);
    }

    await _audioPlayer.resume();
  }
}
