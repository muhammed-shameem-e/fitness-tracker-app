import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/add_new_exercise_hive_things/model_class.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'categories_model_class.dart';

// ValueNotifier to manage the list of categories
ValueNotifier<List<CategoriesModelClass>> categoriesList = ValueNotifier([]);

// Function to add a new category to the Hive database
Future<void> addCategories(CategoriesModelClass value) async {
  final categoriesBox = await Hive.openBox<CategoriesModelClass>('categories_db');
  final _id = await categoriesBox.add(value);
  value.categoriesId = _id;
  categoriesList.value.add(value);
  categoriesList.notifyListeners();
}

// Function to retrieve all categories from the Hive database
Future<void> getCategories() async {
  final categoriesBox = await Hive.openBox<CategoriesModelClass>('categories_db');
  categoriesList.value.clear();
  categoriesList.value.addAll(categoriesBox.values);
  categoriesList.notifyListeners();
}

// Function to add an exercise to a specific category
Future<void> addExerciseToCategory(int categoryId, int exerciseId) async {
  final categoriesBox = await Hive.openBox<CategoriesModelClass>('categories_db');
  final category = categoriesBox.get(categoryId);

  if (category != null) {
    category.exerSizeIds.add(exerciseId);
    await categoriesBox.put(categoryId, category);
    int index = categoriesList.value.indexWhere((element) => element.categoriesId == categoryId);
    if (index != -1) {
      categoriesList.value[index] = category;
      categoriesList.notifyListeners();
    }
  }
}

// Function to update an existing category in the Hive database
Future<void> updateCategories(CategoriesModelClass updateCategory) async {
  var categoriesBox = await Hive.openBox<CategoriesModelClass>('categories_db');
  await categoriesBox.put(updateCategory.categoriesId, updateCategory);
  int index = categoriesList.value.indexWhere((element) => element.categoriesId == updateCategory.categoriesId);
  if (index != -1) {
    categoriesList.value[index] = updateCategory;
    categoriesList.notifyListeners();
  }
}

// Function to delete an exercise from a category
Future<void> deleteExerciseFromCategory(CategoriesModelClass category, AddNewExerciseModelClass exercise) async {
  final categoriesBox = await Hive.openBox<CategoriesModelClass>('categories_db');

  int categoryIndex = categoriesBox.values.toList().indexOf(category);
  if (categoryIndex != -1) {
    category.exerSizeIds.remove(exercise.addAllExerciseId);
    await categoriesBox.putAt(categoryIndex, category);
  }
}

// Function to retrieve all exercises from a specific category
Future<List<AddNewExerciseModelClass>> getCategoryExercise(CategoriesModelClass category) async {
  final exerciseBox = await Hive.openBox<AddNewExerciseModelClass>('exercise_db');
  List<AddNewExerciseModelClass> exercises = [];

  for (var exerciseId in category.exerSizeIds) {
    final exercise = exerciseBox.get(exerciseId);
    if (exercise != null) {
      exercises.add(exercise);
    }
  }

  return exercises;
}

// Function to delete a category by its id
Future<void> deleteCategory(int id) async {
  final categoriesBox = await Hive.openBox<CategoriesModelClass>('categories_db');
  final index = categoriesBox.values.toList().indexWhere((value) => value.categoriesId == id);
  categoriesBox.delete(index);
  await getCategories();
}
