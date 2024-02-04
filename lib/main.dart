import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: "Eyes_20_Group",
        channelKey: "Eyes_20",
        channelName: "Start Working",
        channelDescription: "Start work and Enjoy",
        playSound: true,
        onlyAlertOnce: true,
        defaultColor:  Colors.blueAccent,
        importance: NotificationImportance.Max,
        criticalAlerts: true,
        channelShowBadge: true,
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(channelGroupKey: "Eyes_20_Group",
        channelGroupName: "Eyes Group",
      )
    ],
  );
  bool isAllowedToSendNotification =
  await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification){
    AwesomeNotifications().requestPermissionToSendNotifications();
  }


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}):super(key:key);

  // This widget is the root of your application.+
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}