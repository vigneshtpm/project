import 'package:flutter/material.dart';
import 'dark_mode_provider.dart';
import 'package:provider/provider.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final darkModeEnabledProvider =
    Provider.of<DarkModeProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: darkModeEnabledProvider.darkModeEnabled? Colors.black : Colors.blueAccent,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: darkModeEnabledProvider.darkModeEnabled ? Colors.black : Colors.blueAccent,
        toolbarHeight: 110.0,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Name: Vigneshwaran K',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.0),
              Text(
                'Purpose: Mini-Project',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.0),
              Text(
                'Institution: Periyar University, Salem',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}