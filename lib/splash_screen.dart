import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/onboardscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> _initializeApp() async {
    // Perform heavy initializations here
    await Future.delayed(const Duration(seconds: 1)); // Simulating heavy initialization
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _initializeApp().then((_) {
      Future.delayed(const Duration(seconds: 1), () {
        _checkOnboardingStatus(context);
      });
    });
  }


  Future<void> _checkOnboardingStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

    if (onboardingCompleted) {
      // Onboarding already completed, navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // Onboarding not completed, navigate to OnboardingView
      Navigator.of(context).pushReplacement(

        MaterialPageRoute(
          builder: (_) => OnboardingView(),
        ),
      );
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.blue],
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo2.png', // Update with your image asset path
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Eyes 20',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontFamily: 'ArchitectsDaughter', // Wrap the font family name in quotes
                    color: Colors.white,
                    fontSize:25 ,
                  ),
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter, // Adjust alignment to bottom-center
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Developed by',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:15,
                    ),
                  ),
                  Text(
                    'VIGNESHWARAN K',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
