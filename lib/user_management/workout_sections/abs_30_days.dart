import 'package:flutter/material.dart';
import 'package:fullbody_workout/user_management/workout_sections/listview_of_30days.dart/abs_daylist.dart';
import 'package:hive/hive.dart';

class Abs30Days extends StatefulWidget {
  const Abs30Days({super.key});

  @override
  State<Abs30Days> createState() => _Abs30DaysState();
}

class _Abs30DaysState extends State<Abs30Days> {
  int _lastCompletedDay = 0;

  @override
  void initState() {
    super.initState();
    _loadLastCompletedDay();
  }

  Future<void> _loadLastCompletedDay() async {
    final box = await Hive.openBox('absWorkoutBox');
    setState(() {
      _lastCompletedDay = box.get('lastCompletedAbsDay', defaultValue: 0);
    });
  }

  Future<void> _updateLastCompletedDay(int day) async {
    final box = await Hive.openBox('absWorkoutBox');
    await box.put('lastCompletedAbsDay', day);
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
          content: const Text('Are you sure you want to restart your exercises from the beginning?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'NO',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            TextButton(
              onPressed: () async {
                await _updateLastCompletedDay(0);
                Navigator.of(context).pop();
              },
              child: Text(
                'YES',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
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
        title: const Text('Abs Section', style: TextStyle(fontWeight: FontWeight.w500)),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: [
          IconButton(
            onPressed: alertRestart,
            icon: const Icon(Icons.restart_alt),
            color: Theme.of(context).iconTheme.color,
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
                      'assets/absexercise.jpg',
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
              AbsWorkoutList(
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
