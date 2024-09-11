import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/admin_panel/add_categories_things/select_categories_exercises.dart';
import 'package:fullbody_workout/hive_services/add_new_exercise_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/add_new_exercise_hive_things/model_class.dart';
import 'package:fullbody_workout/hive_services/categories_hive_things/categories_model_class.dart';
import 'package:fullbody_workout/hive_services/categories_hive_things/hive_functions.dart';

class ShowCategoriesExerciseAdminSide extends StatefulWidget {
  final CategoriesModelClass category;

  const ShowCategoriesExerciseAdminSide({super.key, required this.category});

  @override
  State<ShowCategoriesExerciseAdminSide> createState() => _ShowCategoriesExerciseAdminSideState();
}

class _ShowCategoriesExerciseAdminSideState extends State<ShowCategoriesExerciseAdminSide> {
  List<AddNewExerciseModelClass>? allCategoryExercise;

  @override
  void initState() {
    super.initState();
    _fetchAllCategoryExercise();
  }

  // Fetch all exercises for the current category
  Future<void> _fetchAllCategoryExercise() async {
    List<AddNewExerciseModelClass> exercise = await getExercise(widget.category);
    setState(() {
      allCategoryExercise = exercise;
    });
  }

  // Add exercises to the current category
  Future<void> _addExercisesToCategory() async {
    final selectedExercises = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddIntoCategory()),
    );

    if (selectedExercises != null && selectedExercises is List<int>) {
      for (var exerciseId in selectedExercises) {
        widget.category.exerSizeIds.add(exerciseId);
      }
      await getCategoryExercise(widget.category); // Update the category in the Hive database
      _fetchAllCategoryExercise(); // Refresh the list of exercises
    }
  }

  // Show a dialog to confirm exercise deletion
  Future<void> alertRestart(AddNewExerciseModelClass exercise) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm deletion'),
          content: const Text('Are you sure you want to delete this exercise?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('NO', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () async {
                deleteExerciseFromCategory(widget.category, exercise);
                setState(() {
                  _fetchAllCategoryExercise(); // Refresh the list after deletion
                });
                Navigator.of(context).pop();
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.category.categoriesName} Exercises',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: allCategoryExercise == null
                      ? const Center(child: CircularProgressIndicator())
                      : allCategoryExercise!.isEmpty
                          ? const Center(child: Text('No exercises found'))
                          : ListView.separated(
                              itemBuilder: (ctx, index) {
                                final exercise = allCategoryExercise![index];
                                return ListTile(
                                  minVerticalPadding: 20,
                                  leading: GestureDetector(
                                    onTap: () {
                                      showAboutExercise(context, exercise.execiseGif, exercise.execiseName,exercise.exerciseBenefit);
                                    },
                                    child: exercise.execiseGif.isNotEmpty
                                        ? ClipRRect(child: Image.file(File(exercise.execiseGif)))
                                        : null,
                                  ),
                                  title: Text(exercise.execiseName),
                                  trailing: IconButton(
                                    onPressed: () {
                                      alertRestart(exercise);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                  subtitle: Text(exercise.exerciseReps),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemCount: allCategoryExercise!.length,
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
                onPressed: () async {
                  _addExercisesToCategory();
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                  minimumSize: WidgetStateProperty.all<Size>(const Size(200, 50)),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                child: const Text(
                  'Add more exercises',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Show details about the exercise in a bottom sheet
  void showAboutExercise(BuildContext context, String gif, String name,String benefit) {
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
