import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/admin_panel/new_exercise_things/add_new_exercises.dart';
import 'package:fullbody_workout/admin_panel/new_exercise_things/edit_new_exercises.dart';
import 'package:fullbody_workout/hive_services/add_new_exercise_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/add_new_exercise_hive_things/model_class.dart';

class ShowNewExercises extends StatefulWidget {
  const ShowNewExercises({super.key});

  @override
  State<ShowNewExercises> createState() => _ShowNewExercisesState();
}

class _ShowNewExercisesState extends State<ShowNewExercises> {

  @override
  void initState() {
    super.initState();
    getAllExercise(); // Fetch all exercises when the widget is initialized
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
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'All Exercise is here',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: addAllExerciseList,
                    builder: (BuildContext context, List<AddNewExerciseModelClass> addAllExerciseList, Widget? child) {
                      // Check if the list is empty
                      return addAllExerciseList.isEmpty
                          ? const Center(child: Text('No exercises found'))
                          : ListView.separated(
                              itemBuilder: (ctx, index) {
                                final exercise = addAllExerciseList[index];
                                return ListTile(
                                  minTileHeight: 100,
                                  leading: GestureDetector(
                                    onTap: () => showAboutExercise(context, exercise.execiseGif, exercise.execiseName),
                                    child: exercise.execiseGif.isNotEmpty
                                        ? ClipRRect(
                                            child: Image.file(
                                              File(exercise.execiseGif),
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : null,
                                  ),
                                  title: Text(exercise.execiseName),
                                  subtitle: Text(exercise.exerciseReps),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Edit button
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => EditAllExerciseData(data: exercise),
                                          ));
                                        },
                                        icon: const Icon(Icons.edit, color: Colors.blue),
                                      ),
                                      // Delete button
                                      IconButton(
                                        onPressed: () {
                                          alertDeleteButton(context, exercise.addAllExerciseId);
                                        },
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => const Divider(),
                              itemCount: addAllExerciseList.length,
                            );
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddExercisePage()));
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

  // Function to show confirmation dialog before deleting an exercise
  void alertDeleteButton(BuildContext context, int id) {
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
              child: const Text('NO', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                deleteAllExercise(id); // Call to delete exercise
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
