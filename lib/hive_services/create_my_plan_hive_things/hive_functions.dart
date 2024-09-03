import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/create_my_plan_hive_things/model_class.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ValueNotifier to keep track of user exercises in a list
ValueNotifier<List<CreateUserPlan>> createUserPlanList = ValueNotifier([]);

// Function to add a list of user exercises to the Hive database
Future<void> addUserExercises(List<CreateUserPlan> exercises) async {
  // Open the Hive box for user exercises
  final userExercisesBox = await Hive.openBox<CreateUserPlan>('createuserplan_db');
  
  // Add each exercise to the database and update its id
  for (var exercise in exercises) {
    final id = await userExercisesBox.add(exercise);
    exercise.id = id;
  }
  
  // Refresh the list of user exercises
  await getUserExercises();
}

// Function to fetch all user exercises from the Hive database
Future<void> getUserExercises() async {
  // Open the Hive box for user exercises
  final userExercisesBox = await Hive.openBox<CreateUserPlan>('createuserplan_db');
  
  // Clear the current list and add all exercises from the database
  createUserPlanList.value.clear();
  for (var key in userExercisesBox.keys) {
    final exercise = userExercisesBox.get(key);
    if (exercise != null) {
      exercise.id = key;
      createUserPlanList.value.add(exercise);
    }
  }
  
  // Notify listeners of the updated list
  createUserPlanList.notifyListeners();
}

// Function to delete a user exercise by its id
Future<void> deleteExercise(int id) async {
  // Open the Hive box for user exercises
  final userExerciseBox = await Hive.openBox<CreateUserPlan>('createuserplan_db');
  
  // Delete the exercise with the given id
  await userExerciseBox.delete(id);
  
  // Refresh the list of user exercises
  await getUserExercises();
}
