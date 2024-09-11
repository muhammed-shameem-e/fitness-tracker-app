import 'package:flutter/material.dart';
import 'package:fullbody_workout/user_management/workout_sections/abs_30_days.dart';
import 'package:fullbody_workout/user_management/workout_sections/abs_things/abs_congratulations.dart';
import 'package:fullbody_workout/user_management/workout_sections/short_codelist/abs_exercises_lists.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AbsExerciseOne extends StatefulWidget {
  const AbsExerciseOne({
    super.key,
    required this.index,
    required this.completedDay,
  });

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
      isThumbDownPressed = save.getBool('isThumbDownPressed${widget.index}') ?? false;
      isThumbUpPressed = save.getBool('isThumbUpPressed${widget.index}') ?? false;
    });
  }

  // Method to save the like/dislike preferences
  Future<void> savePreferences() async {
    final save = await SharedPreferences.getInstance();
    await save.setBool('isThumbDownPressed${widget.index}', isThumbDownPressed);
    await save.setBool('isThumbUpPressed${widget.index}', isThumbUpPressed);
  }

  @override
  Widget build(BuildContext context) {
    final int length = AbsExerciseData.abs.length;
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
            Text('${AbsExerciseData.names[widget.index]}', style: const TextStyle(fontWeight: FontWeight.w500)),
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
                  child: Image.asset(AbsExerciseData.abs[widget.index]),
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
                        // showAboutExercise(context, widget.exercise.absExerciseGif, widget.exercise.absExerciseName,widget.exercise.absExerciseBenefit);
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
                '${AbsExerciseData.benefits[widget.index]}',
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
                      'x${AbsExerciseData.numbers[widget.index]}',
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
                      if (widget.index == AbsExerciseData.abs.length - 1) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AbsCongratulations(completedDay: widget.completedDay),
                        ));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AbsExerciseOne(
                            index: widget.index + 1,
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
  void alertExitTodayExercise(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Exit Today\'s Exercise?'),
        content: const Text('Are you sure you want to exit today\'s exercise session?'),
        actions: [
          // Cancel button
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          // Exit button
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Abs30Days()));
            },
            child: const Text('Exit'),
          ),
        ],
      );
    },
  );
}

}

