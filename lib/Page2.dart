import 'package:flutter/material.dart';
import 'usercommand.dart';

class Page2 extends StatefulWidget {
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
              child: InkWell(
                onTap: () => _selectWorkTime(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Select Working Time',
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "$selectedWorkTimeInMinutes minutes",
                        style: TextStyle(fontSize: 17.0, color: Colors.white),
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
                  decoration: InputDecoration(
                    labelText: 'Select Break Time',
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "$selectedBreakTimeInMinutes minutes",
                        style: TextStyle(fontSize: 17.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
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
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 34),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.white, width: 1),
                ),
                elevation: 5,
              ),
              child: const Text(
                "Next",
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
