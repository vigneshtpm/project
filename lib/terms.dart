import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dark_mode_provider.dart';

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeProvider>(context);
    return Scaffold(
      backgroundColor: darkModeProvider.darkModeEnabled ? Colors.black : Colors.blueAccent,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Terms & Conditions',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: darkModeProvider.darkModeEnabled ? Colors.black : Colors.blueAccent,
        toolbarHeight: 110.0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), // or ClampingScrollPhysics()
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '20-20-20 Rule',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'The 20-20-20 rule is a guideline designed to reduce eye strain and discomfort caused by prolonged use of digital devices. It suggests taking a 20-second break to look at something 20 feet away every 20 minutes of screen time.',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Guidelines for Following the Rule:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10.0),
              buildBulletPoint(' The Eyes 20 app is exclusive to Android users.'),
              buildBulletPoint(' After the Eyes 20 app launches and your smartphone enters sleep mode, counting stops. Your mobile device\'s open countdown will then start on its own.'),
              buildBulletPoint(' The primary page of this application adheres to the 20/20/20 rule.'),
              buildBulletPoint(' The following page is Customize your work schedule and downtime.'),
              buildBulletPoint(' From the user\'s perspective, enabling dark mode on the page.'),
              buildBulletPoint(' Alert alerts and readings on eye care were also utilized by this app.'),
              buildBulletPoint(' The Eyes 20 app launches and terminates. Play sound for a brief moment, push notifications, or check the reach time.'),
              buildBulletPoint('This treatment lessens tension, headache discomfort, dry eyes, and eye strain.'),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
