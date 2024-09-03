import 'package:flutter/material.dart';
import 'package:fullbody_workout/user_management/workout_sections/leg_things/show_leg_exercise.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'rest_day_page.dart';

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
    // Load the last completed day from Hive when the widget is initialized.
    _loadLastCompletedDay();
  }

  // Load the last completed day from Hive.
  Future<void> _loadLastCompletedDay() async {
    final box = await Hive.openBox('legWorkoutBox');
    setState(() {
      _lastCompletedDay = box.get('lastCompletedLegDay', defaultValue: 0);
    });
  }

  // Update the last completed day in Hive.
  Future<void> _updateLastCompletedDay(int day) async {
    final box = await Hive.openBox('legWorkoutBox');
    await box.put('lastCompletedLegDay', day);
  }

  // Show an alert dialog to confirm restarting exercises.
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
                // Reset the last completed day to 0 and update state.
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
                            const SnackBar(
                              content: Text(
                                'You have already completed this day. Try to do the current day.',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(20),
                            ),
                          );
                        } else if (isRestDay) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RestDayPage(
                                onComplete: () async {
                                  await _updateLastCompletedDay(index + 1);
                                  setState(() {
                                    _lastCompletedDay = index + 1;
                                  });
                                },
                              ),
                            ),
                          );
                        } else if (isCurrentDay) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ShowLegExercise(
                                onComplete: () async {
                                  await _updateLastCompletedDay(index + 1);
                                  setState(() {
                                    _lastCompletedDay = index + 1;
                                  });
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
                                  ? (isDarkMode ? Colors.grey[850] : Colors.grey[200])
                                  : (isDarkMode ? Colors.grey[850] : Colors.grey[200]),
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
                                  isRestDay ? 'Rest Day' : 'Day ${index + 1}',
                                  style: TextStyle(
                                    color: isCurrentDay || isRestDay
                                        ? (isDarkMode ? Colors.white : Colors.black)
                                        : (isDarkMode ? Colors.white70 : Colors.black87),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                if (isCurrentDay && !isRestDay)
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => ShowLegExercise(
                                            onComplete: () async {
                                              await _updateLastCompletedDay(index + 1);
                                              setState(() {
                                                _lastCompletedDay = index + 1;
                                              });
                                            },
                                            completedDay: index + 1,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 216, 255, 217)),
                                    ),
                                    child: const Text('Start', style: TextStyle(color: Colors.black)),
                                  ),
                                if (isCompleted)
                                  const Padding(
                                    padding: EdgeInsets.only(right: 30),
                                    child: Text(
                                      'Completed',
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 49, 105, 51),
                                          fontWeight: FontWeight.w500),
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
