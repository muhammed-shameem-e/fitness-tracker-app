import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/user_management/workout_sections/leg_30_days.dart';
import 'package:fullbody_workout/user_management/workout_sections/leg_things/leg_rest_time.dart';
import 'package:fullbody_workout/user_management/workout_sections/leg_things/legcongratulations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LegExerciseOne extends StatefulWidget {
  const LegExerciseOne({
    super.key,
    required this.index,
    required this.completedDay,
  });

  final int index;
  final int completedDay;

  @override
  State<LegExerciseOne> createState() => _LegExerciseOneState();
}

class _LegExerciseOneState extends State<LegExerciseOne> {
  bool isThumbDownPressed = false;
  bool isThumbUpPressed = false;

  final List<String> leg = [
    'assets/leg1.gif',
    'assets/leg2.gif',
    'assets/leg3.gif',
    'assets/leg4.gif',
    'assets/leg6.gif',
    'assets/leg7.gif',
    'assets/leg8.gif',
    'assets/leg9.gif',
  ];

  final List<String> names = [
    'Plank with both leg',
    'Mountain climber',
    'walking lungers',
    'Jump squat',
    'Glute bridge right leg',
    'Glute bridge left leg',
    'Lungers with both leg',
    'Body weight squat'
  ];

  final List<String> benefit = [
    'Strengthens the core, shoulders, and back; improves stability and endurance.',
    'Enhances cardiovascular endurance, core stability, and overall strength while improving agility.',
    'Builds lower body strength, improves balance, and enhances flexibility and coordination.',
    'Increases lower body power, boosts cardiovascular fitness, and enhances explosive strength.',
    'Targets the glutes, hamstrings, and lower back; improves hip stability and strength in the right leg.',
    'Similar to the right leg, but targets the left leg, enhancing glute and hamstring strength, and hip stability.',
    'Strengthens quads, hamstrings, and glutes; improves balance and coordination while enhancing overall lower body strength.',
    'The bodyweight squat strengthens the legs and core, improves mobility, and enhances functional movement without the need for equipment.'
  ];

