import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/user_detail_hive_things/user_model_class.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ValueNotifier to keep track of user details in a list
ValueNotifier<List<UsersData>> userDetailsList = ValueNotifier([]);

// Function to add a new user's details to the Hive database
Future<void> addUserDetails(UsersData value) async {
  // Open the Hive box for user details
  final userDb = await Hive.openBox<UsersData>('user_db');
  
  // Add the user data and retrieve the generated id
  final _id = await userDb.add(value);
  
  // Set the id of the user data
  value.id = _id;
  
  // Add the new user data to the list and notify listeners
  userDetailsList.value.add(value);
  userDetailsList.notifyListeners();
}

// Function to fetch all user details from the Hive database
Future<void> getUserDetails() async {
  // Open the Hive box for user details
  final userDb = await Hive.openBox<UsersData>('user_db');
  
  // Clear the current list and add all user data from the database
  userDetailsList.value.clear();
  userDetailsList.value.addAll(userDb.values);
  
  // Notify listeners of the updated list
  userDetailsList.notifyListeners();
}

// Function to fetch the details of the first user from the Hive database
Future<UsersData> fetchUserDetails() async {
  // Open the Hive box for user details
  final userDb = await Hive.openBox<UsersData>('user_db');
  
  // Retrieve the user data at index 0
  final user = userDb.getAt(0);
  
  // Return the user data, ensuring it is not null
  return user!;
}

// Function to update existing user data in the Hive database
Future<void> updateUserData(UsersData updatedValue) async {
  // Open the Hive box for user details
  final userDb = await Hive.openBox<UsersData>('user_db');
  
  // Update the user data in the database
  await userDb.put(updatedValue.id, updatedValue);
  
  // Find the index of the user data in the list
  int index = userDetailsList.value.indexWhere((user) => user.id == updatedValue.id);
  
  // If the user data is found in the list, update it and notify listeners
  if (index != -1) {
    userDetailsList.value[index] = updatedValue;
    userDetailsList.notifyListeners();
  }
}
