import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/add_new_exercise_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/add_new_exercise_hive_things/model_class.dart';

class AddExercisePage extends StatefulWidget {
  const AddExercisePage({super.key});

  @override
  State<AddExercisePage> createState() => _AddExercisePageState();
}

class _AddExercisePageState extends State<AddExercisePage> {
  File? _selectedGif; // Holds the selected GIF file
  TextEditingController exerciseNameController = TextEditingController(); // Controller for exercise name input
  TextEditingController exerciseRepsController = TextEditingController(); // Controller for exercise reps input
  TextEditingController exerciseBenefitController = TextEditingController(); // Controller for exercise benefit input
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); // Key for form validation
  ValueNotifier<File?> gifNotifier = ValueNotifier<File?>(null); // Notifier for updating GIF display

  // Function to check if the first letter of the input is capitalized
  bool isFirstLetterCapital(String value) {
    return value.isNotEmpty && value[0] == value[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Exercise'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // GestureDetector to pick a GIF file
                GestureDetector(
                  onTap: () => pickGif().then((value) {
                    if (_selectedGif != null) {
                      gifNotifier.value = _selectedGif;
                    }
                  }),
                  child: ValueListenableBuilder<File?>(
                    valueListenable: gifNotifier,
                    builder: (context, value, child) {
                      return value != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                value,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[300],
                              ),
                              child: const Center(
                                child: Icon(Icons.gif),
                              ),
                            );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // TextFormField for exercise name
                TextFormField(
                  controller: exerciseNameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter exercise name';
                    }
                    if (!isFirstLetterCapital(value)) {
                      return 'Exercise name should start with a capital letter';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // TextFormField for exercise reps
                TextFormField(
                  controller: exerciseRepsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Reps',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter exercise Reps';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // TextFormField for exercise benefit
                TextFormField(
                  controller: exerciseBenefitController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Benefit',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter exercise benefit';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // ElevatedButton to add the exercise
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (gifNotifier.value != null &&
                          exerciseNameController.text.isNotEmpty) {
                        // Create a new exercise object
                        final newExercise = AddNewExerciseModelClass(
                          execiseGif: gifNotifier.value!.path,
                          execiseName: exerciseNameController.text,
                          addAllExerciseId: DateTime.now().millisecond,
                          exerciseBenefit: exerciseBenefitController.text,
                          exerciseReps: exerciseRepsController.text,
                        );
                        // Add the new exercise to Hive
                        await addAllExercise(newExercise);
                        exerciseNameController.clear();
                        gifNotifier.value = null;
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Add Exercise',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to pick a GIF file
  Future<void> pickGif() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['gif'],
    );
    if (result != null) {
      setState(() {
        _selectedGif = File(result.files.single.path!);
        gifNotifier.value = _selectedGif;
      });
    }
  }
}
