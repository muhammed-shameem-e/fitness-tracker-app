import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fullbody_workout/admin_panel/add_main_categories_exercises/add_leg_exercise.dart';
import 'package:fullbody_workout/admin_panel/edit_main_category_exercises/edit_leg_exercise.dart';
import 'package:fullbody_workout/hive_services/leg_exercise_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/leg_exercise_hive_things/leg_exercise_model_class.dart';

class ShowLegExerciseAdminSide extends StatefulWidget {
  const ShowLegExerciseAdminSide({super.key});

  @override
  State<ShowLegExerciseAdminSide> createState() => _ShowLegExerciseAdminSideState();
}

class _ShowLegExerciseAdminSideState extends State<ShowLegExerciseAdminSide> {
  @override
  void initState() {
    super.initState();
    getLegExercises(); // Fetch leg exercises when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Edit Leg Exercise',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: legExerciseList,
                    builder: (BuildContext context, List<LegExerciseModelClass> legExercisesList, Widget? child) {
                      if (legExercisesList.isEmpty) {
                        return const Center(child: Text('No exercises available'));
                      } else {
                        return ListView.separated(
                          itemBuilder: (ctx, index) {
                            final exercise = legExercisesList[index];
                            return ListTile(
                              minTileHeight: 100,
                              leading: GestureDetector(
                                onTap: () => showAboutExercise(context, exercise.legExerciseGif,
                                    exercise.legExerciseName, exercise.legExerciseBenefit),
                                child: exercise.legExerciseGif.isNotEmpty
                                    ? ClipRRect(
                                        child: Image.file(
                                          File(exercise.legExerciseGif),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : null,
                              ),
                              title: Text(exercise.legExerciseName),
                              subtitle: Text(exercise.legreps),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Edit button
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => EditLegExerciseData(data: exercise),
                                      ));
                                    },
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                  ),
                                  // Delete button
                                  IconButton(
                                    onPressed: () {
                                      alertDeleteButton(context, exercise.legId!);
                                    },
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: legExercisesList.length,
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddLegExercise()));
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
                  'Add',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to show exercise details in a bottom sheet
  void showAboutExercise(BuildContext context, String gif, String name, String explain) {
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
              Text(
                explain,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Theme.of(context).primaryColor),
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

  // Function to show confirmation dialog before deleting an exercise
  void alertDeleteButton(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          content: const Text('Are you sure you want to delete this exercise?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('NO', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                deleteLegExercise(id); // Call to delete exercise
                Navigator.of(context).pop();
              },
              child: const Text('YES', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
