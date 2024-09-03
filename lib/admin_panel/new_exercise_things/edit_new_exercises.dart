import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/add_new_exercise_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/add_new_exercise_hive_things/model_class.dart';

class EditAllExerciseData extends StatefulWidget {
  const EditAllExerciseData({super.key, required this.data});
  final AddNewExerciseModelClass data;

  @override
  State<EditAllExerciseData> createState() => _EditAllExerciseDataState();
}

class _EditAllExerciseDataState extends State<EditAllExerciseData> {
  late String editNewExerciseName;
  String? _editAllExerciseGif;
  late dynamic editNewExerciseReps;

  @override
  void initState() {
    super.initState();
    // Initialize the state with the data passed to the widget
    editNewExerciseName = widget.data.execiseName;
    editNewExerciseReps = widget.data.exerciseReps;
    _editAllExerciseGif = widget.data.execiseGif.isNotEmpty ? widget.data.execiseGif : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 196, 196, 196),
      ),
      backgroundColor: const Color.fromARGB(255, 196, 196, 196),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 500,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Display exercise GIF and allow user to pick a new one
                            GestureDetector(
                              onTap: () => getGif(),
                              child: _editAllExerciseGif != null
                                  ? ClipRRect(
                                      child: Image.file(
                                        File(_editAllExerciseGif!),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ClipRRect(
                                      child: Image.file(
                                        File(widget.data.execiseGif),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 10),
                            // Text field to edit exercise name
                            TextFormField(
                              initialValue: widget.data.execiseName,
                              decoration: const InputDecoration(
                                hintText: 'Enter exercise name',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                editNewExerciseName = value;
                              },
                            ),
                            const SizedBox(height: 10),
                            // Text field to edit exercise reps
                            TextFormField(
                              initialValue: widget.data.exerciseReps,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Reps',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                editNewExerciseReps = value;
                              },
                            ),
                            const SizedBox(height: 10),
                            // Button to update the exercise
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                onPressed: () async {
                                  // Create a new exercise data object
                                  AddNewExerciseModelClass newDatas = AddNewExerciseModelClass(
                                    addAllExerciseId: widget.data.addAllExerciseId,
                                    execiseGif: _editAllExerciseGif ?? widget.data.execiseGif,
                                    execiseName: editNewExerciseName,
                                    exerciseBenefit: widget.data.exerciseBenefit,
                                    exerciseReps: editNewExerciseReps,
                                  );
                                  // Update the exercise in Hive
                                  await updateAllExercise(newDatas);
                                  Navigator.of(context).pop(newDatas);
                                },
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Update',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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

  // Function to pick a new GIF file
  Future<void> getGif() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['gif'],
    );
    if (result != null) {
      setState(() {
        _editAllExerciseGif = result.files.single.path!;
      });
    }
  }
}
