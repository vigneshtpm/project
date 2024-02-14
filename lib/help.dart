import 'package:flutter/material.dart';

class Help extends StatelessWidget {
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
          'Help',
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
                'Application Features:',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '- Predefined settings for working time and break time.',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              Text(
                '- Ability to customize working and break durations.',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              Text(
                '- Addition feature for quick calculations.',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              Text(
                '- Mobile-friendly UI with intuitive design.',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              SizedBox(height: 20.0),
              Text(
                'How to Use the Application:',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '1. Open the application on your mobile device.',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              Text(
                '2. Navigate to the Settings page to configure working and break durations.',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              Text(
                '3. Use the Addition feature for quick calculations.',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              Text(
                '4. Enjoy a focused and productive work routine!',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              SizedBox(height: 20.0),
              Text(
                'Predefined Settings:',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'The application comes with default settings for working time and break time.',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              Text(
                'You can customize these settings based on your preferences.',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              SizedBox(height: 20.0),
              Text(
                'Mobile UI Images:',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              // Include mobile UI images here.
              // You can use Image widgets or other relevant methods.

              SizedBox(height: 20.0),
              Text(
                'Content:',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Write detailed content about the application, its purpose, and how it benefits users.',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
