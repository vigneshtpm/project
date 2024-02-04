import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'Notification_service.dart';

class UserFunc extends StatefulWidget {
  final int workTime;
  final int breakTime;

  UserFunc({required this.workTime, required this.breakTime});

  @override
  _UserFuncState createState() => _UserFuncState();
}

class _UserFuncState extends State<UserFunc> {
  final NotificationService notificationService = NotificationService();
  late int convertedWorkTime;
  late int convertedBreakTime;
  double percent = 0.0;
  bool isRunning = false;
  int elapsedTime = 0;
  Timer? timer;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    notificationService.initNotification();
    // Convert workTime and breakTime to seconds
    convertedWorkTime = widget.workTime * 60;
    convertedBreakTime = widget.breakTime * 60;
  }

  @override
  Widget build(BuildContext context) {
    bool isWorkPhase = elapsedTime <= convertedWorkTime;
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Add logic to navigate back when the back arrow is pressed
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Running...',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        toolbarHeight: 110.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isWorkPhase ? 'Working Time' : 'Break Time',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isWorkPhase ? 24.0 : 22.0,  // Adjust the font size for Working Time label
                color: Colors.white,
              ),
            ),
            SizedBox(height: isWorkPhase ? 30.0 : 25.0),
            CircularPercentIndicator(
              radius: 138.0,
              lineWidth: 15.0,
              animation: true,
              animateFromLastPercent: true,
              percent: percent,
              center: Text(
                formatTime(
                  isWorkPhase
                      ? convertedWorkTime - elapsedTime
                      : convertedBreakTime - (elapsedTime - convertedWorkTime),
                ),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.white,
              progressColor: Colors.blueAccent,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    startTimer();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 34),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.white, width: 1),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Start",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    stopTimer();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 34),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.white, width: 1),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Stop",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void showNotification(String title, String body) {
    notificationService.showNotification(title: title, body: body);
  }

  void startTimer() {
    if (!isRunning) {
      timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
        setState(() {
          if (elapsedTime <= convertedWorkTime) {
            // Work cycle
            percent = elapsedTime / convertedWorkTime;
            if( elapsedTime == convertedBreakTime)
            {
              playSound();
            }
            if (elapsedTime==1){
              showNotification("Start Work", "Enjoy Your Life");
            }
            else if (elapsedTime == convertedWorkTime-1) {
              showNotification("Stop Work", "Enjoy Your Break Time");
            }
          } else if (elapsedTime <= convertedBreakTime + convertedBreakTime) {
            // Rest cycle
            percent = (elapsedTime - convertedWorkTime) / convertedBreakTime;
            if (elapsedTime == convertedWorkTime+convertedBreakTime){
              playSound();
            }
          } else {
            // Timer completed
            resetTimer();
            startTimer();
          }
          elapsedTime++;
        });
      });
      isRunning = true;
    }
  }

  void resetTimer() {
    timer?.cancel();
    isRunning=false;
    setState(() {
      elapsedTime = 0;
      percent = 0.0;
    });
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
    await audioPlayer.setAsset('assets/audio/sample1.mp3');
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
