import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'usercommand.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  TextEditingController inputBox1Controller = TextEditingController();
  TextEditingController inputBox2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Text(
          'Customize',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        toolbarHeight: 110.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: inputBox1Controller,
                decoration: InputDecoration(
                  labelText: 'Enter Working Time (mins)',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.white),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.white38),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
                ],
                cursorColor: Colors.white,
                style: TextStyle(fontSize: 17.0, color: Colors.white),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: inputBox2Controller,
                decoration: InputDecoration(
                  labelText: 'Enter Break Time (mins)',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.white),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.white38),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                cursorColor: Colors.white,
                style: TextStyle(fontSize: 17.0, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Parse input values to integers
                int parsedInput1 = int.tryParse(inputBox1Controller.text) ?? 0;
                int parsedInput2 = int.tryParse(inputBox2Controller.text) ?? 0;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserFunc(
                      workTime: parsedInput1,
                      breakTime: parsedInput2,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent, // Background color
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 34), // Increase button size
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // Add border radius
                  side: BorderSide(color: Colors.white, width: 1), // Add border color and width
                ),
                elevation: 5,
              ),
              child: const Text("Next",
                style: TextStyle(
                    color: Colors.black,
                fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
