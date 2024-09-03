import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/create_my_plan_hive_things/hive_functions.dart';
import 'package:fullbody_workout/hive_services/create_my_plan_hive_things/model_class.dart';
import 'package:fullbody_workout/hive_services/user_detail_hive_things/user_model_class.dart';
import 'package:fullbody_workout/user_management/create_my_plan_sections/day_one_workout_way/user_exercise_congratulations.dart';
import 'package:fullbody_workout/user_management/create_my_plan_sections/day_one_workout_way/user_exercise_rest_time.dart';
import 'package:fullbody_workout/user_management/main_four_pages_here/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserExerciseOne extends StatefulWidget {
  // Constructor with required parameters
  const UserExerciseOne({super.key, required this.exercise, required this.index});
  final CreateUserPlan exercise;
  final int index;

  @override
  State<UserExerciseOne> createState() => _UserExerciseOneState();
}

class _UserExerciseOneState extends State<UserExerciseOne> {
  bool isThumbDownPressed = false;
  bool isThumbUpPressed = false;

  @override
  void initState() {
    super.initState();
    // Load saved preferences when the widget initializes
    saveLikeAndDisLike();
  }

  // Load saved preferences from SharedPreferences
  Future<void> saveLikeAndDisLike() async {
    final save = await SharedPreferences.getInstance();
    setState(() {
      isThumbDownPressed = save.getBool('isThumbDownPressed${widget.exercise.exerciseName}') ?? false;
      isThumbUpPressed = save.getBool('isThumbUpPressed${widget.exercise.exerciseName}') ?? false;
    });
  }

  // Save current preferences to SharedPreferences
  Future<void> savePreferences() async {
    final save = await SharedPreferences.getInstance();
    await save.setBool('isThumbDownPressed${widget.exercise.exerciseName}', isThumbDownPressed);
    await save.setBool('isThumbUpPressed${widget.exercise.exerciseName}', isThumbUpPressed);
  }

  @override
  Widget build(BuildContext context) {
    final length = createUserPlanList.value.length;
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.exercise.exerciseName, 
                style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color, fontWeight: FontWeight.w500)),
            const SizedBox(width: 5),
            Text('${widget.index + 1}/$length',
                style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color, fontSize: 15)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => alertExitTodayExercise(context),
            icon: Icon(Icons.exit_to_app_rounded, color: theme.iconTheme.color),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // Display exercise GIF
              Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(File(widget.exercise.exerciseGif)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Thumb down button
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          isThumbDownPressed = !isThumbDownPressed;
                          isThumbUpPressed = false;
                          savePreferences();
                        });
                      },
                      icon: Icon(Icons.thumb_down, color: isThumbDownPressed ? Colors.red : theme.iconTheme.color),
                    ),
                     // Info button to show about exercise
                     IconButton(
                      onPressed: () {
                        showAboutExercise(
                          context,
                          widget.exercise.exerciseGif,
                          widget.exercise.exerciseName
                        );
                      },
                      icon: Icon(
                        Icons.question_mark_sharp,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    // Thumb up button
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isThumbUpPressed = !isThumbUpPressed;
                          isThumbDownPressed = false;
                          savePreferences();
                        });
                      },
                      icon: Icon(Icons.thumb_up, color: isThumbUpPressed ? Colors.green : theme.iconTheme.color),
                    ),
                  ],
                ),
              ),
              // Exercise benefit text
              Text('Benefit of this exercise', 
                  style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color, fontSize: 20, fontWeight: FontWeight.w500)),
              const SizedBox(height: 20),
              Text(
                'When it comes to health, regular\nexercise is about as close to a\nmagic potion as you can get.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color)
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Back button
                  CircleAvatar(
                    backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                    radius: 40,
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(), // Circular shape
                          padding: const EdgeInsets.all(20), 
                          backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200], // Match CircleAvatar color
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UserExerciseOne(
                                  exercise: createUserPlanList.value[widget.index - 1],
                                  index: widget.index - 1,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Icon(Icons.arrow_back, size: 40), // Icon inside ElevatedButton
                      ),
                    ),
                  ),
                  // Exercise reps button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(), // Circular shape for the button
                      padding: const EdgeInsets.all(20), // Adjust padding as needed
                      backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200], // Button color
                    ),
                    onPressed: () {
                      // Define what happens when the button is pressed
                    },
                    child: Text(
                      widget.exercise.exerciseReps,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  // Forward button
                  CircleAvatar(
                    backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                    radius: 40,
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(), // Circular shape
                          padding: const EdgeInsets.all(20), // Adjust padding for icon size
                          backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200], // Button color matches CircleAvatar
                        ),
                        onPressed: () {
                          if (widget.index == createUserPlanList.value.length - 1) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const UserCongratulations(),
                              ),
                            );
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => UserExerciseRestTime(
                                  nextExercise: createUserPlanList.value[widget.index + 1],
                                ),
                              ),
                            );
                          }
                        },
                        child: const Icon(Icons.arrow_forward, size: 40), // Icon inside ElevatedButton
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

  // Alert dialog to confirm skipping today's exercise
  void alertExitTodayExercise(BuildContext context) {
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
              child: const Text('NO', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => HomePage(data: UsersData(name: '', age: '')),
                  ),
                  (Route<dynamic> route) => route.isFirst,
                );
              },
              child: const Text('YES', style: TextStyle(color: Colors.red)),
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
