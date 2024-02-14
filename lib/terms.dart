// terms_and_conditions.dart

import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Terms & Conditions',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        toolbarHeight: 110.0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(), // or ClampingScrollPhysics()
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '20-20-20 Rule',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'The 20-20-20 rule is a guideline designed to reduce eye strain and discomfort caused by prolonged use of digital devices. It suggests taking a 20-second break to look at something 20 feet away every 20 minutes of screen time.',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              SizedBox(height: 20.0),
              Text(
                'Guidelines for Following the Rule:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              buildBulletPoint('- Frequency: Commit to following the 20-20-20 rule consistently throughout your screen time.'),
              buildBulletPoint('- Reminders: Set alarms or use reminder apps to prompt you to take breaks every 20 minutes.'),
              buildBulletPoint('- Compliance: Make a conscious effort to adhere to the rule, acknowledging its importance in preventing eye strain.'),
              buildBulletPoint('- Duration: Ensure that you take a break for at least 20 seconds, looking at something 20 feet away to allow your eyes to relax.'),
              buildBulletPoint('- Environment: Choose a point of focus during your break that is approximately 20 feet away to maximize the benefits of the rule.'),
              buildBulletPoint('- Consistency: Apply the 20-20-20 rule across various devices, such as computers, tablets, and smartphones.'),
              buildBulletPoint('- Adjustments: Modify the rule based on your specific needs, considering factors like the nature of your work, screen brightness, and ambient lighting.'),
              SizedBox(height: 20.0),
              Text(
                'Remember, the 20-20-20 rule is a guideline rather than a strict set of terms and conditions. Adjust it to suit your individual preferences and work habits, but the key is to incorporate regular breaks to alleviate eye strain associated with prolonged screen use.',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          Flexible(
            child: Text(
              text,
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
