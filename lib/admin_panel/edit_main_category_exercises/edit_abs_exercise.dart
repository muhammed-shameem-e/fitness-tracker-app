import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/abs_exercise_hive_things/abs_exercise_model_class.dart';
import 'package:fullbody_workout/hive_services/abs_exercise_hive_things/hive_funtions.dart';

class EditAbsExerciseData extends StatefulWidget {
  const EditAbsExerciseData({super.key, required this.data});
  final AbsExerciseModelClass data;

  @override
  State<EditAbsExerciseData> createState() => _EditAbsExerciseDataState();
}

class _EditAbsExerciseDataState extends State<EditAbsExerciseData> {
  late String editAbsExerciseName;
  late String absreps;
  String? _editAbsExerciseGif;

  @override
  void initState() {
    super.initState();
    // Initialize state with current exercise data
    editAbsExerciseName = widget.data.absExerciseName;
    absreps = widget.data.absreps;
    _editAbsExerciseGif = widget.data.absExerciseGif.isNotEmpty
        ? widget.data.absExerciseGif
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
                    height: 490,
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
                              child: _editAbsExerciseGif != null
                                  ? ClipRRect(
                                      child: Image.file(
                                        File(_editAbsExerciseGif!),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ClipRRect(
                                      child: Image.file(
                                        File(widget.data.absExerciseGif),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 10),
                            // TextFormField for exercise name
                            TextFormField(
                              initialValue: widget.data.absExerciseName,
                              decoration: const InputDecoration(
                                hintText: 'Name',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                editAbsExerciseName = value;
                              },
                            ),
                            const SizedBox(height: 10),
                            // TextFormField for exercise reps
                            TextFormField(
                              initialValue: widget.data.absreps,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Reps',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                absreps = value;
                              },
                            ),
                            const SizedBox(height: 10),
                            // ElevatedButton to update exercise
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final updatedExercise = AbsExerciseModelClass(
                                    absId: widget.data.absId,
                                    absExerciseGif: _editAbsExerciseGif ?? widget.data.absExerciseGif,
                                    absExerciseName: editAbsExerciseName,
                                    absreps: absreps,
                                    absExerciseBenefit: widget.data.absExerciseBenefit,
                                  );
                                  await updateAbsExercise(updatedExercise);
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
        _editAbsExerciseGif = result.files.single.path!;
      });
    }
  }
}
