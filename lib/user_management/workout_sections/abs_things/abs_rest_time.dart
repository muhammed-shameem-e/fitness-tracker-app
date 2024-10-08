import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fullbody_workout/user_management/workout_sections/abs_things/abs_exercise_one.dart';

class AbsRestTime extends StatefulWidget {
  const AbsRestTime({
    super.key,
    required this.completedDay,
    required this.index
  });
  final int completedDay; // Day number for tracking progress
  final int index;

  @override
  _AbsRestTimeState createState() => _AbsRestTimeState();
}

class _AbsRestTimeState extends State<AbsRestTime> {
  Timer? _timer;
  int _secondsRemaining = 60; // Initial rest time in seconds
  

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the timer when the widget is initialized
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--; // Update the remaining seconds
        });
      } else {
        _timer?.cancel();
        _navigateToNextExercise(); // Navigate to the next exercise when time is up
      }
    });
  }

  void _navigateToNextExercise() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => AbsExerciseOne(
        completedDay: widget.completedDay,
        index: widget.index,
      ),
    ));
  }

  void _addTime() {
    setState(() {
      _secondsRemaining += 30; // Add 30 seconds to the rest time
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    int minutes = _secondsRemaining ~/ 60; // Calculate minutes
    int seconds = _secondsRemaining % 60; // Calculate seconds

    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color ?? Colors.black;
    final backgroundColor = theme.scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
        iconTheme: theme.iconTheme,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Display the exercise GIF
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  'assets/restime.gif',
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              // Display rest instructions and timer
              Text(
                'Take rest',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: textColor,
                ),
              ),
              Text(
                '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 40),
              // Buttons to add time or skip rest
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
                    ),
                  ),
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
                      style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
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
