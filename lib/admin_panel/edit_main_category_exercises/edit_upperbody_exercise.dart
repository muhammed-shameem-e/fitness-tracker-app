import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/upperbody_exercise_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/upperbody_exercise_hive_things/upperbody_exercise_model_class.dart';

class EditUpperbodyExerciseData extends StatefulWidget {
  const EditUpperbodyExerciseData({super.key, required this.data});
  final UpperBodyExercisesModelClass data;

  @override
  State<EditUpperbodyExerciseData> createState() => _EditUpperbodyExerciseDataState();
}

class _EditUpperbodyExerciseDataState extends State<EditUpperbodyExerciseData> {
  late String editUpperbodyExerciseName;
  late String editUpperBodyReps;
  String? _editUpperbodyExerciseGif;

  @override
  void initState() {
    super.initState();
    // Initialize the state with current exercise data
    editUpperbodyExerciseName = widget.data.upperBodyExerciseName;
    editUpperBodyReps = widget.data.upperBodyReps;
    _editUpperbodyExerciseGif = widget.data.upperBodyExerciseGif.isNotEmpty ?
    widget.data.upperBodyExerciseGif : null;
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
                      color: Colors.white
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
                              child: _editUpperbodyExerciseGif != null
                                  ? ClipRRect(
                                      child: Image.file(
                                        File(_editUpperbodyExerciseGif!),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ClipRRect(
                                      child: Image.file(
                                        File(widget.data.upperBodyExerciseGif),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 10),
                            // TextFormField for exercise name
                            TextFormField(
                              initialValue: widget.data.upperBodyExerciseName,
                              decoration: const InputDecoration(
                                hintText: 'Name',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                editUpperbodyExerciseName = value;
                              },
                            ),
                            const SizedBox(height: 10),
                            // TextFormField for exercise reps
                            TextFormField(
                              initialValue: widget.data.upperBodyReps,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Reps',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                editUpperBodyReps = value;
                              },
                            ),
                            const SizedBox(height: 10),
                            // ElevatedButton to update exercise
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final updatedExercise = UpperBodyExercisesModelClass(
                                    upperBodyId: widget.data.upperBodyId,
                                    upperBodyExerciseGif: _editUpperbodyExerciseGif ?? widget.data.upperBodyExerciseGif,
                                    upperBodyExerciseName: editUpperbodyExerciseName,
                                    upperBodyExerciseBenefit: widget.data.upperBodyExerciseBenefit,
                                    upperBodyReps: editUpperBodyReps,
                                  );
                                  await updateUpperBodyExercise(updatedExercise);
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
        _editUpperbodyExerciseGif = result.files.single.path!;
      });
    }
  }
}
