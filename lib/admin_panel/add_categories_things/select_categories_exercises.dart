import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/add_new_exercise_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/add_new_exercise_hive_things/model_class.dart';

class AddIntoCategory extends StatefulWidget {
  const AddIntoCategory({super.key});

  @override
  State<AddIntoCategory> createState() => _AddIntoCategoryState();
}

class _AddIntoCategoryState extends State<AddIntoCategory> {
  List<bool> _isSelected = []; // Tracks selected exercises
  List<int> selectedExercises = []; // List of selected exercise IDs

  @override
  void initState() {
    super.initState();
    getAllExercise(); // Fetch all exercises on initialization
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get current theme

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
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
                      'Select Exercises',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: addAllExerciseList,
                    builder: (BuildContext context,
                        List<AddNewExerciseModelClass> addAllExerciseList,
                        Widget? child) {
                      // Initialize _isSelected if needed
                      if (_isSelected.length != addAllExerciseList.length) {
                        _isSelected = List<bool>.filled(addAllExerciseList.length, false);
                      }

                      return addAllExerciseList.isEmpty
                          ? const Center(child: Text('No exercise found'))
                          : ListView.separated(
                              itemBuilder: (ctx, index) {
                                final showData = addAllExerciseList[index];
                                return ListTile(
                                  minVerticalPadding: 10,
                                  leading: showData.execiseGif.isNotEmpty
                                      ? GestureDetector(
                                          onTap: () => showAboutExercise(context),
                                          child: ClipRRect(
                                            child: Image.file(File(showData.execiseGif)),
                                          ),
                                        )
                                      : null,
                                  title: Text(showData.execiseName),
                                  subtitle: Text(showData.exerciseReps),
                                  trailing: _isSelected[index]
                                      ? Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            color: theme.primaryColor, // Use theme color
                                          ),
                                          child: const Center(
                                              child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 16,
                                          )),
                                        )
                                      : Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: theme.dividerColor, // Use theme color
                                                width: 2),
                                          ),
                                        ),
                                  onTap: () {
                                    setState(() {
                                      _isSelected[index] = !_isSelected[index];
                                      if (_isSelected[index]) {
                                        selectedExercises.add(showData.addAllExerciseId);
                                      } else {
                                        selectedExercises.remove(showData.addAllExerciseId);
                                      }
                                    });
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(color: theme.dividerColor); // Use theme color
                              },
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
                  Navigator.pop(context, selectedExercises); // Return selected exercises to previous screen
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.green), // Use theme color
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  minimumSize: WidgetStateProperty.all<Size>(const Size(200, 50)),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Show details about the exercise in a bottom sheet
  void showAboutExercise(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final theme = Theme.of(context);
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  child: Image.asset('assets/exercisephoto.jfif'),
                ),
              ),
              const Text(
                'ExerciseName',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(theme.primaryColor), // Use theme color
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
