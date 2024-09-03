import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/abs_exercise_hive_things/abs_exercise_model_class.dart';
import 'package:fullbody_workout/hive_services/abs_exercise_hive_things/hive_funtions.dart';
import 'package:file_picker/file_picker.dart';

class AddAbsExercise extends StatefulWidget {
  const AddAbsExercise({super.key});

  @override
  State<AddAbsExercise> createState() => _AddAbsExerciseState();
}

class _AddAbsExerciseState extends State<AddAbsExercise> {
  File? _selectedAbsGif;
  TextEditingController absExerciseNameController = TextEditingController();
  TextEditingController absRepsController = TextEditingController();
  TextEditingController absExerciseBenefitController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ValueNotifier<File?> gifNotifier = ValueNotifier<File?>(null);

  // Check if the first letter of the string is capitalized
  bool isFirstLetterCapital(String value) {
    return value.isNotEmpty && value[0] == value[0].toUpperCase();
  }

  @override
  void dispose() {
    // Dispose controllers and value notifier to free resources
    absExerciseNameController.dispose();
    absRepsController.dispose();
    absExerciseBenefitController.dispose();
    gifNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Add Abs Exercise"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // GestureDetector to pick and display GIF
                GestureDetector(
                  onTap: () => _getGif().then((value) {
                    if (_selectedAbsGif != null) {
                      gifNotifier.value = _selectedAbsGif;
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
                                  onPressed: () {
                                    _getGif().then((value) {
                                      if (_selectedAbsGif != null) {
                                        gifNotifier.value = _selectedAbsGif;
                                      }
                                    });
                                  },
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
                  controller: absExerciseNameController,
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
                  controller: absRepsController,
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
                  controller: absExerciseBenefitController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Benefit',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter this exercise benefit';
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
                          absExerciseNameController.text.isNotEmpty &&
                          absRepsController.text.isNotEmpty &&
                          absExerciseBenefitController.text.isNotEmpty) {
                        final newAbsExercise = AbsExerciseModelClass(
                          absId: DateTime.now().millisecond,
                          absExerciseGif: gifNotifier.value!.path,
                          absExerciseName: absExerciseNameController.text,
                          absreps: absRepsController.text,
                          absExerciseBenefit: absExerciseBenefitController.text,
                        );
                        await addAbsExercise(newAbsExercise);
                        // Clear fields and reset gifNotifier after saving
                        absExerciseNameController.clear();
                        absRepsController.clear();
                        absExerciseBenefitController.clear();
                        gifNotifier.value = null;
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
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to pick a GIF file
  Future<void> _getGif() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['gif'],
    );
    if (result != null) {
      setState(() {
        _selectedAbsGif = File(result.files.single.path!);
        gifNotifier.value = _selectedAbsGif;
      });
    }
  }
}
