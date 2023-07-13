import 'package:flutter/material.dart';
import 'dart:async';

class CountdownPage extends StatefulWidget {
  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  Timer? _timer;
  int _countdownSeconds = 120;

  @override
  void initState() {
    super.initState();
    _startCountdownTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (_countdownSeconds == 0) {
        _timer?.cancel();
        // Code à exécuter après le décompte
      } else {
        setState(() {
          _countdownSeconds--;
        });
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _formatTime(_countdownSeconds),
        style: TextStyle(
            fontSize: 27, fontWeight: FontWeight.w700, color: Colors.white),
      ),
    );
  }
}
