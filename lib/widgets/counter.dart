import 'dart:async';

import 'package:flutter/material.dart';

class CountdownContainer extends StatefulWidget {
  final Duration duration;
  final Function()? onFinish;

  CountdownContainer({required this.duration,required this.onFinish});

  @override
  _CountdownContainerState createState() => _CountdownContainerState();
}

class _CountdownContainerState extends State<CountdownContainer> {
  late Timer _timer;
  late int _secondsRemaining;
  

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.duration.inSeconds;
    _startTimer();
  }

  void _startTimer() {
    if (_secondsRemaining > 0) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (_secondsRemaining > 0) {
            _secondsRemaining--;
          } else {
            _timer.cancel();
            widget.onFinish!();
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    int days = duration.inDays;
    int hours = (duration.inHours % 24);
    int minutes = (duration.inMinutes % 60);
    int seconds = (duration.inSeconds % 60);

    return '$days:${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 175, 48, 39),width: 3), // Red border
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Time Left : ${_formatDuration(Duration(seconds: _secondsRemaining))}',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
          ),
        ],
      ),
    );
  }
}