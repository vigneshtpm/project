import 'package:flutter/material.dart';


class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
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
                  setState(() {
                    notificationsEnabled = value;
                  });
                  // Add logic to handle enabling/disabling notifications
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
                  // Add logic to handle enabling/disabling dark mode
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
                'Additional Settings',
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
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
              onTap: () {
                // Navigate to About Us page
                // You can use Navigator.push to navigate to the desired page
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
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
              onTap: () {
                // Navigate to Terms and Conditions page
                // You can use Navigator.push to navigate to the desired page
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
                // Add logic to handle the Help action
                // For example, show a help dialog or navigate to a help page
              },
            ),

            // Feedback ListTile with an icon
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.feedback, color: Colors.white), // Feedback icon
                  SizedBox(width: 16.0),
                  Text(
                    'Feedback',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              onTap: () {
                // Add logic to handle the Feedback action
                // For example, show a feedback form or navigate to a feedback page
              },
            ),
          ],
        ),
      ),
    );
  }
}

