import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/add_new_exercise_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/add_new_exercise_hive_things/model_class.dart';
import 'package:fullbody_workout/hive_services/categories_hive_things/categories_model_class.dart';
import 'package:fullbody_workout/user_management/workout_sections/new_category_things/show_one_exercise.dart';

class ShowCategoriesExerciseUserSide extends StatefulWidget {
  final CategoriesModelClass category;
  final VoidCallback onComplete;
  final int completedDay;

  const ShowCategoriesExerciseUserSide({
    super.key,
    required this.category,
    required this.onComplete,
    required this.completedDay,
  });

  @override
  State<ShowCategoriesExerciseUserSide> createState() => _ShowCategoriesExerciseUserSideState();
}

class _ShowCategoriesExerciseUserSideState extends State<ShowCategoriesExerciseUserSide> {
  List<AddNewExerciseModelClass>? allCategoryExercise;

  @override
  void initState() {
    super.initState();
    _fetchAllCategoryExercise();
  }

  // Fetch all exercises related to the selected category
  Future<void> _fetchAllCategoryExercise() async {
    List<AddNewExerciseModelClass> exercise = await getExercise(widget.category);
    setState(() {
      allCategoryExercise = exercise;
    });
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
                // Display the category name
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
                // Display exercises or a loading indicator
                Expanded(
                  child: allCategoryExercise == null
                      ? const Center(child: CircularProgressIndicator())
                      : allCategoryExercise!.isEmpty
                          ? const Center(child: Text("No exercises available,First, you need to add exercises from the admin side. To do this, go to the settings page where you'll find an option to access the admin side. There, you can add exercises, and once you're done, the exercises will appear here for you to perform.",
                          textAlign: TextAlign.center,
                          ))
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
                                        ? ClipRRect(
                                            child: Image.file(File(exercise.execiseGif)),
                                          )
                                        : null,
                                  ),
                                  title: Text(exercise.execiseName),
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
          // Start button at the bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  widget.onComplete();
                  if (allCategoryExercise != null && allCategoryExercise!.isNotEmpty) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NewCategoryExerciseOne(
                          exercise: allCategoryExercise![0],
                          index: 0,
                          allExercises: allCategoryExercise!,
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

  // Show a modal bottom sheet with exercise details
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
