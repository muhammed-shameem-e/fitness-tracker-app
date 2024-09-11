import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fullbody_workout/hive_services/categories_hive_things/categories_model_class.dart';
import 'package:fullbody_workout/user_management/workout_sections/new_category_things/show_new_categories_exercises.dart';
import 'package:fullbody_workout/user_management/workout_sections/rest_day_page.dart';
import 'package:hive/hive.dart';

class NewCategory30Days extends StatefulWidget {
  const NewCategory30Days({super.key, required this.category});

  final CategoriesModelClass category; // The category model passed as a parameter

  @override
  State<NewCategory30Days> createState() => _NewCategory30DaysState();
}

class _NewCategory30DaysState extends State<NewCategory30Days> {
  int _lastCompletedDay = 0; // Variable to track the last completed day

  @override
  void initState() {
    super.initState();
    _loadLastCompletedDay(); // Load the last completed day when the widget initializes
  }

  // Function to load the last completed day from Hive storage
  Future<void> _loadLastCompletedDay() async {
    final box = await Hive.openBox('newWorkoutBox'); // Open the Hive box
    setState(() {
      _lastCompletedDay = box.get('${widget.category.categoriesName}lastCompletednewDay', defaultValue: 0); // Get the value from Hive and update the state
    });
  }

  // Function to update the last completed day in Hive storage
  Future<void> _updateLastCompletedDay(int day) async {
    final box = await Hive.openBox('newWorkoutBox'); // Open the Hive box
    await box.put('${widget.category.categoriesName}lastCompletednewDay', day); // Store the updated day in Hive
    setState(() {
      _lastCompletedDay = day; // Update the state with the new day
    });
  }

  // Function to show an alert dialog for confirming a restart
  Future<void> alertRestart() async {
    showDialog(
      context: context,
      builder: (context) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark; // Check if the theme is dark mode
        final dialogBackgroundColor = isDarkMode ? Colors.grey[900] : Colors.white; // Set the background color based on the theme
        final textColor = isDarkMode ? Colors.white : Colors.black; // Set the text color based on the theme

        return AlertDialog(
          backgroundColor: dialogBackgroundColor,
          title: Text('Confirm Restart', style: TextStyle(color: textColor)),
          content: Text('Are you sure you want to restart your exercises from the beginning?', style: TextStyle(color: textColor)),
          actions: [
            // NO Button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog when NO is pressed
              },
              child: const Text('NO', style: TextStyle(color: Colors.blue)),
            ),
            // YES Button
            TextButton(
              onPressed: () async {
                await _updateLastCompletedDay(0); // Reset the completed day to 0
                setState(() {
                  _lastCompletedDay = 0; // Update the state to reflect the reset
                });
                Navigator.of(context).pop(); // Close the dialog when YES is pressed
              },
              child: const Text('YES', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark; // Check if the theme is dark mode
    final backgroundColor = isDarkMode ? Colors.black : Colors.white; // Set the background color based on the theme
    final appBarColor = isDarkMode ? Colors.grey[900] : Colors.white; // Set the app bar color based on the theme
    final textColor = isDarkMode ? Colors.white : Colors.black; // Set the text color based on the theme
    final progressBarColor = isDarkMode ? Colors.green[400] : Colors.green; // Set the progress bar color based on the theme

    return Scaffold(
      backgroundColor: backgroundColor, // Set the scaffold background color
      appBar: AppBar(
        title: Text('${widget.category.categoriesName} Section', style: TextStyle(fontWeight: FontWeight.w500, color: textColor)), // Set the app bar title
        backgroundColor: appBarColor, // Set the app bar background color
        actions: [
          IconButton(
            onPressed: alertRestart, // Trigger the alertRestart function when the restart icon is pressed
            icon: Icon(Icons.restart_alt, color: textColor), // Set the icon color based on the theme
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  // Display the category image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(widget.category.categoriesImage), // Load the image from file
                      width: double.infinity,
                      fit: BoxFit.fill,
                      height: 225,
                    ),
                  ),
                  // Display the progress information
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 180),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${30 - _lastCompletedDay} days left', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), // Display the remaining days
                            Text('${((_lastCompletedDay / 30) * 100).toStringAsFixed(0)}% completed', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), // Display the completion percentage
                          ],
                        ),
                        const SizedBox(height: 5),
                        LinearProgressIndicator(
                          value: _lastCompletedDay / 30, // Set the progress value
                          color: progressBarColor, // Set the progress bar color
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Display the list of days
              SizedBox(
                height: 400,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    bool isRestDay = (index + 1) % 7 == 0; // Determine if the day is a rest day
                    bool isCompleted = index < _lastCompletedDay; // Check if the day is already completed
                    bool isCurrentDay = index == _lastCompletedDay; // Check if the day is the current day

                    return GestureDetector(
                      onTap: () async {
                        if (isCompleted) {
                          // Show a snack bar if the day is already completed
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('You have already completed this day. Try to do the current day.', style: TextStyle(color: Colors.white)),
                              backgroundColor: progressBarColor,
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.all(20),
                            ),
                          );
                        } else if (isRestDay) {
                          // Navigate to RestDayPage if it's a rest day
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RestDayPage(
                                onComplete: () async {
                                  await _updateLastCompletedDay(index + 1); // Update the last completed day when rest day is completed
                                },
                              ),
                            ),
                          );
                        } else if (isCurrentDay) {
                          // Navigate to ShowCategoriesExerciseUserSide if it's the current day
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ShowCategoriesExerciseUserSide(
                                onComplete: () async {
                                  await _updateLastCompletedDay(index + 1); // Update the last completed day when exercise is completed
                                },
                                completedDay: index + 1,
                                category: widget.category,
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isCurrentDay
                              ? Colors.green // Highlight the current day
                              : isRestDay
                                  ? Theme.of(context).colorScheme.surface // Use surface color for rest day
                                  : Theme.of(context).colorScheme.surface, // Use surface color for regular day
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  isRestDay ? 'Rest Day' : 'Day ${index + 1}', // Display the day number or rest day
                                  style: TextStyle(
                                    color: isCurrentDay || isRestDay
                                        ? Theme.of(context).colorScheme.onSurface // Use onSurface color for text
                                        : Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                if (isCurrentDay && !isRestDay)
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => ShowCategoriesExerciseUserSide(
                                            onComplete: () async {
                                              await _updateLastCompletedDay(index + 1); // Update the last completed day when exercise is completed
                                            },
                                            completedDay: index + 1,
                                            category: widget.category,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(255, 216, 255, 217),
                                    
                                    ),
                                    child: const Text('Start'),
                                  ),
                               if (isCompleted)
                                  const Padding(
                                    padding: EdgeInsets.only(right: 30),
                                    child: Text(
                                      'Completed',
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 49, 105, 51),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) => const SizedBox(height: 10), // Add space between the day items
                  itemCount: 30, // Total days count
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
