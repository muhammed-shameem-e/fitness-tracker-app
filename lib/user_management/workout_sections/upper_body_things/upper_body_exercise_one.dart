import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/upperbody_exercise_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/upperbody_exercise_hive_things/upperbody_exercise_model_class.dart';
import 'package:fullbody_workout/user_management/workout_sections/upper_body_30_days.dart';
import 'package:fullbody_workout/user_management/workout_sections/upper_body_things/upper_body_rest_time.dart';
import 'package:fullbody_workout/user_management/workout_sections/upper_body_things/upperbody_congratulations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpperBodyExerciseOne extends StatefulWidget {
  const UpperBodyExerciseOne({
    super.key,
    required this.exercise,
    required this.index,
    required this.completedDay,
  });

  final UpperBodyExercisesModelClass exercise;
  final int index;
  final int completedDay;

  @override
  State<UpperBodyExerciseOne> createState() => _UpperBodyExerciseOneState();
}

class _UpperBodyExerciseOneState extends State<UpperBodyExerciseOne> {

  bool isThumbDownPressed = false;
  bool isThumbUpPressed = false;

  // Load saved preferences for likes and dislikes
  Future<void> saveLikeAndDisLike() async {
    final save = await SharedPreferences.getInstance();
    setState(() {
      isThumbDownPressed = save.getBool('isThumbDownPressed${widget.exercise.upperBodyExerciseName}') ?? false;
      isThumbUpPressed = save.getBool('isThumbUpPressed${widget.exercise.upperBodyExerciseName}') ?? false;
    });
  }

  // Save the current state of likes and dislikes
  Future<void> savePreferences() async {
    final save = await SharedPreferences.getInstance();
    await save.setBool('isThumbDownPressed${widget.exercise.upperBodyExerciseName}', isThumbDownPressed);
    await save.setBool('isThumbUpPressed${widget.exercise.upperBodyExerciseName}', isThumbUpPressed);
  }

  @override
  void initState() {
    super.initState();
    saveLikeAndDisLike();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final int length = upperBodyExercisesList.value.length;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.exercise.upperBodyExerciseName,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              '${widget.index + 1}/$length',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 15,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _alertExitTodayExercise(context);
            },
            icon: Icon(
              Icons.exit_to_app_rounded,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              // Exercise GIF display
              Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(File(widget.exercise.upperBodyExerciseGif)),
                ),
              ),
              // Like/Dislike buttons
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          isThumbDownPressed = !isThumbDownPressed;
                          isThumbUpPressed = false;
                          savePreferences();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Dislike noted! Let’s find something you enjoy more.",
                              style: TextStyle(color: Colors.white),
                            ),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(20),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.thumb_down,
                        color: isThumbDownPressed ? Colors.red : Theme.of(context).iconTheme.color,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showAboutExercise(
                          context,
                          widget.exercise.upperBodyExerciseGif,
                          widget.exercise.upperBodyExerciseName,
                        );
                      },
                      icon: Icon(
                        Icons.question_mark_sharp,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isThumbUpPressed = !isThumbUpPressed;
                          isThumbDownPressed = false;
                          savePreferences();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "You liked this exercise! Let's keep moving!",
                              style: TextStyle(color: Colors.white),
                            ),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(20),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.thumb_up,
                        color: isThumbUpPressed ? Colors.green : Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ],
                ),
              ),
              // Exercise benefit information
              const Text(
                'Benefit of this exercise',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              const Text(
                'When it comes to health, regular\nexercise is about as close to a\nmagic potion as you can get.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Navigation buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: isDarkMode ? Colors.grey[800] : const Color.fromARGB(255, 238, 248, 255),
                      padding: const EdgeInsets.all(20),
                    ),
                    onPressed: () {
                      if (widget.index == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'There is no exercise. This is your first exercise.',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(20),
                          ),
                        );
                      } else if (widget.index > 0) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UpperBodyExerciseOne(
                            exercise: upperBodyExercisesList.value[widget.index - 1],
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: isDarkMode ? Colors.grey[800] : const Color.fromARGB(255, 255, 247, 235),
                      padding: const EdgeInsets.all(20),
                    ),
                    onPressed: () {
                      // Add your onPressed functionality here if needed
                    },
                    child: Text(
                      widget.exercise.upperBodyReps,
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: isDarkMode
                          ? Colors.grey[800]
                          : const Color.fromARGB(255, 255, 233, 233),
                      padding: const EdgeInsets.all(20),
                    ),
                    onPressed: () {
                      if (widget.index == upperBodyExercisesList.value.length - 1) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => UpperbodyCongratulation(completedDay: widget.completedDay),
                          ),
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UpperBodyRestTime(
                              nextExercise: upperBodyExercisesList.value[widget.index + 1],
                              completedDay: widget.completedDay,
                            ),
                          ),
                        );
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

  // Show alert dialog for skipping today's workout
  void _alertExitTodayExercise(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Are you sure you want to skip today\'s workout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'NO',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const UpperBody30Days()),
                );
              },
              child: const Text(
                'YES',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  // Show bottom sheet with exercise information
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
                child: ClipRRect(
                  child: Image.file(File(gif)),
                ),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(300, 50),
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