  final List<int> numbers = [23, 11, 29, 15, 27, 19, 12, 30];

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Load saved preferences on initialization
  }

  Future<void> _loadPreferences() async {
    final save = await SharedPreferences.getInstance();
    setState(() {
      // Retrieve and set button states from SharedPreferences
      isThumbDownPressed = save.getBool('isThumbDownPressed${widget.index}') ?? false;
      isThumbUpPressed = save.getBool('isThumbUpPressed${widget.index}') ?? false;
    });
  }

  Future<void> _savePreferences() async {
    final save = await SharedPreferences.getInstance();
    // Save button states to SharedPreferences
    await save.setBool('isThumbDownPressed${widget.index}', isThumbDownPressed);
    await save.setBool('isThumbUpPressed${widget.index}', isThumbUpPressed);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final appBarColor = isDarkMode ? Colors.grey[900] : Colors.white;
    final iconColor = isDarkMode ? Colors.white : Colors.black;
    final buttonColor = isDarkMode ? Colors.grey[800] : Colors.green;
    final snackBarBackgroundColorLike = isDarkMode ? Colors.green[800] : Colors.green;
    final snackBarBackgroundColorDislike = isDarkMode ? Colors.red[800] : Colors.red;

    final int length = leg.length;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${names[widget.index]}', style: TextStyle(fontWeight: FontWeight.w500, color: iconColor)),
            const SizedBox(width: 5),
            Text('${widget.index + 1}/$length', style: TextStyle(color: Colors.grey[800], fontSize: 15)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _alertExitTodayExercise(context); // Show dialog for skipping workout
            },
            icon: Icon(Icons.exit_to_app_rounded, color: iconColor),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  child: Image.asset(leg[widget.index]), // Display exercise image
                ),
              ),
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
                          _savePreferences(); // Save the updated preferences
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              "Dislike noted! Let’s find something you enjoy more.",
                              style: TextStyle(color: Colors.white),
                            ),
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.all(20),
                            backgroundColor: snackBarBackgroundColorDislike,
                          ),
                        );
                      },
                      icon: Icon(Icons.thumb_down, color: isThumbDownPressed ? Colors.red : iconColor),
                    ),
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          isThumbUpPressed = !isThumbUpPressed;
                          isThumbDownPressed = false;
                          _savePreferences(); // Save the updated preferences
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              "You liked this exercise! Let's keep moving!",
                              style: TextStyle(color: Colors.white),
                            ),
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.all(20),
                            backgroundColor: snackBarBackgroundColorLike,
                          ),
                        );
                      },
                      icon: Icon(Icons.thumb_up, color: isThumbUpPressed ? Colors.green : iconColor),
                    ),
                  ],
                ),
              ),
              const Text(
                'Benefit of this exercise',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              Text(
                '${benefit[widget.index]}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(), // Makes the button circular
                      backgroundColor: isDarkMode
                          ? Colors.grey[800]
                          : const Color.fromARGB(255, 238, 248, 255), // Background color
                      padding: const EdgeInsets.all(20), // Adjusts size to match CircleAvatar radius
                      elevation: 0, // Ensures a flat appearance similar to CircleAvatar
                    ),
                    onPressed: () {
                      if (widget.index == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'There is no exercise. This is your first exercise.',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: buttonColor,
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.all(20),
                          ),
                        );
                      } else if (widget.index > 0) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LegExerciseOne(
                            index: widget.index - 1,
                            completedDay: widget.completedDay,
                          ),
                        ));
                      }
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 40,
                      color: iconColor, // Set icon color dynamically
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(), // Makes the button circular
                      backgroundColor: isDarkMode
                          ? Colors.grey[700]
                          : const Color.fromARGB(255, 255, 247, 235), // Background color
                      padding: const EdgeInsets.all(20), // Adjusts size to match CircleAvatar radius
                      elevation: 0, // Ensures a flat appearance similar to CircleAvatar
                    ),
                    onPressed: () {
                      // Add any onPressed functionality if needed, or leave it empty
                    },
                    child: Text(
                      '${numbers[widget.index]}',
                      style: TextStyle(
                        fontSize: 20,
                        color: iconColor, // Set text color dynamically
                      ),
                      textAlign: TextAlign.center, // Center-align the text
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(), // Makes the button circular
                      backgroundColor: isDarkMode
                          ? Colors.grey[800]
                          : const Color.fromARGB(255, 255, 233, 233), // Background color
                      padding: const EdgeInsets.all(20), // Adjusts size to match CircleAvatar radius
                      elevation: 0, // Ensures a flat appearance similar to CircleAvatar
                    ),
                    onPressed: () {
                      if (widget.index == leg.length - 1) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LegCongratulations(completedDay: widget.completedDay),
                        ));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LegRestTime(
                            index: widget.index + 1,
                            completedDay: widget.completedDay,
                          ),
                        ));
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward,
                      size: 40,
                      color: iconColor, // Set icon color dynamically
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

  void _alertExitTodayExercise(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        final dialogBackgroundColor = isDarkMode ? Colors.grey[900] : Colors.white;
        final textColor = isDarkMode ? Colors.white : Colors.black;

        return AlertDialog(
          backgroundColor: dialogBackgroundColor,
          content: Text('Are you sure you want to skip today\'s workout?', style: TextStyle(color: textColor)),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('NO', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Leg30Days()),
                );
              },
              child: const Text('YES', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _showAboutExercise(BuildContext context, String gif, String name) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        final textColor = isDarkMode ? Colors.white : Colors.black;

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  child: Image.file(File(gif)), // Display exercise image in bottom sheet
                ),
              ),
              Text(
                name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'When it comes to health, regular\nexercise is about as close to a\nmagic potion as you can get.',
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
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
                child: const Text('Close', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        );
      },
    );
  }
}
