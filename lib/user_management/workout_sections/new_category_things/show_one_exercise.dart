import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/add_new_exercise_hive_things/model_class.dart';
import 'package:fullbody_workout/user_management/workout_sections/new_category_things/congratulations.dart';
import 'package:fullbody_workout/user_management/workout_sections/new_category_things/rest_time.dart';
import 'package:fullbody_workout/user_management/workout_sections/upper_body_30_days.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewCategoryExerciseOne extends StatefulWidget {
  const NewCategoryExerciseOne({
    super.key,
    required this.exercise,
    required this.index,
    required this.allExercises,
    required this.completedDay,
  });

  final AddNewExerciseModelClass exercise;
  final int index;
  final List<AddNewExerciseModelClass> allExercises;
  final int completedDay;

  @override
  _NewCategoryExerciseOneState createState() => _NewCategoryExerciseOneState();
}

class _NewCategoryExerciseOneState extends State<NewCategoryExerciseOne> {
  bool isThumbDownPressed = false;
  bool isThumbUpPressed = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Load thumb button states from SharedPreferences
  }

  // Load thumb button states from SharedPreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isThumbDownPressed = prefs.getBool('isThumbDownPressed_${widget.exercise.execiseName}') ?? false;
      isThumbUpPressed = prefs.getBool('isThumbUpPressed_${widget.exercise.execiseName}') ?? false;
    });
  }

  // Save thumb button states to SharedPreferences
  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isThumbDownPressed_${widget.exercise.execiseName}', isThumbDownPressed);
    await prefs.setBool('isThumbUpPressed_${widget.exercise.execiseName}', isThumbUpPressed);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final appBarColor = isDarkMode ? Colors.grey[900] : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final buttonColor = isDarkMode ? Colors.green[300] : Colors.green;
    final snackBarBackgroundColor = isDarkMode ? Colors.grey[800] : Colors.white;
    final thumbIconColor = isDarkMode ? Colors.grey[400] : Colors.black;

    final length = widget.allExercises.length;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.exercise.execiseName,
              style: TextStyle(fontWeight: FontWeight.w500, color: textColor),
            ),
            const SizedBox(width: 5),
            Text(
              '${widget.index + 1}/$length',
              style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 15),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              alertExitTodayExercise(context);
            },
            icon: Icon(Icons.exit_to_app_rounded, color: textColor),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                child: Image.file(File(widget.exercise.execiseGif)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Thumb Down Button
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isThumbDownPressed = !isThumbDownPressed;
                        isThumbUpPressed = false;
                        _savePreferences();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Dislike noted! Let’s find something you enjoy more.",
                            style: TextStyle(color: textColor),
                          ),
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(20),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.thumb_down,
                      color: isThumbDownPressed ? Colors.red : thumbIconColor,
                    ),
                  ),
                  // Info Button
                  IconButton(
                    onPressed: () {
                      showAboutExercise(context, widget.exercise.execiseGif, widget.exercise.execiseName);
                    },
                    icon: Icon(Icons.question_mark, color: thumbIconColor),
                  ),
                  // Thumb Up Button
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isThumbUpPressed = !isThumbUpPressed;
                        isThumbDownPressed = false;
                        _savePreferences();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "You liked this exercise! Let's keep moving!",
                            style: TextStyle(color: textColor),
                          ),
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(20),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.thumb_up,
                      color: isThumbUpPressed ? Colors.green : thumbIconColor,
                    ),
                  ),
                ],
              ),
            ),
            // Exercise Benefit Text
            Text(
              'Benefit of this exercise',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: textColor),
            ),
            const SizedBox(height: 20),
            Text(
              'When it comes to health, regular\nexercise is about as close to a\nmagic potion as you can get.',
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor),
            ),
            const SizedBox(height: 40),
            // Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Previous Exercise Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(), // Ensures the button remains circular
                    backgroundColor: isDarkMode ? Colors.grey[800] : const Color.fromARGB(255, 238, 248, 255), // Background color
                    padding: const EdgeInsets.all(20), // Adjust the size of the button
                  ),
                  onPressed: () {
                    if (widget.index == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'There is no exercise. This is your first exercise',
                            style: TextStyle(color: textColor),
                          ),
                          backgroundColor: buttonColor,
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(20),
                        ),
                      );
                    } else if (widget.index > 0) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NewCategoryExerciseOne(
                            exercise: widget.allExercises[widget.index - 1],
                            index: widget.index - 1,
                            allExercises: widget.allExercises,
                            completedDay: widget.completedDay,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 40,
                  ),
                ),
                // Current Exercise Reps Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(), // Ensures the button is circular
                    backgroundColor: isDarkMode ? Colors.grey[800] : const Color.fromARGB(255, 255, 247, 235), // Background color
                    padding: const EdgeInsets.all(20), // Padding to control the size of the button
                  ),
                  onPressed: () {
                    // Add onPressed functionality if needed
                  },
                  child: Text(
                    widget.exercise.exerciseReps,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center, // Centers the text within the button
                  ),
                ),
                // Next Exercise/Rest Time Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(), // Makes the button circular
                    backgroundColor: isDarkMode ? Colors.grey[800] : const Color.fromARGB(255, 255, 233, 233), // Background color
                    padding: const EdgeInsets.all(20), // Controls the size to match radius 40 (diameter 80)
                    elevation: 0, // Removes elevation to mimic CircleAvatar's flat appearance
                  ),
                  onPressed: () {
                    if (widget.index == widget.allExercises.length - 1) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => NewCategoryCongratulations(
                            completedDay: widget.completedDay,
                          ),
                        ),
                      );
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NewCategoryRestTime(
                            completedDay: widget.completedDay,
                            nextExercise: widget.index < widget.allExercises.length - 1
                                ? NewCategoryExerciseOne(
                                    exercise: widget.allExercises[widget.index + 1],
                                    index: widget.index + 1,
                                    allExercises: widget.allExercises,
                                    completedDay: widget.completedDay,
                                  )
                                : null,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Show an alert to confirm exit from today's exercise
  void alertExitTodayExercise(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Exit Today's Exercise"),
        content: const Text("Are you sure you want to exit?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Close the dialog
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Close the dialog
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const UpperBody30Days(), // Replace this with your main screen or appropriate page
                ),
              );
            },
            child: const Text("Exit"),
          ),
        ],
      ),
    );
  }

  // Show information about the exercise
  void showAboutExercise(BuildContext context, String gif, String name) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.file(File(gif)), // Display the exercise GIF
            const SizedBox(height: 20),
            const Text(
              "This exercise helps in improving strength and endurance. It's crucial for maintaining overall fitness.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Close the dialog
            },
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}
