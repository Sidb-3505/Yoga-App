import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:yoga_app/screens/yoga_completion_screen.dart';
import '../models/yoga_app_model.dart';
import 'countdown_screen.dart';
import 'home_screen.dart';

class PoseScreen extends StatefulWidget {
  final List<Sequence> sequences;
  final Images? images;

  const PoseScreen({
    super.key,
    required this.sequences,
    required this.images,
  });

  @override
  State<PoseScreen> createState() => _PoseScreenState();
}

class _PoseScreenState extends State<PoseScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentSequenceIndex = 0;
  int _currentScriptIndex = 0;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isPaused = false;
  Timer? _syncTimer;

  List<Script> get currentScripts =>
      widget.sequences[_currentSequenceIndex].script ?? [];

  String? getImageFile(String? ref) {
    switch (ref?.toLowerCase()) {
      case 'base':
        return widget.images?.base;
      case 'cat':
        return widget.images?.cat;
      case 'cow':
        return widget.images?.cow;
      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _playCurrentAudio(autoPlay: true);

    _audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        setState(() => _duration = duration);
      }
    });

    _audioPlayer.positionStream.listen((pos) {
      if (!_isPaused) {
        setState(() => _position = pos);
      }
    });

    _syncTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!_isPaused) {
        _updateScriptIndex(_position.inSeconds);
      }
    });

    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _goToNextPose();
      }
    });
  }

  void _updateScriptIndex(int seconds) {
    final scripts = currentScripts;
    if (scripts.isEmpty) return;

    int newIndex = _currentScriptIndex;

    for (int i = 0; i < scripts.length; i++) {
      final startSec = scripts[i].startSec ?? 0;
      final endSec = scripts[i].endSec ?? _duration.inSeconds;

      if (seconds >= startSec && seconds <= endSec) {
        newIndex = i;
        break;
      }
    }

    if (_currentScriptIndex != newIndex) {
      setState(() => _currentScriptIndex = newIndex);
    }
  }

  Future<void> _playCurrentAudio({bool autoPlay = false}) async {
    final audioRef = widget.sequences[_currentSequenceIndex].audioRef;
    if (audioRef == null) return;

    String fileName = '';
    switch (audioRef) {
      case 'intro':
        fileName = 'cat_cow_intro.mp3';
        break;
      case 'loop':
        fileName = 'cat_cow_loop.mp3';
        break;
      case 'outro':
        fileName = 'cat_cow_outro.mp3';
        break;
    }

    await _audioPlayer.setAsset('assets/audio/$fileName');
    if (autoPlay) {
      await _audioPlayer.play();
      _updateScriptIndex(0);
    }
  }

  void _goToNextPose() async {
    _syncTimer?.cancel();

    if (_currentSequenceIndex < widget.sequences.length - 1) {
      setState(() {
        _currentSequenceIndex++;
        _currentScriptIndex = 0;
        _position = Duration.zero;
        _duration = Duration.zero;
        _isPaused = false;
      });
      await _playCurrentAudio(autoPlay: true);

      _syncTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
        if (!_isPaused) {
          _updateScriptIndex(_position.inSeconds);
        }
      });
    } else {
      await _audioPlayer.stop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => YogaCompletionScreen()),
      );
    }
  }

  void _goToPreviousPose() async {
    _syncTimer?.cancel();

    if (_currentSequenceIndex > 0) {
      setState(() {
        _currentSequenceIndex--;
        _currentScriptIndex = 0;
        _position = Duration.zero;
        _duration = Duration.zero;
        _isPaused = false;
      });
      await _playCurrentAudio(autoPlay: true);

      _syncTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
        if (!_isPaused) {
          _updateScriptIndex(_position.inSeconds);
        }
      });
    }
  }

  void _togglePauseResume() {
    if (_isPaused) {
      _audioPlayer.play();
      _syncTimer?.cancel();
      _syncTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
        if (!_isPaused) {
          _updateScriptIndex(_position.inSeconds);
        }
      });
    } else {
      _audioPlayer.pause();
      _syncTimer?.cancel();
    }
    setState(() => _isPaused = !_isPaused);
  }

  Future<void> _showPauseDialog() async {
    await _audioPlayer.pause();

    final choice = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Paused"),
        content: const Text("What would you like to do?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'restart'),
            child: const Text("Restart"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'quit'),
            child: const Text("Quit"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'resume'),
            child: const Text("Resume"),
          ),
        ],
      ),
    );

    switch (choice) {
      case 'restart':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => CountdownScreen(
              scripts: [],
              model: YogaAppModel(
                sequence: widget.sequences,
                assets: Assets(images: widget.images),
              ),
            ),
          ),
        );
        break;
      case 'quit':
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
        break;
      case 'resume':
        _audioPlayer.play();
        setState(() => _isPaused = false);
        break;
    }
  }

  @override
  void dispose() {
    _syncTimer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final script = currentScripts[_currentScriptIndex];
    final imagePath = getImageFile(script.imageRef);

    final progressDuration = _duration.inSeconds > 0 ? _duration.inSeconds : 1;

    return Scaffold(
      backgroundColor: const Color(0xFFE8F5F2), // Soft greenish-white
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _showPauseDialog,
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.teal),
                  ),
                  const Spacer(),
                  Text(
                    'Step ${_currentSequenceIndex + 1}/${widget.sequences.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/$imagePath',
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                script.text ?? '',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: LinearProgressIndicator(
                value: _position.inSeconds / progressDuration,
                minHeight: 10,
                backgroundColor: Colors.teal[50],
                color: Colors.teal,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _controlButton(Icons.skip_previous, _goToPreviousPose),
                  _controlButton(
                    _isPaused ? Icons.play_arrow : Icons.pause,
                    _togglePauseResume,
                  ),
                  _controlButton(Icons.skip_next, _goToNextPose),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _controlButton(IconData icon, VoidCallback onPressed) {
    return ClipOval(
      child: Material(
        color: Colors.teal[100],
        child: InkWell(
          splashColor: Colors.tealAccent,
          onTap: onPressed,
          child: SizedBox(
            width: 56,
            height: 56,
            child: Icon(icon, size: 30, color: Colors.teal[800]),
          ),
        ),
      ),
    );
  }
}
