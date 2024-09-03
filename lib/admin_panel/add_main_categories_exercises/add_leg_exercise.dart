import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fullbody_workout/hive_services/leg_exercise_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/leg_exercise_hive_things/leg_exercise_model_class.dart';

class AddLegExercise extends StatefulWidget {
  const AddLegExercise({super.key});

  @override
  State<AddLegExercise> createState() => _AddLegExerciseState();
}

class _AddLegExerciseState extends State<AddLegExercise> {
  File? _selectLegGif;
  final TextEditingController legExerciseNameController = TextEditingController();
  final TextEditingController legrepsController = TextEditingController();
  final TextEditingController legExerciseBenefitController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ValueNotifier<File?> gifNotifier = ValueNotifier<File?>(null);

  @override
  void dispose() {
    // Dispose controllers and value notifiers to free resources
    legExerciseNameController.dispose();
    legrepsController.dispose();
    legExerciseBenefitController.dispose();
    gifNotifier.dispose();
    super.dispose();
  }

  // Check if the first letter of the string is capitalized
  bool isFirstLetterCapital(String value) {
    return value.isNotEmpty && value[0] == value[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Leg Exercise'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // GestureDetector to pick and display GIF
              GestureDetector(
                onTap: () => getGif().then((value) {
                  if (_selectLegGif != null) {
                    gifNotifier.value = _selectLegGif;
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
                              height: 150,
                              width: 150,
                            ),
                          )
                        : Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: IconButton(
                                icon: const Icon(Icons.add_a_photo),
                                onPressed: () {
                                  getGif().then((value) {
                                    if (_selectLegGif != null) {
                                      gifNotifier.value = _selectLegGif;
                                    }
                                  });
                                },
                              ),
                            ),
                          );
                  },
                ),
              ),
              const SizedBox(height: 20),
              // TextFormField for exercise name
              TextFormField(
                controller: legExerciseNameController,
                decoration: InputDecoration(
                  labelText: 'Name',
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
                controller: legrepsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Reps',
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
                controller: legExerciseBenefitController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Benefit',
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
                    if (gifNotifier.value != null && legExerciseNameController.text.isNotEmpty) {
                      final newLegExercise = LegExerciseModelClass(
                        legId: DateTime.now().millisecond,
                        legExerciseGif: gifNotifier.value!.path,
                        legExerciseName: legExerciseNameController.text,
                        legExerciseBenefit: legExerciseBenefitController.text,
                        legreps: legrepsController.text,
                      );
                      await addLegExercises(newLegExercise);
                      // Clear fields and reset gifNotifier after saving
                      legExerciseBenefitController.clear();
                      legExerciseNameController.clear();
                      legrepsController.clear();
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
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to pick a GIF file
  Future<void> getGif() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['gif'],
    );
    if (result != null) {
      setState(() {
        _selectLegGif = File(result.files.single.path!);
        gifNotifier.value = _selectLegGif;
      });
    }
  }
}
