import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/abs_exercise_hive_things/abs_exercise_model_class.dart';
import 'package:fullbody_workout/hive_services/abs_exercise_hive_things/hive_funtions.dart';
import 'package:fullbody_workout/user_management/workout_sections/abs_30_days.dart';
import 'package:fullbody_workout/user_management/workout_sections/abs_things/abs_congratulations.dart';
import 'package:fullbody_workout/user_management/workout_sections/abs_things/abs_rest_time.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AbsExerciseOne extends StatefulWidget {
  const AbsExerciseOne({
    super.key,
    required this.exercise,
    required this.index,
    required this.completedDay,
  });

  final AbsExerciseModelClass exercise;
  final int index;
  final int completedDay;

  @override
  State<AbsExerciseOne> createState() => _AbsExerciseOneState();
}

class _AbsExerciseOneState extends State<AbsExerciseOne> {
  bool isThumbDownPressed = false;
  bool isThumbUpPressed = false;

  @override
  void initState() {
    super.initState();
    _saveLikeAndDisLike();
  }

  // Method to load the like/dislike preferences
  Future<void> _saveLikeAndDisLike() async {
    final save = await SharedPreferences.getInstance();
    setState(() {
      isThumbDownPressed = save.getBool('isThumbDownPressed${widget.exercise.absExerciseName}') ?? false;
      isThumbUpPressed = save.getBool('isThumbUpPressed${widget.exercise.absExerciseName}') ?? false;
    });
  }

  // Method to save the like/dislike preferences
  Future<void> savePreferences() async {
    final save = await SharedPreferences.getInstance();
    await save.setBool('isThumbDownPressed${widget.exercise.absExerciseName}', isThumbDownPressed);
    await save.setBool('isThumbUpPressed${widget.exercise.absExerciseName}', isThumbUpPressed);
  }

  @override
  Widget build(BuildContext context) {
    final int length = absExerciseList.value.length;
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.exercise.absExerciseName, style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(width: 5),
            Text('${widget.index + 1}/$length', style: theme.textTheme.bodyMedium),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              alertExitTodayExercise(context);
            },
            icon: const Icon(Icons.exit_to_app_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  child: Image.file(File(widget.exercise.absExerciseGif)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Dislike button
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          isThumbDownPressed = !isThumbDownPressed;
                          isThumbUpPressed = false;
                          savePreferences();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Dislike noted! Let’s find something you enjoy more.",
                              style: TextStyle(color: theme.snackBarTheme.contentTextStyle?.color ?? Colors.white),
                            ),
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.all(20),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                      icon: Icon(Icons.thumb_down, color: isThumbDownPressed ? Colors.red : theme.iconTheme.color),
                    ),
                    // About button
                    IconButton(
                      onPressed: () {
                        showAboutExercise(context, widget.exercise.absExerciseGif, widget.exercise.absExerciseName);
                      },
                      icon: Icon(Icons.question_mark, color: theme.iconTheme.color),
                    ),
                    // Like button
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          isThumbUpPressed = !isThumbUpPressed;
                          isThumbDownPressed = false;
                          savePreferences();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "You liked this exercise! Let's keep moving!",
                              style: TextStyle(color: theme.snackBarTheme.contentTextStyle?.color ?? Colors.white),
                            ),
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.all(20),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      icon: Icon(Icons.thumb_up, color: isThumbUpPressed ? Colors.green : theme.iconTheme.color),
                    ),
                  ],
                ),
              ),
              Text(
                'Benefit of this exercise',
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              Text(
                'When it comes to health, regular\nexercise is about as close to a\nmagic potion as you can get.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Previous exercise button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: isDarkMode ? Colors.grey[800] : const Color.fromARGB(255, 238, 248, 255),
                      padding: const EdgeInsets.all(20),
                      elevation: 0,
                    ),
                    onPressed: () {
                      if (widget.index == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'There is no exercise. This is your first exercise.',
                              style: TextStyle(
                                color: Theme.of(context).snackBarTheme.contentTextStyle?.color ?? Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.all(20),
                          ),
                        );
                      } else if (widget.index > 0) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AbsExerciseOne(
                            exercise: absExerciseList.value[widget.index - 1],
                            index: widget.index - 1,
                            completedDay: widget.completedDay,
                          ),
                        ));
                      }
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 40,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  // Reps button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: isDarkMode ? Colors.grey[800] : const Color.fromARGB(255, 255, 247, 235),
                      padding: const EdgeInsets.all(20),
                      elevation: 0,
                    ),
                    onPressed: () {
                      // Add any onPressed functionality if needed, or leave it empty
                    },
                    child: Text(
                      widget.exercise.absreps,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Next exercise button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: isDarkMode ? Colors.grey[800] : const Color.fromARGB(255, 255, 233, 233),
                      padding: const EdgeInsets.all(20),
                      elevation: 0,
                    ),
                    onPressed: () {
                      if (widget.index == absExerciseList.value.length - 1) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AbsCongratulations(completedDay: widget.completedDay),
                        ));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AbsRestTime(
                            nextExercise: absExerciseList.value[widget.index + 1],
                            completedDay: widget.completedDay,
                          ),
                        ));
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward,
                      size: 40,
                      color: Theme.of(context).iconTheme.color,
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

  // Method to show the alert dialog when user wants to exit today's exercise
  void alertExitTodayExercise(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          content: const Text('Are you sure you want to skip today\'s workout?'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Text(
                'NO',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Abs30Days()),
                );
              },
              icon: const Text(
                'YES',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  // Method to show information about the exercise
  void showAboutExercise(BuildContext context, String gif, String name) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(child: Image.file(File(gif))),
              ),
              Text(
                name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'When it comes to health, regular\nexercise is about as close to a\nmagic potion as you can get.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  minimumSize: WidgetStateProperty.all<Size>(const Size(300, 50)),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
