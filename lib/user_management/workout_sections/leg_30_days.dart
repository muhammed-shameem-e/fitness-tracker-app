import 'package:flutter/material.dart';
import 'package:fullbody_workout/user_management/workout_sections/listview_of_30days.dart/leg_daylist.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Leg30Days extends StatefulWidget {
  const Leg30Days({super.key});

  @override
  State<Leg30Days> createState() => _Leg30DaysState();
}

class _Leg30DaysState extends State<Leg30Days> {
  int _lastCompletedDay = 0;

  @override
  void initState() {
    super.initState();
    _loadLastCompletedDay();
  }

  Future<void> _loadLastCompletedDay() async {
    final box = await Hive.openBox('legWorkoutBox');
    setState(() {
      _lastCompletedDay = box.get('lastCompletedLegDay', defaultValue: 0);
    });
  }

  Future<void> _updateLastCompletedDay(int day) async {
    final box = await Hive.openBox('legWorkoutBox');
    await box.put('lastCompletedLegDay', day);
    setState(() {
      _lastCompletedDay = day;
    });
  }

  Future<void> alertRestart() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Restart'),
          content: const Text('Are you sure you want to restart your exercises from day one?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('NO', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () async {
                await _updateLastCompletedDay(0);
                setState(() {
                  _lastCompletedDay = 0;
                });
                Navigator.of(context).pop();
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Leg Section', style: TextStyle(fontWeight: FontWeight.w500)),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              alertRestart();
            },
            icon: const Icon(Icons.restart_alt),
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/legexercise.jpg',
                      fit: BoxFit.cover,
                      height: 225,
                      width: double.infinity,
                    ),
                  ),
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
                        LinearProgressIndicator(
                          value: _lastCompletedDay / 30,
                          color: Colors.green,
                          backgroundColor: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Use the separated LegExerciseListPage
              LegDaysList(
                lastCompletedDay: _lastCompletedDay,
                updateLastCompletedDay: _updateLastCompletedDay,
                isDarkMode: isDarkMode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
