import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/create_my_plan_hive_things/hive_functions.dart';
import 'dart:async';

import 'package:fullbody_workout/hive_services/create_my_plan_hive_things/model_class.dart';
import 'package:fullbody_workout/user_management/create_my_plan_sections/day_one_workout_way/user_day_one_exercise.dart';

class UserExerciseRestTime extends StatefulWidget {
  const UserExerciseRestTime({super.key, required this.nextExercise});
  final CreateUserPlan nextExercise;

  @override
  _UserExerciseRestTimeState createState() => _UserExerciseRestTimeState();
}

class _UserExerciseRestTimeState extends State<UserExerciseRestTime> {
  Timer? _timer;
  int _secondsRemaining = 15;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
        _navigateToNextExercise();
      }
    });
  }

  void _navigateToNextExercise() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => UserExerciseOne(
        exercise: widget.nextExercise,
        index: createUserPlanList.value.indexOf(widget.nextExercise),
      ),
    ));
  }

  void _addTime() {
    setState(() {
      _secondsRemaining += 30;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;

    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Up Next: ${widget.nextExercise.exerciseName}',
                style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color,fontSize: 18,
                  fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.file(
                  File(widget.nextExercise.exerciseGif),
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Take rest',
               style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color,fontSize: 25,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,),
              ),
              Text(
                '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                 style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color,fontSize: 35,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _addTime,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        isDarkMode
                            ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                            : Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                      ),
                      minimumSize: WidgetStateProperty.all<Size>(
                        const Size(75, 75),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
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
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => UserExerciseOne(
                          exercise: widget.nextExercise,
                          index: createUserPlanList.value.indexOf(widget.nextExercise),
                        ),
                      ));
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        isDarkMode
                            ? Theme.of(context).colorScheme.secondary.withOpacity(0.2)
                            : Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                      ),
                      minimumSize: WidgetStateProperty.all<Size>(
                        const Size(75, 75),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
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
