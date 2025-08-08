import 'dart:async';
import 'package:flutter/material.dart';
import '../models/yoga_app_model.dart';
import 'pose_screen.dart';

class CountdownScreen extends StatefulWidget {
  final List<Map<String, dynamic>> scripts;
  final YogaAppModel model;

  const CountdownScreen({
    super.key,
    required this.scripts,
    required this.model,
  });

  @override
  State<CountdownScreen> createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  int _seconds = 3;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 1) {
        timer.cancel();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PoseScreen(
              sequences: widget.model.sequence ?? [],
              images: widget.model.assets?.images,
            ),
          ),
        );
      } else {
        setState(() {
          _seconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F2F1), // Light teal background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ARE YOU READY?',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Color(0xFF004D40),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF00796B),
                  width: 10,
                ),
              ),
              child: Center(
                child: Text(
                  '$_seconds',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004D40),
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
