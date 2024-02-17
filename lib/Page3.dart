import 'package:flutter/material.dart';
import 'package:project/Notification_service.dart';
import 'about.dart';
import 'terms.dart';
import 'help.dart';

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  bool notificationsEnabled = false;
  bool darkModeEnabled = false;
  NotificationService notificationService = NotificationService();


  @override
  void initState() {
    super.initState();
    // Initialize notifications when the widget is created
    notificationService.initNotification();
  }

  Future<void> handleNotificationsSwitch(bool value) async {
    // Request notification permission
    await notificationService.requestNotificationPermission();

    setState(() {
      notificationsEnabled = value;
    });

    // Add logic to handle enabling/disabling notifications
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: darkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        backgroundColor: darkModeEnabled ? Colors.black : Colors.blueAccent,
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: darkModeEnabled ? Colors.black : Colors.blueAccent,
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
                  'Notifications',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Switch(
                  value: notificationsEnabled,
                  onChanged: (value) {
                    handleNotificationsSwitch(value);
                  },
                  activeTrackColor: Colors.grey,
                  activeColor: Colors.white,
                ),
              ),
              ListTile(
                title: Text(
                  'Dark Mode',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Switch(
                  value: darkModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      darkModeEnabled = value;
                    });
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
                  color: Colors.blueAccent,
                ),
                backgroundColor: Colors.blueAccent,
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
