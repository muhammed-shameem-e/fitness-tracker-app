import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/add_new_exercise_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/add_new_exercise_hive_things/model_class.dart';
import 'package:fullbody_workout/hive_services/create_my_plan_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/create_my_plan_hive_things/model_class.dart';

class AddIntoUserExercises extends StatefulWidget {
  const AddIntoUserExercises({super.key});

  @override
  State<AddIntoUserExercises> createState() => _AddIntoUserExercisesState();
}

class _AddIntoUserExercisesState extends State<AddIntoUserExercises> {
  // List to keep track of selected exercises
  List<bool> _isUserSelected = [];
  // List to hold exercises selected by the user
  List<CreateUserPlan> selectedUserExercises = [];

  @override
  void initState() {
    super.initState();
    getAllExercise();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
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
                      // Initialize _isUserSelected list if lengths do not match
                      if (_isUserSelected.length != addAllExerciseList.length) {
                        _isUserSelected = List<bool>.filled(addAllExerciseList.length, false);
                      }
                      return addAllExerciseList.isEmpty
                          ? const Center(child: Text("No exercises available,First, you need to add exercises from the admin side. To do this, go to the settings page where you'll find an option to access the admin side. There, you can add exercises, and once you're done, the exercises will appear here for you to perform.",
                            textAlign: TextAlign.center,
                            ))
                          : ListView.separated(
                              itemBuilder: (ctx, index) {
                                final showData = addAllExerciseList[index];
                                return ListTile(
                                  minVerticalPadding: 10,
                                  leading: showData.execiseGif.isNotEmpty
                                      ? GestureDetector(
                                          onTap: () => showAboutExercise(context,showData.execiseGif,showData.execiseName,showData.exerciseBenefit),
                                          child: ClipRRect(
                                            child: Image.file(File(showData.execiseGif)),
                                          ),
                                        )
                                      : null,
                                  title: Text(
                                    showData.execiseName,
                                    style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color,),
                                  ),
                                  subtitle: Text(showData.exerciseReps),
                                  trailing: _isUserSelected[index]
                                      ? Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(5),
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
                                              color: theme.dividerColor,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                        ),
                                  onTap: () {
                                    setState(() {
                                      // Toggle selection state and update selected exercises list
                                      _isUserSelected[index] = !_isUserSelected[index];
                                      if (_isUserSelected[index]) {
                                        selectedUserExercises.add(CreateUserPlan(
                                            exerciseBenefit: showData.exerciseBenefit,
                                            exerciseName: showData.execiseName,
                                            exerciseReps: showData.exerciseReps,
                                            exerciseGif: showData.execiseGif));
                                      } else {
                                        selectedUserExercises.removeWhere(
                                            (exercise) => exercise.exerciseName == showData.execiseName);
                                      }
                                    });
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
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
                onPressed: () async {
                  // Save selected exercises and pop the current screen
                  await addUserExercises(selectedUserExercises);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(200, 50),
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

  void showAboutExercise(BuildContext context,String name,String gif,String benefit) {
    final theme = Theme.of(context);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: theme.scaffoldBackgroundColor,
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
                  style: TextStyle(fontWeight: FontWeight.w500,color: Theme.of(context).textTheme.bodyLarge!.color,),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  benefit,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color,)
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
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
