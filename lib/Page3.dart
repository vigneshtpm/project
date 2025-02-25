import 'package:flutter/material.dart';
import 'package:project/Notification_service.dart';
import 'package:project/Onboardhelp.dart';
import 'package:project/about.dart';
import 'package:project/terms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'dark_mode_provider.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

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
            style: TextStyle(
              color: Colors.white,
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: darkModeProvider.darkModeEnabled ? Colors.black : Colors.blueAccent,
          toolbarHeight: 60.0,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Your existing settings UI...
                    const ListTile(
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
                      title: const Text(
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
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          prefs.setBool('darkModeEnabled', value);
                        },
                        activeTrackColor: Colors.grey,
                        activeColor: Colors.white,
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 1.0,
                    ),
                    const ListTile(
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
                      title: const Row(
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
                          MaterialPageRoute(builder: (context) => const AboutUsPage()),
                        );
                      },
                    ),
                    ListTile(
                      title: const Row(
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
                    const Divider(
                      color: Colors.white,
                      thickness: 1.0,
                    ),
                    ListTile(
                      title: const Row(
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
                          MaterialPageRoute(builder: (context) => OnboardingHelp()),
                        );
                      },
                    ),
                    ExpansionTile(
                      title: Container(
                        decoration: const BoxDecoration(),
                        child: const Row(
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
                      children: const [
                        Column(
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(

              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: darkModeProvider.darkModeEnabled ? Colors.black.withOpacity(1.0) : Colors.blueAccent.withOpacity(1.0),
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    '\u00a9 Vigneshwaran 2024',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
