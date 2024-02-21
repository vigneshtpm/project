import 'package:flutter/material.dart';
import 'package:project/Notification_service.dart';
import 'package:project/about.dart';
import 'package:project/terms.dart';
import 'package:project/help.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'dark_mode_provider.dart';

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  bool notificationsEnabled = false;
  late NotificationService notificationService;
  late DarkModeProvider darkModeProvider;

  @override
  void initState() {
    super.initState();
    darkModeProvider = Provider.of<DarkModeProvider>(context, listen: false);
    // Initialize notifications when the widget is created
    notificationService = NotificationService();
    notificationService.initNotification();
    // Load settings from shared preferences
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notificationsEnabled = prefs.getBool('notificationsEnabled') ?? false;
      darkModeProvider.darkModeEnabled =
          prefs.getBool('darkModeEnabled') ?? false;
    });
  }

  Future<void> handleNotificationsSwitch(bool value) async {
    // Request notification permission
    await notificationService.requestNotificationPermission();
    setState(() {
      notificationsEnabled = value;
    });


    // Save setting to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notificationsEnabled', value);
  }

  @override
  Widget build(BuildContext context) {
    final darkModeEnabledProvider =
    Provider.of<DarkModeProvider>(context, listen: false);
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        textTheme: ThemeData
            .light()
            .textTheme
            .apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: darkModeEnabledProvider.darkModeEnabled
          ? ThemeMode.dark
          : ThemeMode.light,
      home: Scaffold(
        backgroundColor: darkModeProvider.darkModeEnabled ? Colors.black : Colors.blueAccent,
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: darkModeProvider.darkModeEnabled ? Colors.black : Colors.blueAccent,
          toolbarHeight: 110.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'App Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                dense: true,
              ),

              ListTile(
                title: Text(
                  'Dark Mode',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Switch(
                  value: darkModeProvider.darkModeEnabled,
                  onChanged: (value) async {
                    setState(() {
                      darkModeProvider.darkModeEnabled = value;
                    });
                    // Save setting to shared preferences
                    SharedPreferences prefs = await SharedPreferences
                        .getInstance();
                    prefs.setBool('darkModeEnabled', value);
                  },
                  activeTrackColor: Colors.grey,
                  activeColor: Colors.white,
                ),
              ),
              Divider(
                color: Colors.white,
                thickness: 1.0,
              ),
              ListTile(
                title: Text(
                  'More',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                dense: true,
              ),
              ListTile(
                title: Row(
                  children: [
                    Text(
                      'About Us',
                      style: TextStyle(color: Colors.white),
                    ),
                    Spacer(),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUsPage()),
                  );
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Text(
                      'Terms and Conditions',
                      style: TextStyle(color: Colors.white),
                    ),
                    Spacer(),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Terms()),
                  );
                },
              ),
              Divider(
                color: Colors.white,
                thickness: 1.0,
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.help, color: Colors.white),
                    SizedBox(width: 16.0),
                    Text(
                      'Help',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Help()),
                  );
                },
              ),
              ExpansionTile(
                title: Container(
                  decoration: BoxDecoration(),
                  child: Row(
                    children: [
                      Icon(Icons.feedback, color: Colors.white),
                      SizedBox(width: 16.0),
                      Text(
                        'Feedback',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_down,
                  color:darkModeProvider.darkModeEnabled ? Colors.black : Colors.blueAccent,
                ),
                backgroundColor: darkModeProvider.darkModeEnabled ? Colors.black : Colors.blueAccent,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Icon(Icons.email, color: Colors.white),
                              SizedBox(width: 16.0),
                              Text(
                                'vigneshwaranrk2@gmail.com',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
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
}