// upper_body_days_list.dart
import 'package:flutter/material.dart';
import 'package:fullbody_workout/user_management/workout_sections/rest_day_page.dart';
import 'package:fullbody_workout/user_management/workout_sections/upper_body_things/show_upper_body_exercise.dart';

class UpperBodyDaysList extends StatefulWidget {
  final int lastCompletedDay;
  final Function(int day) updateLastCompletedDay;

  const UpperBodyDaysList({
    Key? key,
    required this.lastCompletedDay,
    required this.updateLastCompletedDay,
  }) : super(key: key);

  @override
  _UpperBodyDaysListState createState() => _UpperBodyDaysListState();
}

class _UpperBodyDaysListState extends State<UpperBodyDaysList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (ctx, index) {
          bool isRestDay = (index + 1) % 7 == 0;
          bool isCompleted = index < widget.lastCompletedDay;
          bool isCurrentDay = index == widget.lastCompletedDay;

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
                        await widget.updateLastCompletedDay(index + 1);
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
                        await widget.updateLastCompletedDay(index + 1);
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
                                    await widget.updateLastCompletedDay(index + 1);
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
                          child: Text(
                            'Completed',
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
    );
  }
}
