import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  double percent = 0.0;
  bool isRunning = false;
  int duration = 1 * 60; // 20 minutes in seconds
  int elapsedTime = 0;
  Timer? timer;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Text(
          '20-20-20',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 13.0,
              animation: true,
              animateFromLastPercent: true,
              percent: percent,
              center: Text(
                formatTime(duration - elapsedTime),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              footer: Text(
                "",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.purple,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    startTimer();
                  },
                  child: Text("Start"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    stopTimer();
                  },
                  child: Text("Stop"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    if (!isRunning) {
      timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
        if (elapsedTime < duration) {
          setState(() {
            percent = elapsedTime / duration;
            elapsedTime++;
          });
        } else {
          // Timer completed
          stopTimer();
          playSound();
        }
      });
      isRunning = true;
    }
  }

  void stopTimer() {
    if (isRunning) {
      timer?.cancel();
      isRunning = false;
      setState(() {
        percent = 0.0;
        elapsedTime = 0;
      });
    }
  }

  void playSound() async {
    await audioPlayer.setAsset('assets/audio/sample.mp3'); // replace with your sound file
    await audioPlayer.play();
  }

  String formatTime(int seconds) {
    int minutes = (seconds / 60).floor();
    int remainingSeconds = seconds % 60;

    String minutesStr = minutes < 10 ? '0$minutes' : '$minutes';
    String secondsStr = remainingSeconds < 10 ? '0$remainingSeconds' : '$remainingSeconds';

    return '$minutesStr:$secondsStr';
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
