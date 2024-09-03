import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/abs_exercise_hive_things/abs_exercise_model_class.dart';
import 'package:fullbody_workout/hive_services/abs_exercise_hive_things/hive_funtions.dart';
import 'package:fullbody_workout/user_management/workout_sections/abs_things/abs_exercise_one.dart';

class ShowAbsExercise extends StatefulWidget {
  const ShowAbsExercise({
    super.key,
    required this.onComplete,
    required this.completedDay,
  });

  // Callback when the workout is completed
  final VoidCallback onComplete;
  // Day number for tracking progress
  final int completedDay;

  @override
  State<ShowAbsExercise> createState() => _ShowAbsExerciseState();
}

class _ShowAbsExerciseState extends State<ShowAbsExercise> {
  @override
  void initState() {
    super.initState();
    // Retrieve abs exercises from the Hive database
    getAbsExercise();
  }

  @override
  Widget build(BuildContext context) {
    // Access the current theme
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color ?? Colors.black;
    final backgroundColor = theme.scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        iconTheme: theme.iconTheme,
        title: const Text(
          'Abs exercises',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // Header row showing the title and current day
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Abs exercises',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: textColor),
                    ),
                    Text(
                      'Day 1',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: textColor),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: absExerciseList,
                    builder: (BuildContext context, List<AbsExerciseModelClass> absExerciseList, Widget? child) {
                      // Display a message if no exercises are available
                      if (absExerciseList.isEmpty) {
                        return Center(
                          child: Text(
                            'No exercises available',
                            style: TextStyle(color: textColor),
                          ),
                        );
                      } else {
                        // Display a list of exercises
                        return ListView.separated(
                          itemBuilder: (ctx, index) {
                            final exercise = absExerciseList[index];
                            return ListTile(
                              minVerticalPadding: 10,
                              leading: GestureDetector(
                                onTap: () => showAboutExercise(context, exercise.absExerciseGif, exercise.absExerciseName),
                                child: exercise.absExerciseGif.isNotEmpty
                                    ? ClipRRect(
                                        child: Image.file(File(exercise.absExerciseGif)),
                                      )
                                    : null,
                              ),
                              title: Text(exercise.absExerciseName, style: TextStyle(color: textColor)),
                              subtitle: Text(exercise.absreps, style: TextStyle(color: textColor.withOpacity(0.6))),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(color: textColor.withOpacity(0.2));
                          },
                          itemCount: absExerciseList.length,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  // Trigger the onComplete callback and navigate to the next screen if exercises are available
                  widget.onComplete();
                  if (absExerciseList.value.isNotEmpty) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AbsExerciseOne(
                        exercise: absExerciseList.value[0],
                        index: 0,
                        completedDay: widget.completedDay,
                      ),
                    ));
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  minimumSize: WidgetStateProperty.all<Size>(const Size(200, 50)),
                ),
                child: const Text('Start', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Show information about the selected exercise in a bottom sheet
  void showAboutExercise(BuildContext context, String gif, String name) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  child: Image.file(File(gif)),
                ),
              ),
              Text(
                name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'When it comes to health, regular exercise is about as close to a magic potion as you can get.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  minimumSize: WidgetStateProperty.all<Size>(const Size(300, 50)),
                ),
                child: const Text('Close', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        );
      },
    );
  }
}
