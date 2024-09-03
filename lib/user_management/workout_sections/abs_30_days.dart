import 'package:flutter/material.dart';
import 'package:fullbody_workout/user_management/workout_sections/abs_things/show_abs_exercise.dart';
import 'package:hive/hive.dart';
import 'rest_day_page.dart';

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
    // Load the last completed day from Hive when the widget is initialized.
    _loadLastCompletedDay();
  }

  // Load the last completed day from Hive.
  Future<void> _loadLastCompletedDay() async {
    final box = await Hive.openBox('absWorkoutBox');
    setState(() {
      _lastCompletedDay = box.get('lastCompletedAbsDay', defaultValue: 0);
    });
  }

  // Update the last completed day in Hive and state.
  Future<void> _updateLastCompletedDay(int day) async {
    final box = await Hive.openBox('absWorkoutBox');
    await box.put('lastCompletedAbsDay', day);
    setState(() {
      _lastCompletedDay = day;
    });
  }

  // Show an alert dialog to confirm restarting exercises.
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
        title: const Text(
          'Abs Section',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
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
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${((_lastCompletedDay / 30) * 100).toStringAsFixed(0)}% completed',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        LinearProgressIndicator(
                          value: _lastCompletedDay / 30,
                          color: Theme.of(context).colorScheme.secondary,
                          backgroundColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 400,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    bool isRestDay = (index + 1) % 7 == 0;
                    bool isCompleted = index < _lastCompletedDay;
                    bool isCurrentDay = index == _lastCompletedDay;

                    return GestureDetector(
                      onTap: () async {
                        if (isCompleted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'You have already completed this day. Try to do the current day.',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.all(20),
                            ),
                          );
                        } else if (isRestDay) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RestDayPage(
                                onComplete: () async {
                                  await _updateLastCompletedDay(index + 1);
                                },
                              ),
                            ),
                          );
                        } else if (isCurrentDay) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ShowAbsExercise(
                                onComplete: () async {
                                  await _updateLastCompletedDay(index + 1);
                                },
                                completedDay: index + 1,
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isCurrentDay
                              ? Colors.green
                              : isRestDay
                                  ? Theme.of(context).colorScheme.surface
                                  : Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  isRestDay
                                      ? 'Rest Day'
                                      : 'Day ${index + 1}',
                                  style: TextStyle(
                                    color: isCurrentDay || isRestDay
                                        ? Theme.of(context).colorScheme.onSurface
                                        : Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                if (isCurrentDay && !isRestDay)
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => ShowAbsExercise(
                                            onComplete: () async {
                                              await _updateLastCompletedDay(index + 1);
                                            },
                                            completedDay: index + 1,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(255, 216, 255, 217),
                                    ),
                                    child: const Text(
                                      'Start',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                if (isCompleted)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 30),
                                    child: Text(
                                      'Completed',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.secondary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) => const SizedBox(height: 10),
                  itemCount: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
