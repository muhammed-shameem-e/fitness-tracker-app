import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/upperbody_exercise_hive_things/upperbody_exercise_model_class.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ValueNotifier to keep track of upper body exercises in a list
ValueNotifier<List<UpperBodyExercisesModelClass>> upperBodyExercisesList = ValueNotifier([]);

// Function to add a new upper body exercise to the Hive database
Future<void> addUpperBodyExercises(UpperBodyExercisesModelClass value) async {
  // Open the Hive box for upper body exercises
  final upperBodyExerciseBox = await Hive.openBox<UpperBodyExercisesModelClass>('upperbodyexercise_db');
  
  // Add the exercise and retrieve the generated id
  final id = await upperBodyExerciseBox.add(value);
  
  // Set the id of the exercise
  value.upperBodyId = id;
  
  // Add the new exercise to the list and notify listeners
  upperBodyExercisesList.value.add(value);
  upperBodyExercisesList.notifyListeners();
}

// Function to fetch all upper body exercises from the Hive database
Future<void> getUpperBodyExercises() async {
  // Open the Hive box for upper body exercises
  final upperBodyExerciseBox = await Hive.openBox<UpperBodyExercisesModelClass>('upperbodyexercise_db');
  
  // Clear the current list and add all exercises from the database
  upperBodyExercisesList.value.clear();
  upperBodyExercisesList.value.addAll(upperBodyExerciseBox.values);
  
  // Notify listeners of the updated list
  upperBodyExercisesList.notifyListeners();
}

// Function to delete an upper body exercise by its id
Future<void> deleteUpperBodyExercise(int id) async {
  // Open the Hive box for upper body exercises
  final upperBodyExerciseBox = await Hive.openBox<UpperBodyExercisesModelClass>('upperbodyexercise_db');
  
  // Find the index of the exercise with the given id
  final index = upperBodyExerciseBox.values.toList().indexWhere((value) => value.upperBodyId == id);
  
  // Delete the exercise at the found index
  upperBodyExerciseBox.deleteAt(index);
  
  // Refresh the list of exercises
  await getUpperBodyExercises();
}

// Function to update an existing upper body exercise in the Hive database
Future<void> updateUpperBodyExercise(UpperBodyExercisesModelClass updatedValue) async {
  // Open the Hive box for upper body exercises
  final upperBodyExerciseBox = await Hive.openBox<UpperBodyExercisesModelClass>('upperbodyexercise_db');
  
  // Update the exercise in the database
  await upperBodyExerciseBox.put(updatedValue.upperBodyId, updatedValue);
  
  // Find the index of the exercise in the list
  int index = upperBodyExercisesList.value.indexWhere((exercise) => exercise.upperBodyId == updatedValue.upperBodyId);
  
  // If the exercise is found, update it and notify listeners
  if (index != -1) {
    upperBodyExercisesList.value[index] = updatedValue;
    upperBodyExercisesList.notifyListeners();
  }
}
