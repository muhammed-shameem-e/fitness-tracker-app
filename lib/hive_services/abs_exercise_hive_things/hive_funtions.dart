import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/abs_exercise_hive_things/abs_exercise_model_class.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ValueNotifier to manage the list of abs exercises
ValueNotifier<List<AbsExerciseModelClass>> absExerciseList = ValueNotifier([]);

// Function to add a new abs exercise to the Hive database
Future<void> addAbsExercise(AbsExerciseModelClass value) async {
  final absExerciseBox = await Hive.openBox<AbsExerciseModelClass>('absexercise_db');
  final _id = await absExerciseBox.add(value);
  value.absId = _id;
  absExerciseList.value.add(value);
  absExerciseList.notifyListeners();
}

// Function to retrieve all abs exercises from the Hive database
Future<void> getAbsExercise() async {
  final absExerciseBox = await Hive.openBox<AbsExerciseModelClass>('absexercise_db');
  absExerciseList.value.clear();
  absExerciseList.value.addAll(absExerciseBox.values);
  absExerciseList.notifyListeners();
}

// Function to delete an abs exercise by its ID
Future<void> deleteAbsExercise(int id) async {
  final absExerciseBox = await Hive.openBox<AbsExerciseModelClass>('absexercise_db');
  final index = absExerciseBox.values.toList().indexWhere((value) => value.absId == id);
  absExerciseBox.deleteAt(index); // Changed to deleteAt to match the index
  await getAbsExercise();
}

// Function to update an existing abs exercise in the Hive database
Future<void> updateAbsExercise(AbsExerciseModelClass updatedValue) async {
  final absExerciseBox = await Hive.openBox<AbsExerciseModelClass>('absexercise_db');
  await absExerciseBox.put(updatedValue.absId, updatedValue);
  int index = absExerciseList.value.indexWhere((exercise) => exercise.absId == updatedValue.absId);
  if (index != -1) {
    absExerciseList.value[index] = updatedValue;
    absExerciseList.notifyListeners();
  }
}
