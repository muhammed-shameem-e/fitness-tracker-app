import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/leg_exercise_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/leg_exercise_hive_things/leg_exercise_model_class.dart';

class EditLegExerciseData extends StatefulWidget {
  const EditLegExerciseData({super.key, required this.data});
  final LegExerciseModelClass data;

  @override
  State<EditLegExerciseData> createState() => _EditLegExerciseDataState();
}

class _EditLegExerciseDataState extends State<EditLegExerciseData> {
  late String editLegExerciseName;
  late String editLegreps;
  String? _editLegExerciseGif;

  @override
  void initState() {
    super.initState();
    // Initialize state with current exercise data
    editLegExerciseName = widget.data.legExerciseName;
    editLegreps = widget.data.legreps;
    _editLegExerciseGif = widget.data.legExerciseGif.isNotEmpty
        ? widget.data.legExerciseGif
        : null;
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
                    height: 480,
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
                            // GestureDetector to pick and display GIF
                            GestureDetector(
                              onTap: () => getGif(),
                              child: _editLegExerciseGif != null
                                  ? ClipRRect(
                                      child: Image.file(
                                        File(_editLegExerciseGif!),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ClipRRect(
                                      child: Image.file(
                                        File(widget.data.legExerciseGif),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 10),
                            // TextFormField for exercise name
                            TextFormField(
                              initialValue: widget.data.legExerciseName,
                              decoration: const InputDecoration(
                                hintText: 'Name',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                editLegExerciseName = value;
                              },
                            ),
                            const SizedBox(height: 10),
                            // TextFormField for exercise reps
                            TextFormField(
                              initialValue: widget.data.legreps,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Reps',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                editLegreps = value;
                              },
                            ),
                            const SizedBox(height: 10),
                            // ElevatedButton to update exercise
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final updatedExercise = LegExerciseModelClass(
                                    legId: widget.data.legId,
                                    legExerciseGif: _editLegExerciseGif ?? widget.data.legExerciseGif,
                                    legExerciseName: editLegExerciseName,
                                    legreps: editLegreps,
                                    legExerciseBenefit: widget.data.legExerciseBenefit,
                                  );
                                  await updateLegExercise(updatedExercise);
                                  Navigator.of(context).pop(updatedExercise);
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
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
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

  // Function to pick a GIF file
  Future<void> getGif() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['gif'],
    );
    if (result != null) {
      setState(() {
        _editLegExerciseGif = result.files.single.path!;
      });
    }
  }
}
