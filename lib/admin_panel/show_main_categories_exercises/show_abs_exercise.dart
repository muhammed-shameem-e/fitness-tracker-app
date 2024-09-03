import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/admin_panel/add_main_categories_exercises/add_abs_exercise.dart';
import 'package:fullbody_workout/admin_panel/edit_main_category_exercises/edit_abs_exercise.dart';
import 'package:fullbody_workout/hive_services/abs_exercise_hive_things/abs_exercise_model_class.dart';
import 'package:fullbody_workout/hive_services/abs_exercise_hive_things/hive_funtions.dart';

class ShowAbsExerciseAdminSide extends StatefulWidget {
  const ShowAbsExerciseAdminSide({super.key});

  @override
  State<ShowAbsExerciseAdminSide> createState() => _ShowAbsExerciseAdminSideState();
}

class _ShowAbsExerciseAdminSideState extends State<ShowAbsExerciseAdminSide> {

  @override
  void initState() {
    super.initState();
    getAbsExercise(); // Fetch abs exercises when the widget is initialized
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
                      'Edit Abs Exercise',
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
                    valueListenable: absExerciseList,
                    builder: (BuildContext context, List<AbsExerciseModelClass> absExercisesList, Widget? child) {
                      if (absExercisesList.isEmpty) {
                        return const Center(child: Text('No exercises available'));
                      } else {
                        return ListView.separated(
                          itemBuilder: (ctx, index) {
                            final exercise = absExercisesList[index];
                            return ListTile(
                              minTileHeight: 100,
                              leading: GestureDetector(
                                onTap: () => showAboutExercise(context, exercise.absExerciseGif,
                                    exercise.absExerciseName, exercise.absExerciseBenefit),
                                child: exercise.absExerciseGif.isNotEmpty
                                    ? ClipRRect(
                                        child: Image.file(
                                          File(exercise.absExerciseGif),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : null,
                              ),
                              title: Text(exercise.absExerciseName),
                              subtitle: Text(exercise.absreps),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Edit button
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => EditAbsExerciseData(data: exercise),
                                      ));
                                    },
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                  ),
                                  // Delete button
                                  IconButton(
                                    onPressed: () {
                                      if (exercise.absId != null) {
                                        alertDeleteButton(context, exercise.absId!);
                                      }
                                    },
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: absExercisesList.length,
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddAbsExercise()));
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
  void showAboutExercise(BuildContext context, String gif, String name, String benefit) {
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
                benefit,
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
                deleteAbsExercise(id); // Call to delete exercise
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
