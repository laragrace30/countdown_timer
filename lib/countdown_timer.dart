import 'package:countdown_timer/widgets/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({Key? key}) : super(key: key);

  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer> {
  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 1800); // 30 minutes

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    if (countdownTimer != null && countdownTimer!.isActive) {
      setState(() => countdownTimer!.cancel());
    }
  }

  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(seconds: 1800)); // Reset to 30 minutes
  }

  void setCountDown() {
    setState(() {
      final minutes = myDuration.inMinutes;
      final seconds = myDuration.inSeconds.remainder(60);
      if (minutes == 0 && seconds == 0) {
        countdownTimer?.cancel();
      } else {
        myDuration = myDuration - const Duration(seconds: 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = strDigits(myDuration.inMinutes);
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartWOD Timer',
        style: TextStyle(
          fontSize: 24,
        ),
        ),
        backgroundColor: Colors.deepPurple.shade800,
         actions: const [
             IconButton(
             icon: Icon(Icons.settings), 
             onPressed: null,
          ),
         ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade800.withOpacity(0.8),
              Colors.deepPurple.shade200.withOpacity(0.8),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                '$minutes:$seconds',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: startTimer,
                child: const Text(
                  'Start',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: stopTimer,
                child: const Text(
                  'Stop',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: resetTimer,
                child: const Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
