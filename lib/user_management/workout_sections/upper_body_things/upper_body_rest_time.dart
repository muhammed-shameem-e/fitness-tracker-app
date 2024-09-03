import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/upperbody_exercise_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/upperbody_exercise_hive_things/upperbody_exercise_model_class.dart';
import 'package:fullbody_workout/user_management/workout_sections/upper_body_things/upper_body_exercise_one.dart';

class UpperBodyRestTime extends StatefulWidget {
  // Constructor requiring nextExercise and completedDay parameters
  const UpperBodyRestTime({super.key, required this.nextExercise, required this.completedDay});
  final UpperBodyExercisesModelClass nextExercise;
  final int completedDay;

  @override
  _UpperBodyRestTimeState createState() => _UpperBodyRestTimeState();
}

class _UpperBodyRestTimeState extends State<UpperBodyRestTime> {
  Timer? _timer; // Timer instance for countdown
  int _secondsRemaining = 30; // Initial rest time in seconds

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the countdown timer when the widget is initialized
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
        _navigateToNextExercise(); // Navigate to the next exercise when the timer completes
      }
    });
  }

  void _navigateToNextExercise() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => UpperBodyExerciseOne(
        exercise: widget.nextExercise,
        index: upperBodyExercisesList.value.indexOf(widget.nextExercise),
        completedDay: widget.completedDay,
      ),
    ));
  }

  void _addTime() {
    setState(() {
      _secondsRemaining += 30; // Add 30 seconds to the remaining time
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark; // Check if dark mode is enabled
    int minutes = _secondsRemaining ~/ 60; // Calculate minutes from seconds
    int seconds = _secondsRemaining % 60; // Calculate remaining seconds

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Set background color based on theme
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor, // AppBar color based on theme
        automaticallyImplyLeading: false, // Disable the default back button
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20), // Padding around the content
          child: Column(
            children: [
              // Display the name of the next exercise
              Text(
                'Up Next: ${widget.nextExercise.upperBodyExerciseName}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              // Display the GIF image of the next exercise
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.file(
                  File(widget.nextExercise.upperBodyExerciseGif),
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              // Display rest message and countdown timer
              Text(
                'Take rest',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
              Text(
                '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
              const SizedBox(height: 40),
              // Buttons for adding time or skipping to the next exercise
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _addTime,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? Colors.grey[800] : const Color.fromARGB(255, 238, 248, 255),
                      minimumSize: const Size(75, 75),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      '+30s',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _navigateToNextExercise,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? Colors.grey[800] : const Color.fromARGB(255, 255, 233, 233),
                      minimumSize: const Size(75, 75),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
