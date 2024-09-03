import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/leg_exercise_hive_things/leg_exercise_model_class.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ValueNotifier to keep track of leg exercises in a list
ValueNotifier<List<LegExerciseModelClass>> legExerciseList = ValueNotifier([]);

// Function to add a new leg exercise to the Hive database
Future<void> addLegExercises(LegExerciseModelClass value) async {
  // Open the Hive box for leg exercises
  final legExerciseBox = await Hive.openBox<LegExerciseModelClass>('legexercise_db');
  
  // Add the exercise and retrieve the generated id
  final _id = await legExerciseBox.add(value);
  
  // Set the id of the exercise
  value.legId = _id;
  
  // Add the new exercise to the list and notify listeners
  legExerciseList.value.add(value);
  legExerciseList.notifyListeners();
}

// Function to fetch all leg exercises from the Hive database
Future<void> getLegExercises() async {
  // Open the Hive box for leg exercises
  final legExerciseBox = await Hive.openBox<LegExerciseModelClass>('legexercise_db');
  
  // Clear the current list and add all exercises from the database
  legExerciseList.value.clear();
  legExerciseList.value.addAll(legExerciseBox.values);
  
  // Notify listeners of the updated list
  legExerciseList.notifyListeners();
}

// Function to delete a leg exercise by its id
Future<void> deleteLegExercise(int id) async {
  // Open the Hive box for leg exercises
  final legExerciseBox = await Hive.openBox<LegExerciseModelClass>('legexercise_db');
  
  // Find the index of the exercise with the given id
  final index = legExerciseBox.values.toList().indexWhere((value) => value.legId == id);
  
  // Delete the exercise at the found index
  legExerciseBox.deleteAt(index);
  
  // Refresh the list of exercises
  await getLegExercises();
}

// Function to update an existing leg exercise in the Hive database
Future<void> updateLegExercise(LegExerciseModelClass updatedValue) async {
  // Open the Hive box for leg exercises
  final legExerciseBox = await Hive.openBox<LegExerciseModelClass>('legexercise_db');
  
  // Update the exercise in the database
  await legExerciseBox.put(updatedValue.legId, updatedValue);
  
  // Find the index of the exercise in the list
  int index = legExerciseList.value.indexWhere((exercise) => exercise.legId == updatedValue.legId);
  
  // If the exercise is found, update it and notify listeners
  if (index != -1) {
    legExerciseList.value[index] = updatedValue;
    legExerciseList.notifyListeners();
  }
}
