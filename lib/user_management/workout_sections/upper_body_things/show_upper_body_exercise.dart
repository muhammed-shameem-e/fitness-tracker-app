import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/upperbody_exercise_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/upperbody_exercise_hive_things/upperbody_exercise_model_class.dart';
import 'package:fullbody_workout/user_management/workout_sections/upper_body_things/upper_body_exercise_one.dart';

class ShowUpperBodyExercise extends StatefulWidget {
  final VoidCallback onComplete;
  final int completedDay;
  
  // Constructor to initialize with required parameters
  const ShowUpperBodyExercise({
    super.key, 
    required this.onComplete, 
    required this.completedDay
  });

  @override
  State<ShowUpperBodyExercise> createState() => _ShowUpperBodyExerciseState();
}

class _ShowUpperBodyExerciseState extends State<ShowUpperBodyExercise> {

  @override
  void initState() {
    super.initState();
    // Fetch upper body exercises when the widget is initialized
    getUpperBodyExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                // Header Row displaying title and day
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'UpperBody exercises',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Day 1',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: upperBodyExercisesList,
                    builder: (BuildContext context, List<UpperBodyExercisesModelClass> upperBodyExercisesList, Widget? child) {
                      if (upperBodyExercisesList.isEmpty) {
                        // Display message if no exercises are available
                        return const Center(child: Text('No exercises available'));
                      } else {
                        // Display list of exercises with GIFs and details
                        return ListView.separated(
                          itemBuilder: (ctx, index) {
                            final exercise = upperBodyExercisesList[index];
                            return ListTile(
                              leading: exercise.upperBodyExerciseGif.isNotEmpty
                                  ? GestureDetector(
                                      onTap: () => showAboutExercise(context, exercise.upperBodyExerciseGif, exercise.upperBodyExerciseName),
                                      child: ClipRRect(
                                        child: Image.file(File(exercise.upperBodyExerciseGif), height: 150, width: 75, fit: BoxFit.cover),
                                      ),
                                    )
                                  : null,
                              title: Text(exercise.upperBodyExerciseName),
                              subtitle: Text(exercise.upperBodyReps),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: upperBodyExercisesList.length,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          // Start button at the bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  if (upperBodyExercisesList.value.isNotEmpty) {
                    widget.onComplete(); 
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UpperBodyExerciseOne(
                          exercise: upperBodyExercisesList.value[0],
                          index: 0,
                          completedDay: widget.completedDay,
                        ),
                      ),
                    );
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
                child: const Text(
                  'Start',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Show a bottom sheet with exercise details
  void showAboutExercise(BuildContext context, String gif, String name) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
                'When it comes to health, regular\nexercise is about as close to a\nmagic potion as you can get.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
