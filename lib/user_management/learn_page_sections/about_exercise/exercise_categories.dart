import 'package:flutter/material.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_exercise/9_pages.dart/back.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_exercise/9_pages.dart/cardio.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_exercise/9_pages.dart/core.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_exercise/9_pages.dart/flexibility_and_mobility.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_exercise/9_pages.dart/fullbody.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_exercise/9_pages.dart/functional.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_exercise/9_pages.dart/lower_body.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_exercise/9_pages.dart/power_and_plyometric.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_exercise/9_pages.dart/upper_body.dart';

class ExerciseCategories extends StatefulWidget {
  const ExerciseCategories({super.key});

  @override
  State<ExerciseCategories> createState() => _ExerciseCategoriesState();
}

class _ExerciseCategoriesState extends State<ExerciseCategories> {
  // List of exercise types
  final _exerciseTypes = [
    "Upper Body Exercises", "Lower Body Exercises", "Core Exercises", 
    "Back Exercises", "Cardio Exercises", "Full Body Exercises", 
    "Flexibility and Mobility Exercises", "Functional Training", 
    "Power and Plyometric Exercises"
  ];

  // Corresponding explanations for each exercise type
  final _exerciseExplanations = [
    "Target the muscles in the chest, shoulders, and arms, helping to build strength and muscle mass in the upper body.",
    "Focus on the legs, glutes, and calves, promoting muscle growth and strength in the lower body.",
    "Strengthen the muscles in the abdomen, obliques, and lower back, crucial for stability and balance.",
    "Work on the upper and lower back muscles, improving posture and overall back strength.",
    "Increase heart rate and improve cardiovascular endurance through activities like running, cycling, and jump rope.",
    "Engage multiple muscle groups simultaneously, providing a comprehensive workout that builds overall strength and fitness.",
    "Enhance range of motion and prevent injuries by stretching and performing movements that increase flexibility and joint mobility.",
    "Focus on exercises that improve balance, coordination, and agility, often mimicking everyday movements.",
    "Develop explosive strength and power through high-intensity movements like box jumps and medicine ball throws."
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Exercises Sections',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.separated(
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onTap: () {
                // Navigate to the corresponding page based on the selected exercise type
                switch (index) {
                  case 0:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpperBody()));
                    break;
                  case 1:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LowerBody()));
                    break;
                  case 2:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Core()));
                    break;
                  case 3:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Back()));
                    break;
                  case 4:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Cardio()));
                    break;
                  case 5:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => FullBody()));
                    break;
                  case 6:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => FlexibilityMobility()));
                    break;
                  case 7:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Functional()));
                    break;
                  case 8:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PowerPlyometric()));
                    break;
                }
              },
              child: Container(
                height: 185,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDarkMode 
                    ? const Color.fromARGB(255, 38, 38, 38) 
                    : const Color.fromARGB(255, 248, 238, 238),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        _exerciseTypes[index],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _exerciseExplanations[index],
                        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color,)
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return const SizedBox(height: 10);
          },
          itemCount: _exerciseTypes.length,
        ),
      ),
    );
  }
}
