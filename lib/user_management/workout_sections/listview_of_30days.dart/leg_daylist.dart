import 'package:flutter/material.dart';
import 'package:fullbody_workout/user_management/workout_sections/leg_things/show_leg_exercise.dart';
import 'package:fullbody_workout/user_management/workout_sections/rest_day_page.dart';

class LegDaysList extends StatelessWidget {
  final int lastCompletedDay;
  final Function(int) updateLastCompletedDay;
  final bool isDarkMode;

  const LegDaysList({
    Key? key,
    required this.lastCompletedDay,
    required this.updateLastCompletedDay,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (ctx, index) {
          bool isRestDay = (index + 1) % 7 == 0;
          bool isCompleted = index < lastCompletedDay;
          bool isCurrentDay = index == lastCompletedDay;

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
                        await updateLastCompletedDay(index + 1);
                      },
                    ),
                  ),
                );
              } else if (isCurrentDay) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ShowLegExercise(
                      onComplete: () async {
                        await updateLastCompletedDay(index + 1);
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
                                    await updateLastCompletedDay(index + 1);
                                  },
                                  completedDay: index + 1,
                                ),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 216, 255, 217),
                            ),
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
    );
  }
}
