import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/leg_exercise_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/leg_exercise_hive_things/leg_exercise_model_class.dart';
import 'package:fullbody_workout/user_management/workout_sections/leg_things/leg_exerice_one.dart';

class ShowLegExercise extends StatefulWidget {
  const ShowLegExercise({super.key, required this.onComplete, required this.completedDay});
  final VoidCallback onComplete; // Callback function to notify when exercise is completed
  final int completedDay; // Indicates which day of the exercise is being shown

  @override
  State<ShowLegExercise> createState() => _ShowLegExerciseState();
}

class _ShowLegExerciseState extends State<ShowLegExercise> {

  @override
  void initState() {
    super.initState();
    getLegExercises(); // Load the list of leg exercises when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Set the background color based on the theme
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Set the app bar background color based on the theme
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                // Header row showing the title and the day of the exercise
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Leg exercises', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                    Text('Day 1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 20), // Space between the header and the list
                // List of exercises
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: legExerciseList, // Listen to changes in the list of exercises
                    builder: (BuildContext context, List<LegExerciseModelClass> legExerciseList, Widget? child) {
                      if (legExerciseList.isEmpty) {
                        return const Center(child: Text('No exercises available')); // Show message if no exercises are available
                      } else {
                        return ListView.separated(
                          itemBuilder: (ctx, index) {
                            final exercise = legExerciseList[index];
                            return ListTile(
                              minVerticalPadding: 15, // Adjust the padding
                              leading: GestureDetector(
                                onTap: () => showAboutExercise(context, exercise.legExerciseGif, exercise.legExerciseName), // Show exercise details when tapped
                                child: exercise.legExerciseGif.isNotEmpty
                                    ? ClipRRect(
                                        child: Image.file(File(exercise.legExerciseGif)), // Display the exercise image
                                      )
                                    : null,
                              ),
                              title: Text(exercise.legExerciseName), // Display the exercise name
                              subtitle: Text(exercise.legreps), // Display the exercise repetitions
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(), // Add a divider between the list items
                          itemCount: legExerciseList.length, // Set the number of exercises in the list
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          // Start button at the bottom of the screen
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  widget.onComplete(); // Notify that the exercise is completed
                  if (legExerciseList.value.isNotEmpty) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LegExerciseOne(
                          exercise: legExerciseList.value.first, // Start the first exercise
                          index: 0, // Index of the exercise in the list
                          completedDay: widget.completedDay, // Pass the completed day
                        ),
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set button background color
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Round the corners of the button
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(const Size(200, 50)), // Set the button size
                ),
                child: const Text('Start', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)), // Set the button text
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to show details about the selected exercise in a bottom sheet
  void showAboutExercise(BuildContext context, String gif, String name) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the bottom sheet to be scrollable
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the exercise gif
              Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  child: Image.file(File(gif)),
                ),
              ),
              // Display the exercise name
              Text(
                name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Display a motivational quote
              const Text(
                'When it comes to health, regular\nexercise is about as close to a\nmagic potion as you can get.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Close button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the bottom sheet when pressed
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.green), // Set button background color
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Round the corners of the button
                    ),
                  ),
                  minimumSize: WidgetStateProperty.all<Size>(const Size(300, 50)), // Set the button size
                ),
                child: const Text('Close', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)), // Set the button text
              ),
            ],
          ),
        );
      },
    );
  }
}
