import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'Notification_service.dart';
import 'package:provider/provider.dart';
import 'dark_mode_provider.dart';


const int kWorkDurationInSeconds = 20*60;
const int kRestDurationInSeconds = 20;

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  _Page1State createState() => _Page1State();

}

class _Page1State extends State<Page1> {

  final NotificationService notificationService = NotificationService();
  double percent = 0.0;
  bool isRunning = false;
  int elapsedTime = 0;
  Timer? timer;
  AudioPlayer audioPlayer = AudioPlayer();
  bool isWorkPhase = false;
  bool isButtonDisabled = false;
  var foregroundTask = FlutterForegroundTask();
  bool isForegroundTaskRunning = false;


  @override
  void initState(){

    notificationService.initNotification();
    notificationService.requestNotificationPermission();
    isWorkPhase = elapsedTime <= kWorkDurationInSeconds;
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeProvider>(context);
    return Scaffold(
      backgroundColor: darkModeProvider.darkModeEnabled ? Colors.black : Colors.blueAccent,
      appBar: AppBar(
        title: const Text(
          '20-20-20',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: darkModeProvider.darkModeEnabled ? Colors.black : Colors.blueAccent,
        toolbarHeight: 60.0,
      ),
        body: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
          padding: const EdgeInsets.symmetric(vertical: 130.0, horizontal: 20.0),
          child: Center(
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
                    elapsedTime < kWorkDurationInSeconds
                        ? kWorkDurationInSeconds - elapsedTime
                        : kRestDurationInSeconds - (elapsedTime - kWorkDurationInSeconds)),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 60.0,
                    color:darkModeProvider.darkModeEnabled ? Colors.white : Colors.white,
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
                ElevatedButton(
                  onPressed: isButtonDisabled ? null : () {
                    startTimer();
                    setState(() {
                      isButtonDisabled = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 34),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      //side: const BorderSide(color: Colors.white, width: 0),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Start",
                    style: TextStyle(color: Colors.white,fontSize: 17,),
                  ),
                ),
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
                    style: TextStyle(color: Colors.white,fontSize: 17,),
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
          if (elapsedTime <= kWorkDurationInSeconds) {
            // Work cycle
            percent = elapsedTime / kWorkDurationInSeconds;
            if( elapsedTime == kWorkDurationInSeconds)
            {
              playSound();
            }
            if (elapsedTime==0){
              playSound();

            }
            else if (elapsedTime==1){
              showNotification("Start Work", "Enjoy Your Life");
            }
            else if (elapsedTime == kWorkDurationInSeconds-1) {
              showNotification("Stop Work", "Enjoy Your Break Time");
            }
          } else if (elapsedTime <= kWorkDurationInSeconds + kRestDurationInSeconds) {
            // Rest cycle
            percent = (elapsedTime - kWorkDurationInSeconds) / kRestDurationInSeconds;
            if (elapsedTime == kWorkDurationInSeconds+kRestDurationInSeconds){
              playSound();
            }
          } else {
            // Timer completed
            resetTimer();
            startTimer();
          }
          elapsedTime++;
          isWorkPhase = elapsedTime <= kWorkDurationInSeconds;
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