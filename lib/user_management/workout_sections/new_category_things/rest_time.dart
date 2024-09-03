import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fullbody_workout/user_management/workout_sections/new_category_things/show_one_exercise.dart';

class NewCategoryRestTime extends StatefulWidget {
  const NewCategoryRestTime({
    super.key,
    required this.nextExercise,
    required this.completedDay,
  });

  final Widget? nextExercise; // The next exercise widget to navigate to
  final int completedDay; // The number of days the user has completed

  @override
  _NewCategoryRestTimeState createState() => _NewCategoryRestTimeState();
}

class _NewCategoryRestTimeState extends State<NewCategoryRestTime> {
  Timer? _timer; // Timer for the countdown
  int _secondsRemaining = 3; // Remaining seconds for rest time

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the timer when the widget is initialized
  }

  // Function to start the countdown timer
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--; // Decrement the remaining seconds
        });
      } else {
        _timer?.cancel(); // Cancel the timer when countdown reaches zero
        _navigateToNextExercise(); // Navigate to the next exercise
      }
    });
  }

  // Function to navigate to the next exercise
  void _navigateToNextExercise() {
    if (widget.nextExercise != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => widget.nextExercise!,
        ),
      );
    }
  }

  // Function to add 30 seconds to the rest time
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
    final theme = Theme.of(context);
    int minutes = _secondsRemaining ~/ 60; // Calculate remaining minutes
    int seconds = _secondsRemaining % 60; // Calculate remaining seconds

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        automaticallyImplyLeading: false, // Disable back button in app bar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Display the name of the next exercise
              Text(
                widget.nextExercise != null
                    ? 'Up Next: ${(widget.nextExercise as NewCategoryExerciseOne).exercise.execiseName}'
                    : '',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              // Display the exercise image
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: widget.nextExercise != null
                    ? Image.file(
                        File((widget.nextExercise as NewCategoryExerciseOne).exercise.execiseGif),
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(), 
              ),
              const SizedBox(height: 20),
              // Display 'Take rest' text
              Text(
                'Take rest',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
              // Display the remaining time in mm:ss format
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
              // Buttons to add time or skip the rest
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
                    child: const Text(
                      '+30s',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => widget.nextExercise!,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? Colors.grey[800] : const Color.fromARGB(255, 255, 233, 233),
                      minimumSize: const Size(75, 75),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.black,
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
