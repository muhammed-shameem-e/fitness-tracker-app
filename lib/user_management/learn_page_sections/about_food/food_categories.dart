import 'package:flutter/material.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_food/14_pages.dart/cutting.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_food/14_pages.dart/endurance_training.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_food/14_pages.dart/functional_training.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_food/14_pages.dart/high_intensity_interval_training.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_food/14_pages.dart/lean_bulking.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_food/14_pages.dart/maintenance.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_food/14_pages.dart/maintenance_phase.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_food/14_pages.dart/off_season.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_food/14_pages.dart/periodization.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_food/14_pages.dart/pre_contest_preparation.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_food/14_pages.dart/recomposition.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_food/14_pages.dart/reverse_dieting.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_food/14_pages.dart/strength_training.dart';
import 'package:fullbody_workout/user_management/learn_page_sections/about_food/14_pages.dart/volume_training.dart';

class FoodCategories extends StatefulWidget {
  const FoodCategories({super.key});

  @override
  State<FoodCategories> createState() => _FoodCategoriesState();
}

class _FoodCategoriesState extends State<FoodCategories> {
  // List of training strategies
  final _trainingStrategies = [
    'Maintenance', 'Recomposition', 'Lean Bulking', 'Cutting', 'Off-Season', 
    'Pre-Contest Preparation', 'Reverse Dieting', 'Maintenance Phase', 
    'Volume Training', 'Strength Training', 'Endurance Training', 
    'Functional Training', 'Periodization', 'High-Intensity Interval Training (HIIT)'
  ];

  // Corresponding descriptions for each training strategy
  final _gymDescriptions = [
    'Maintain current body weight and composition.',
    'Simultaneously lose fat and gain muscle.',
    'Increase muscle mass with minimal fat gain.',
    'Reduce body fat while preserving muscle mass.',
    'Build strength and muscle mass in preparation for competition or a specific goal.',
    'Optimize physique for a competition or specific event.',
    'Gradually increase calorie intake after a period of dieting to avoid rapid weight gain.',
    'Stabilize after a bulking or cutting phase.',
    'Increase muscle hypertrophy through high training volume.',
    'Increase maximal strength and power.',
    'Improve cardiovascular fitness and muscular endurance.',
    'Improve overall functional capacity and performance.',
    'Structure training into cycles to optimize performance and recovery.',
    'Improve cardiovascular fitness and burn fat efficiently.',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Food Sections',
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
                // Navigate to the corresponding page based on the selected category
                switch (index) {
                  case 0:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Maintenance(heading: _trainingStrategies[index])));
                    break;
                  case 1:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Recomposition(heading: _trainingStrategies[index])));
                    break;
                  case 2:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LearnBulking(heading: _trainingStrategies[index])));
                    break;
                  case 3:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Cutting(heading: _trainingStrategies[index])));
                    break;
                  case 4:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => OffSeason(heading: _trainingStrategies[index])));
                    break;
                  case 5:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PreContestPreparation(heading: _trainingStrategies[index])));
                    break;
                  case 6:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReverseDieting(heading: _trainingStrategies[index])));
                    break;
                  case 7:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MaintenancePhase(heading: _trainingStrategies[index])));
                    break;
                  case 8:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => VolumeTraining(heading: _trainingStrategies[index])));
                    break;
                  case 9:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => StrengthTraining(heading: _trainingStrategies[index])));
                    break;
                  case 10:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EnduranceTraining(heading: _trainingStrategies[index])));
                    break;
                  case 11:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => FunctionalTraining(heading: _trainingStrategies[index])));
                    break;
                  case 12:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Periodization(heading: _trainingStrategies[index])));
                    break;
                  case 13:
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HighIntensityIntervalTraining(heading: _trainingStrategies[index])));
                    break;
                }
              },
              child: Container(
                height: 150,
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
                        _trainingStrategies[index],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _gymDescriptions[index],
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
          itemCount: _trainingStrategies.length,
        ),
      ),
    );
  }
}
