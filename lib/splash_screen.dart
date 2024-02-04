import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> _initializeApp() async {
    // Perform heavy initializations here
    await Future.delayed(Duration(seconds: 3)); // Simulating heavy initialization
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _initializeApp().then((_) {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const HomePage(),
          ),
        );
      });
    });
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [Colors.blueAccent, Colors.blue],
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
                SizedBox(height: 20),
                Text(
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
          Align(
            alignment: Alignment.bottomCenter, // Adjust alignment to bottom-center
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
