import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/leg_exercise_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/leg_exercise_hive_things/leg_exercise_model_class.dart';
import 'package:fullbody_workout/user_management/workout_sections/leg_things/leg_exerice_one.dart';

class LegRestTime extends StatefulWidget {
  const LegRestTime({super.key, required this.nextExercise, required this.completedDay});
  final LegExerciseModelClass nextExercise; // Next exercise details
  final int completedDay; // Number of days completed

  @override
  _LegRestTimeState createState() => _LegRestTimeState();
}

class _LegRestTimeState extends State<LegRestTime> {
  Timer? _timer;
  int _secondsRemaining = 3; // Initial timer duration in seconds

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the timer when the widget is initialized
  }

  // Starts a countdown timer
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--; // Update the remaining seconds
        });
      } else {
        _timer?.cancel(); // Cancel the timer when it reaches zero
        _navigateToNextExercise(); // Navigate to the next exercise
      }
    });
  }

  // Navigates to the next exercise screen
  void _navigateToNextExercise() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LegExerciseOne(
        exercise: widget.nextExercise,
        index: legExerciseList.value.indexOf(widget.nextExercise),
        completedDay: widget.completedDay,
      ),
    ));
  }

  // Adds 30 seconds to the remaining time
  void _addTime() {
    setState(() {
      _secondsRemaining += 30;
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
    final backgroundColor = isDarkMode ? Colors.black : const Color.fromARGB(255, 245, 244, 244); // Background color
    final appBarColor = isDarkMode ? Colors.black : const Color.fromARGB(255, 245, 244, 244); // AppBar color
    final textColor = isDarkMode ? Colors.white : Colors.black; // Text color

    int minutes = _secondsRemaining ~/ 60; // Calculate minutes
    int seconds = _secondsRemaining % 60; // Calculate seconds
    
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        automaticallyImplyLeading: false, // No back button
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20), // Padding around the content
          child: Column(
            children: [
              Text(
                'Up Next: ${widget.nextExercise.legExerciseName}', // Display the next exercise name
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.file(
                  File(widget.nextExercise.legExerciseGif), // Display exercise GIF
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Take rest',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}', // Format timer
                style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Add 30 seconds button
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
                      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Skip button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => LegExerciseOne(
                          exercise: widget.nextExercise,
                          index: legExerciseList.value.indexOf(widget.nextExercise),
                          completedDay: widget.completedDay,
                        ),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? Colors.grey[800] : const Color.fromARGB(255, 255, 233, 233),
                      minimumSize: const Size(75, 75),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      'Skip',
                      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color, fontWeight: FontWeight.w500),
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
