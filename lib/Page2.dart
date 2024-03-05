import 'package:flutter/material.dart' ;
import 'package:flutter/services.dart';
import 'usercommand.dart';
import 'package:provider/provider.dart';
import 'dark_mode_provider.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  int selectedWorkTimeInMinutes = 0;
  int selectedBreakTimeInMinutes = 0;

  Future<void> _selectWorkTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: selectedWorkTimeInMinutes ~/ 60, minute: selectedWorkTimeInMinutes % 60),
    );

    if (picked != null) {
      setState(() {
        selectedWorkTimeInMinutes = picked.hour * 60 + picked.minute;
      });
    }
  }

  Future<void> _selectBreakTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: selectedBreakTimeInMinutes ~/ 60, minute: selectedBreakTimeInMinutes % 60),
    );

    if (picked != null) {
      setState(() {
        selectedBreakTimeInMinutes = picked.hour * 60 + picked.minute;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeProvider>(context);
    return Scaffold(
      backgroundColor: darkModeProvider.darkModeEnabled ? Colors.black : Colors.blueAccent,
      appBar: AppBar(
        title: const Text(
          'Customize',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: darkModeProvider.darkModeEnabled ? Colors.black : Colors.blueAccent,
        toolbarHeight: 60.0,
      ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 130.0, horizontal: 20.0),
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () => _selectWorkTime(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Select Working Time',
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.white38),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "${selectedWorkTimeInMinutes ~/ 60} hours ${selectedWorkTimeInMinutes % 60} minutes",
                        style: const TextStyle(fontSize: 17.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () => _selectBreakTime(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Select Break Time',
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.white38),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "${selectedBreakTimeInMinutes ~/ 60} hours ${selectedBreakTimeInMinutes % 60} minutes",
                        style: const TextStyle(fontSize: 17.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserFunc(
                      workTime: selectedWorkTimeInMinutes,
                      breakTime: selectedBreakTimeInMinutes,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 34),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  //side: const BorderSide(color: Colors.white, width: 1),
                ),
                elevation: 5,
              ),
              child: const Text(
                "Next",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
        ),
    );
  }
}