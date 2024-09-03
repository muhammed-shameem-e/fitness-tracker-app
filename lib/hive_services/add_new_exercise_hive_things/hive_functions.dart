import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/add_new_exercise_hive_things/model_class.dart';
import 'package:fullbody_workout/hive_services/categories_hive_things/categories_model_class.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ValueNotifier to manage the list of all exercises
ValueNotifier<List<AddNewExerciseModelClass>> addAllExerciseList = ValueNotifier([]);

// Function to add a new exercise to the Hive database
Future<void> addAllExercise(AddNewExerciseModelClass value) async {
  final addAllExerciseBox = await Hive.openBox<AddNewExerciseModelClass>('addallexercise_db');
  final _id = await addAllExerciseBox.add(value);
  value.addAllExerciseId = _id;
  addAllExerciseList.value.add(value);
  addAllExerciseList.notifyListeners();
}

// Function to retrieve all exercises from the Hive database
Future<void> getAllExercise() async {
  final addAllExerciseBox = await Hive.openBox<AddNewExerciseModelClass>('addallexercise_db');
  addAllExerciseList.value.clear();
  addAllExerciseList.value.addAll(addAllExerciseBox.values);
  addAllExerciseList.notifyListeners();
}

// Function to delete an exercise by its ID
Future<void> deleteAllExercise(int id) async {
  final addAllExerciseBox = await Hive.openBox<AddNewExerciseModelClass>('addallexercise_db');
  await addAllExerciseBox.delete(id);
  await getAllExercise();
}

// Function to update an existing exercise in the Hive database
Future<void> updateAllExercise(AddNewExerciseModelClass updatedValue) async {
  final addExerciseBox = await Hive.openBox<AddNewExerciseModelClass>('addallexercise_db');
  await addExerciseBox.put(updatedValue.addAllExerciseId, updatedValue);
  int index = addAllExerciseList.value.indexWhere((exercise) => exercise.addAllExerciseId == updatedValue.addAllExerciseId);
  if (index != -1) {
    addAllExerciseList.value[index] = updatedValue;
    addAllExerciseList.notifyListeners();
  }
}

// Function to retrieve exercises related to a specific category
Future<List<AddNewExerciseModelClass>> getExercise(CategoriesModelClass category) async {
  final exerciseBox = await Hive.openBox<AddNewExerciseModelClass>('addallexercise_db');
  final exerciseIds = category.exerSizeIds;
  
  List<AddNewExerciseModelClass> fetchedExercise = [];
  if (exerciseBox.values.isNotEmpty && exerciseIds.isNotEmpty) {
    for (int id in exerciseIds) {
      final exercise = exerciseBox.values.firstWhere((exercise) => exercise.addAllExerciseId == id);
      if (exercise != null) {
        fetchedExercise.add(exercise);
      }
    }
  }
  return fetchedExercise;
}

// Function to delete an exercise from the database
Future<void> deleteCategoryExercises(AddNewExerciseModelClass exercise) async {
  final exerciseBox = await Hive.openBox<AddNewExerciseModelClass>('addallexercise_db');
  await exerciseBox.delete(exercise.addAllExerciseId);
  await getAllExercise();
}
