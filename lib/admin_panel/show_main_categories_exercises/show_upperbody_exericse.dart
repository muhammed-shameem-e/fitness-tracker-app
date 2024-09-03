import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fullbody_workout/admin_panel/add_main_categories_exercises/add_upperbody_exercise.dart';
import 'package:fullbody_workout/admin_panel/edit_main_category_exercises/edit_upperbody_exercise.dart';
import 'package:fullbody_workout/hive_services/upperbody_exercise_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/upperbody_exercise_hive_things/upperbody_exercise_model_class.dart';

class ShowUpperBodyExerciseAdminSide extends StatefulWidget {
  const ShowUpperBodyExerciseAdminSide({super.key});

  @override
  State<ShowUpperBodyExerciseAdminSide> createState() => _ShowUpperBodyExerciseAdminSideState();
}

class _ShowUpperBodyExerciseAdminSideState extends State<ShowUpperBodyExerciseAdminSide> {
  
  @override
  void initState() {
    super.initState();
    getUpperBodyExercises(); // Fetch exercises when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        iconTheme: theme.iconTheme,
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
                      'Edit UpperBody Exercise',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: upperBodyExercisesList,
                    builder: (BuildContext context,
                        List<UpperBodyExercisesModelClass> upperBodyExercisesList,
                        Widget? child) {
                      if (upperBodyExercisesList.isEmpty) {
                        return Center(
                          child: Text(
                            'No exercises available',
                            style: theme.textTheme.bodyLarge,
                          ),
                        );
                      } else {
                        return ListView.separated(
                          itemBuilder: (ctx, index) {
                            final exercise = upperBodyExercisesList[index];
                            return ListTile(
                              minVerticalPadding: 20,
                              leading: GestureDetector(
                                onTap: () => showAboutExercise(
                                    context,
                                    exercise.upperBodyExerciseGif,
                                    exercise.upperBodyExerciseName,
                                    exercise.upperBodyExerciseBenefit),
                                child: exercise.upperBodyExerciseGif.isNotEmpty
                                    ? ClipRRect(
                                        child: Image.file(
                                          File(exercise.upperBodyExerciseGif),
                                          fit: BoxFit.cover,
                                          width: 75,
                                        ),
                                      )
                                    : null,
                              ),
                              title: Text(
                                exercise.upperBodyExerciseName,
                                style: theme.textTheme.bodyLarge,
                              ),
                              subtitle: Text(exercise.upperBodyReps),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Edit button
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditUpperbodyExerciseData(data: exercise),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: theme.colorScheme.secondary,
                                    ),
                                  ),
                                  // Delete button
                                  IconButton(
                                    onPressed: () {
                                      if (exercise.upperBodyId != null) {
                                        alertDeleteButton(exercise.upperBodyId!);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: theme.colorScheme.error,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: theme.dividerColor,
                            );
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
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddUpperBodyExercise()));
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
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
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
                  child: Image.file(
                    File(gif),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w500),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(300, 50),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to show confirmation dialog before deleting an exercise
  void alertDeleteButton(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Are you sure you want to delete this exercise?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'NO',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            TextButton(
              onPressed: () {
                deleteUpperBodyExercise(id); // Call to delete exercise
                Navigator.of(context).pop();
              },
              child: const Text(
                'YES',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
