import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'Notification_service.dart';
import 'dark_mode_provider.dart';
import 'package:provider/provider.dart';

class UserFunc extends StatefulWidget {
  final int workTime;
  final int breakTime;

  UserFunc({super.key, required this.workTime, required this.breakTime});

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
  bool isWorkPhase = false;
  bool isButtonDisabled = false;
  bool isForegroundTaskRunning = true;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    notificationService.initNotification();

    // Convert workTime and breakTime to seconds
    convertedWorkTime = widget.workTime * 60;
    convertedBreakTime = widget.breakTime * 60;
    isWorkPhase = elapsedTime <= convertedWorkTime;
  }

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeProvider>(context);

    ElevatedButton startButton = ElevatedButton(
      onPressed: () {
        if (isPaused) {
          startTimer(); // Resume timer
          setState(() {
            isPaused = false;
          });
        } else {
          startTimer();
          setState(() {
            isButtonDisabled = true;
          });
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 34),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 5,
      ),
      child: const Text(
        "Start",
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
      ),
    );

    ElevatedButton pauseButton = ElevatedButton(
      onPressed: () {
        pauseTimer();
        setState(() {
          isPaused = true;
          isButtonDisabled = false; // Enable the start button when paused
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orangeAccent, // Change color to yellow for pause button
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 34),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          //side: const BorderSide(color: Colors.white, width: 0),
        ),
        elevation: 8,
        shadowColor: Colors.grey,
      ),
      child: const Text(
        "Pause",
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: darkModeProvider.darkModeEnabled ? Colors.black : Colors.blueAccent,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
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
        backgroundColor: darkModeProvider.darkModeEnabled ? Colors.black : Colors.blueAccent,
        toolbarHeight: 60.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 130.0, horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isWorkPhase ? 'Working Time' : 'Break Time',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isWorkPhase ? 24.0 : 22.0,
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
                    elapsedTime < convertedWorkTime
                        ? convertedWorkTime - elapsedTime
                        : convertedBreakTime - (elapsedTime - convertedWorkTime),
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 60.0,
                    color: darkModeProvider.darkModeEnabled ? Colors.white : Colors.white,
                  ),
                ),
                footer: const Text(
                  "",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.white,
                progressColor: darkModeProvider.darkModeEnabled ? Colors.black : Colors.blueAccent,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isRunning ? pauseButton : startButton,
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      stopTimer();
                      setState(() {
                        isButtonDisabled = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 34),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        //side: const BorderSide(color: Colors.white, width: 0),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      "Stop",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  void showNotification(String title, String body) {
    notificationService.showNotification(title: title, body: body);
  }

  void startTimer() {
    if (!isRunning) {
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        setState(() {
          if (elapsedTime <= convertedWorkTime) {
            // Work cycle
            percent = elapsedTime / convertedWorkTime;
            if (elapsedTime == 1) {
              showNotification(" Start Work","The work is Started");
              playSound();
            }
            else if (elapsedTime == convertedWorkTime) {
              showNotification(" Stop Work","The work is Started");
              playSound();
            }
            // Add any additional conditions or actions as needed for the work cycle
           } else if (elapsedTime <= convertedWorkTime + convertedBreakTime) {
            // Break cycle
            percent = (elapsedTime - convertedWorkTime) / convertedBreakTime;
            // Add any additional conditions or actions as needed for the break cycle
          } else {
            // Timer completed
            resetTimer();
            startTimer();
          }

          elapsedTime++;
          isWorkPhase = elapsedTime <= convertedWorkTime;
        });
      });
      isRunning = true;
    }
  }

  void resetTimer() {
    timer?.cancel();
    isRunning = false;
    setState(() {
      elapsedTime = 0;
      percent = 0.0;
    });
  }

  void pauseTimer() {
    if (isRunning) {
      timer?.cancel();
      isRunning = false;
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
