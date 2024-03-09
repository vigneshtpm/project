import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';
import 'usercommand.dart';
import 'package:provider/provider.dart';
import 'dark_mode_provider.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  int selectedWorkHours = 0;
  int selectedWorkMinutes = 0;
  int selectedBreakMinutes = 0;

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
        toolbarHeight: 30.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 130.0, horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTimePicker(
                label: 'Select Working Time',
                hoursValue: selectedWorkHours,
                minutesValue: selectedWorkMinutes,
                onHoursUpdate: (value) {
                  setState(() {
                    selectedWorkHours = value;
                  });
                },
                onMinutesUpdate: (value) {
                  setState(() {
                    selectedWorkMinutes = value;
                  });
                },
              ),
              buildBreakTimePicker(
                label: 'Select Break Time',
                minutesValue: selectedBreakMinutes,
                onMinutesUpdate: (value) {
                  setState(() {
                    selectedBreakMinutes = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserFunc(
                        workTime: selectedWorkHours * 60 + selectedWorkMinutes,
                        breakTime: selectedBreakMinutes,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 34),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
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

  Widget buildTimePicker({
    required String label,
    required int hoursValue,
    required int minutesValue,
    required void Function(int) onHoursUpdate,
    required void Function(int) onMinutesUpdate,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberPicker(
                  value: hoursValue,
                  minValue: 0,
                  maxValue: 11,
                  onChanged: onHoursUpdate,
                  itemWidth: 80,
                  itemHeight: 50,
                  textStyle: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(width: 8),
                const Text(
                  'HH',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(width: 20),
                NumberPicker(
                  value: minutesValue,
                  minValue: 0,
                  maxValue: 59,
                  onChanged: onMinutesUpdate,
                  itemWidth: 80,
                  itemHeight: 50,
                  textStyle: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(width: 8),
                const Text(
                  'MM',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBreakTimePicker({
    required String label,
    required int minutesValue,
    required void Function(int) onMinutesUpdate,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberPicker(
                  value: minutesValue,
                  minValue: 0,
                  maxValue: 59,
                  onChanged: onMinutesUpdate,
                  itemWidth: 80,
                  itemHeight: 50,
                  textStyle: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(width: 8),
                const Text(
                  'MM',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
