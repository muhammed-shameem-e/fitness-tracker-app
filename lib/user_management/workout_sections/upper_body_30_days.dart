import 'package:flutter/material.dart';
import 'package:fullbody_workout/user_management/workout_sections/listview_of_30days.dart/upperbody_daylist.dart';
import 'package:hive/hive.dart';


class UpperBody30Days extends StatefulWidget {
  const UpperBody30Days({super.key});

  @override
  State<UpperBody30Days> createState() => _UpperBody30DaysState();
}

class _UpperBody30DaysState extends State<UpperBody30Days> {
  int _lastCompletedDay = 0;

  @override
  void initState() {
    super.initState();
    // Load the last completed day from the Hive box when the page initializes.
    _loadLastCompletedDay();
  }

  // Load the last completed day from Hive.
  Future<void> _loadLastCompletedDay() async {
    final box = await Hive.openBox('upperBodyWorkoutBox');
    setState(() {
      _lastCompletedDay = box.get('lastCompletedUpperBodyDay', defaultValue: 0);
    });
  }

  // Update the last completed day in Hive.
  Future<void> _updateLastCompletedDay(int day) async {
    final box = await Hive.openBox('upperBodyWorkoutBox');
    await box.put('lastCompletedUpperBodyDay', day);
    setState(() {
      _lastCompletedDay = day;
    });
  }

  // Show a confirmation dialog for restarting the exercises from day 1.
  Future<void> alertRestart() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Restart'),
          content: const Text('Are you sure you want to restart your exercises from the first day?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without restarting.
              },
              child: const Text('NO', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () async {
                await _updateLastCompletedDay(0); // Reset the last completed day to 0.
                Navigator.of(context).pop(); // Close the dialog after resetting.
              },
              child: const Text('YES', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('UpperBody Section', style: TextStyle(fontWeight: FontWeight.w500)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              alertRestart(); // Trigger the restart confirmation dialog.
            },
            icon: const Icon(Icons.restart_alt, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  // Display the image at the top of the page.
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/upperbodyexercise.jpg',
                      fit: BoxFit.cover,
                      height: 225,
                      width: double.infinity,
                    ),
                  ),
                  // Overlay the text and progress bar on top of the image.
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 180),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${30 - _lastCompletedDay} days left',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${((_lastCompletedDay / 30) * 100).toStringAsFixed(0)}% completed',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        // Progress bar showing completion percentage.
                        LinearProgressIndicator(
                          value: _lastCompletedDay / 30,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Call the UpperBodyDaysList widget and pass the necessary parameters.
              UpperBodyDaysList(
                lastCompletedDay: _lastCompletedDay,
                updateLastCompletedDay: _updateLastCompletedDay,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
