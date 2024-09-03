import 'package:flutter/material.dart';
import 'package:fullbody_workout/user_management/workout_sections/upper_body_things/show_upper_body_exercise.dart';
import 'package:hive/hive.dart';
import 'rest_day_page.dart';

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
                setState(() {
                  _lastCompletedDay = 0;
                });
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
              // List of 30 days with exercises or rest days.
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
                          // Show a snackbar if the user tries to redo a completed day.
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
                          // Navigate to the RestDayPage if it's a rest day.
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
                          // Navigate to the exercise page if it's the current day.
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ShowUpperBodyExercise(
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
                      // Styling for each day container.
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isCurrentDay
                              ? Colors.green
                              : isRestDay
                                  ? Theme.of(context).colorScheme.onInverseSurface
                                  : Theme.of(context).colorScheme.onInverseSurface,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Display 'Rest Day' or 'Day X' based on the day.
                                Text(
                                  isRestDay ? 'Rest Day' : 'Day ${index + 1}',
                                  style: TextStyle(
                                    color: isCurrentDay || isRestDay
                                        ? Theme.of(context).textTheme.bodyLarge!.color
                                        : Theme.of(context).textTheme.bodyLarge!.color,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                if (isCurrentDay && !isRestDay)
                                  // Button to start the exercise for the current day.
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => ShowUpperBodyExercise(
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
                                      backgroundColor: WidgetStateProperty.all<Color>(
                                        const Color.fromARGB(255, 216, 255, 217),
                                      ),
                                    ),
                                    child: const Text('Start', style: TextStyle(color: Colors.black)),
                                  ),
                                if (isCompleted)
                                  // Display 'Completed' for finished days.
                                  const Padding(
                                    padding: EdgeInsets.only(right: 30),
                                    child: Text('Completed',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 49, 105, 51),
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
                  itemCount: 30, // Total number of days.
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
