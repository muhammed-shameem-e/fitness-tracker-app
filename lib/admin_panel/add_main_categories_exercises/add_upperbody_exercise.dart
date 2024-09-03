import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/upperbody_exercise_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/upperbody_exercise_hive_things/upperbody_exercise_model_class.dart';

class AddUpperBodyExercise extends StatefulWidget {
  const AddUpperBodyExercise({super.key});

  @override
  State<AddUpperBodyExercise> createState() => _AddUpperBodyExerciseState();
}

class _AddUpperBodyExerciseState extends State<AddUpperBodyExercise> {
  File? _selectUpperBodyGif;
  TextEditingController upperBodyExerciseNameController = TextEditingController();
  TextEditingController upperBodyRepsController = TextEditingController();
  TextEditingController upperBodyExerciseBenefitController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ValueNotifier<File?> gifNotifier = ValueNotifier<File?>(null);

  // Check if the first letter of the string is capitalized
  bool isFirstLetterCapital(String value) {
    return value.isNotEmpty && value[0] == value[0].toUpperCase();
  }

  @override
  void dispose() {
    // Dispose controllers and value notifiers to free resources
    upperBodyExerciseNameController.dispose();
    upperBodyRepsController.dispose();
    upperBodyExerciseBenefitController.dispose();
    gifNotifier.dispose();
    super.dispose();
  }

  // Method to pick a GIF file
  Future<void> getGif() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['gif'],
    );
    if (result != null) {
      setState(() {
        _selectUpperBodyGif = File(result.files.single.path!);
        gifNotifier.value = _selectUpperBodyGif;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add UpperBody Exercise'),
        backgroundColor: theme.appBarTheme.backgroundColor,
        iconTheme: theme.iconTheme,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // GestureDetector to pick and display GIF
                GestureDetector(
                  onTap: () => getGif(),
                  child: ValueListenableBuilder<File?>(
                    valueListenable: gifNotifier,
                    builder: (context, value, child) {
                      return value != null
                          ? ClipRRect(
                              child: Image.file(
                                value,
                                fit: BoxFit.cover,
                                width: 150,
                                height: 150,
                              ),
                            )
                          : Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: Center(
                                child: IconButton(
                                  onPressed: getGif,
                                  icon: const Icon(Icons.add_a_photo),
                                ),
                              ),
                            );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // TextFormField for exercise name
                TextFormField(
                  controller: upperBodyExerciseNameController,
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
                  controller: upperBodyRepsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Reps',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter exercise reps';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // TextFormField for exercise benefits
                TextFormField(
                  controller: upperBodyExerciseBenefitController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Benefits',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this exercise benefit';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // ElevatedButton to confirm addition of exercise
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (gifNotifier.value != null &&
                          upperBodyExerciseNameController.text.isNotEmpty) {
                        final newUpperBodyExercise = UpperBodyExercisesModelClass(
                          upperBodyId: DateTime.now().millisecond,
                          upperBodyExerciseName: upperBodyExerciseNameController.text,
                          upperBodyExerciseGif: gifNotifier.value!.path,
                          upperBodyExerciseBenefit: upperBodyExerciseBenefitController.text,
                          upperBodyReps: upperBodyRepsController.text,
                        );
                        await addUpperBodyExercises(newUpperBodyExercise);
                        // Clear fields and reset gifNotifier after saving
                        upperBodyExerciseNameController.clear();
                        upperBodyExerciseBenefitController.clear();
                        upperBodyRepsController.clear();
                        gifNotifier.value = null;
                        upperBodyExercisesList.notifyListeners();
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(310, 50),
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
