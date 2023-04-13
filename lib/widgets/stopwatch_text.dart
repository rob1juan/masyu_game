import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchText extends StatefulWidget {
  final void Function(Duration elapsed) onElapsedChanged;

  StopwatchText({required this.onElapsedChanged});

  @override
  _StopwatchTextState createState() => _StopwatchTextState();
}

class _StopwatchTextState extends State<StopwatchText> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_stopwatch.isRunning) {
        setState(() {});
        widget.onElapsedChanged(_stopwatch.elapsed);
      }
    });
    _stopwatch.start();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(Duration duration) {
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatTime(_stopwatch.elapsed),
      style: TextStyle(
        color: Colors.white,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
